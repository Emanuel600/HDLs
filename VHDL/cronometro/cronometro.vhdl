library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--! Entities
use work.fsm;
use work.reg16;
use work.timer;
use work.counter;
use work.seven_segment;
--! In ports
use work.data_structs; --> Used for input buttons
entity cronometro is
    port(
        clk : in std_logic; --> Clock from PLL
        buttons : in data_structs.Buttons; --> Input buttons
        enable : in std_logic; --> Enable clock divider
        -- Output from first register
        sev_seg_reg : out seven_segment.reg_seven_seg
    );
end entity cronometro;

architecture RTL of cronometro is
    signal clk_1k   : std_logic; -- 1 KHz clock
    signal fsm_ctl  : data_structs.FSM_Out_Ports; -- FSM control signal
    signal reg_out  : unsigned(15 downto 0);
    signal time_out : unsigned(15 downto 0);
begin
    clk_divider : entity work.counter
        generic map(
            top => 500
        )
        port map(
            clk     => clk,
            rst     => buttons.rst,
            enable  => enable,
            out_clk => clk_1k
        );
    

    state_machine : entity work.fsm
        port map(
            in_ports.clk  => clk_1k,
            in_ports.button => buttons,
            out_ports => fsm_ctl
        );

    timer_e : entity work.timer
        port map(
            clk      => clk_1k,
            rst      => buttons.rst,
            FSM      => fsm_ctl,
            time_out => time_out
        );
    
    reg : entity work.reg16
        port map(
            clk     => clk,
            sclr_n  => buttons.rst,
            clk_ena => fsm_ctl.enable,
            datain  => time_out,
            reg_out => reg_out
        );

    send_to_seven_seg : process(reg_out) is
    begin
        sev_seg_reg <= seven_segment.register_to_seven_segment(reg_out);
    end process;
    

end architecture RTL;
