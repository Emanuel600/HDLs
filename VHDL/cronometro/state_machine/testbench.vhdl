library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.data_structs.all;

entity test_bench is
end test_bench;

architecture Test of test_bench is
    -- Input
    signal tb_in_ports  : FSM_In_Ports;
    -- Output
    signal tb_out_ports : FSM_Out_Ports;
begin
    dut : entity work.fsm
        port map(
        in_ports => tb_in_ports,
        out_ports => tb_out_ports
        );

    clk: process
    begin
        tb_in_ports.clk <= '0';
        wait for 500 us;
        tb_in_ports.clk <= '1';
        wait for 500 us;
    end process clk;

    tb_in_ports.button.rst <= '0';
    tb_in_ports.button.Start_Stop <= '0', '1' after 550 us, '0' after 3 ms;
    tb_in_ports.button.Store_Partial <= '0', '1' after 3 ms;

end architecture Test;
