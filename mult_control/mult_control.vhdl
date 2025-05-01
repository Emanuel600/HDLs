--!
--! @file mult_control.vhdl
--! @author Emanuel S Araldi
--! @brief Logic to Control Muxes and Shifters for an 8x8 multiplier
--! @version 0.2
--! @date 2025-04-29
--!
--! @copyright Copyright (c) 2025
--!

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_control is
    port(
        --- Inputs ---
        clk     : in std_logic;
        reset_a : in std_logic;
        start   : in std_logic;
        count   : in unsigned(1 downto 0);
        --- Outputs ---
        input_sel   : out std_logic_vector(1 downto 0);
        shift_sel   : out unsigned(1 downto 0);
        state_out   : out unsigned(2 downto 0);
        done        : out std_logic;
        clk_ena     : out std_logic;
        sclr_n      : out std_logic
    );
end entity mult_control;

architecture RTL of mult_control is
    type stateType is (IDLE, LSB, MID, MSB, CALC_DONE, ERR);
    signal state : stateType;
begin
    st: process(clk) is -- Handle State Transition
    begin
        if rising_edge(clk) then
            if reset_a = '1' then
                state <= IDLE;
            else
                case state is
                    when IDLE =>
                        done    <= '0';
                        clk_ena <= '0';
                        sclr_n  <= '1';
                        if start='1' then
                            state <= LSB;
                        elsif start = '0' then
                            state <= IDLE;
                        end if;
                    when LSB =>
                        done    <= '0';
                        clk_ena <= '1';
                        sclr_n  <= '0';
                        if start='0' and count = "00" then
                            state <= MID;
                        else
                            state <= ERR;
                        end if;
                    when MID =>
                        done    <= '0';
                        clk_ena <= '1';
                        sclr_n  <= '1';
                        if start='0' and count = "01" then
                            state <= MID;
                        elsif start='0' and count ="10" then
                            state <= MSB;
                        else
                            state <= ERR;
                        end if;
                    when MSB =>
                        done    <= '0';
                        clk_ena <= '1';
                        sclr_n  <= '1';
                        if start='0' and count="11" then
                            state <= CALC_DONE;
                        else
                            state <= ERR;
                        end if;
                    when CALC_DONE =>
                        if start = '0' then
                            state <= IDLE;
                        else
                            state <= ERR;
                        end if;
                    when ERR =>
                        if start = '0' then
                            state <= ERR;
                        elsif start = '1' then
                            state <= LSB;
                        end if;
                end case;
            end if;
        end if;
    end process;

    mux_sel: process(state) -- Mux Control - Selects Either High or Low Bits on 'dataa' and 'datab'
    begin
        case state is
            when IDLE =>
                null;
            when LSB =>
                input_sel <= "00"; -- Low 'a' and 'b'
            when MID =>
                input_sel <= "01"; -- Low 'a' and High 'b'
            when MSB =>
                input_sel <= "10"; -- High 'a' and Low 'b'
            when CALC_DONE =>
                input_sel <= "11"; -- High 'a' and 'b'
            when ERR =>
                null;
        end case;
    end process;

    sft_sel: process(state) -- Shift Control, Shifts by 0, 4 or 8 bits
    begin
        case state is
            when IDLE =>
                null;
            when LSB =>
                shift_sel <= "00"; -- No shift
            when MID =>
                shift_sel <= "01"; -- Shift 4
            when MSB =>
                shift_sel <= "01"; -- Shift 4
            when CALC_DONE =>
                shift_sel <= "10"; -- Shift 8
            when ERR =>
                null;
        end case;
    end process;

    sto: process(state) -- Output
    begin
        case state is
            when IDLE =>
                null;
            when LSB =>
                null;
            when MID =>
                null;
            when MSB =>
                null;
            when CALC_DONE =>
                null;
            when ERR =>
                null;
        end case;
    end process;

    don: process(state) -- Done Flag
    begin
        case state is
            when IDLE =>
                null;
            when LSB =>
                null;
            when MID =>
                null;
            when MSB =>
                null;
            when CALC_DONE =>
                null;
            when ERR =>
                null;
        end case;
    end process;

end architecture RTL;
