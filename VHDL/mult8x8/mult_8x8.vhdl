--!
--! @file mult_8x8.vhdl
--! @author Emanuel S Araldi
--! @brief Multiplies two 8-bit numbers together
--! @version 1.1
--! @date 2025-05-17
--!
--! @copyright Copyright (c) 2025
--!
-- Standard Libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- Project Libraries
use work.adder;
use work.counter;
use work.mult;
use work.mux;
use work.reg16;
use work.seven_segment_cntrl;
use work.shifter;
use work.mult_control;

entity mult8x8 is
    port(
        -- Inputs
        clk            : in  std_logic;
        reset_a        : in  std_logic;
        start          : in  std_logic;
        dataa          : in  unsigned(7 downto 0);
        datab          : in  unsigned(7 downto 0);
        -- Outputs
        done_flag      : out std_logic;
        product8x8_out : out unsigned(15 downto 0);
        seg_a          : out std_logic;
        seg_b          : out std_logic;
        seg_c          : out std_logic;
        seg_d          : out std_logic;
        seg_e          : out std_logic;
        seg_f          : out std_logic;
        seg_g          : out std_logic;
        seg_dp         : out std_logic
    );
end entity mult8x8;

architecture RTL of mult8x8 is
    signal aout    : unsigned(3 downto 0);
    signal bout    : unsigned(3 downto 0);
    signal product : unsigned(7 downto 0);

    signal sel : std_logic_vector(1 downto 0);

    signal count : unsigned(1 downto 0);

    signal shift     : std_logic_vector(1 downto 0);
    signal state_out : unsigned(2 downto 0);
    signal clk_ena   : std_logic;
    signal sclr_n    : std_logic;

    signal shift_out : unsigned(15 downto 0);

    signal product8x8 : unsigned(15 downto 0);
    signal sum        : unsigned(15 downto 0);

    signal not_start      : std_logic;
    signal state_out_wire : unsigned(3 downto 0);
begin

    mult44 : entity mult
        generic map(
            SIZE => 4
        )
        port map(
            dataa   => aout,
            datab   => bout,
            product => product
        );

    mux41 : entity mux
        generic map(
            SIZE => 4
        )
        port map(
            mux_in_a => dataa(3 downto 0),
            mux_in_b => dataa(7 downto 4),
            mux_sel  => sel(1),
            mux_out  => aout
        );

    mux42 : entity mux
        generic map(
            SIZE => 4
        )
        port map(
            mux_in_a => datab(3 downto 0),
            mux_in_b => datab(7 downto 4),
            mux_sel  => sel(0),
            mux_out  => bout
        );

    inv_start : process(start)
    begin
        not_start <= not start;
    end process;

    cntr : entity counter
        port map(
            clk       => clk,
            aclr_n    => not_start,
            count_out => count
        );

    ctrl : entity mult_control
        port map(
            clk       => clk,
            reset_a   => reset_a,
            start     => start,
            count     => count,
            input_sel => sel,
            shift_sel => shift,
            state_out => state_out,
            done      => done_flag,
            clk_ena   => clk_ena,
            sclr_n    => sclr_n
        );

    shft : entity shifter
        generic map(
            SIZE => 8
        )
        port map(
            input       => product,
            shift_cntrl => shift,
            shift_out   => shift_out
        );

    addr : entity adder
        generic map(
            SIZE => 16
        )
        port map(
            dataa => shift_out,
            datab => product8x8,
            sum   => sum
        );

    reg : entity reg16
        port map(
            clk     => clk,
            sclr_n  => sclr_n,
            clk_ena => clk_ena,
            datain  => sum,
            reg_out => product8x8
        );

    sto : process(state_out)
    begin
        state_out_wire <= "0" & state_out;
    end process;

    sevseg : entity seven_segment_cntrl
        port map(
            input   => state_out_wire,
            segs(0) => seg_a,
            segs(1) => seg_b,
            segs(2) => seg_c,
            segs(3) => seg_d,
            segs(4) => seg_e,
            segs(5) => seg_f,
            segs(6) => seg_g,
            segs(7) => seg_dp
        );

    process(clk)
    begin
        if rising_edge(clk) then
            product8x8_out <= product8x8;
        end if;
    end process;

end architecture RTL;
