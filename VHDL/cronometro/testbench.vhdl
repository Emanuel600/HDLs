library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.data_structs;
use work.seven_segment;

entity test_bench is
end test_bench;

architecture Test of test_bench is
    signal tb_clk : std_logic;
    signal tb_buttons : data_structs.Buttons;
    signal tb_enable : std_logic := '1';
    signal tb_sev_seg_reg1 : seven_segment.reg_seven_seg;
    signal tb_sev_seg_reg2 : seven_segment.reg_seven_seg;
begin
    dut : entity work.cronometro
        port map(
            clk          => tb_clk,
            buttons      => tb_buttons,
            enable       => tb_enable,
            sev_seg_reg1 => tb_sev_seg_reg1,
            sev_seg_reg2 => tb_sev_seg_reg2
        );

    clk: process
    begin
        tb_clk <= '0';
        wait for 500 ns;
        tb_clk <= '1';
        wait for 500 ns;
    end process clk;

    tb_buttons.rst <= '0', '1' after 6.7 ms, '0' after 6.9 ms;
    tb_buttons.Start_Stop <= '0', '1' after 550 us, '0' after 3 ms;
    tb_buttons.Store_Partial <= '0', '1' after 3 ms;
    
end architecture Test;
