library IEEE;
use IEEE.std_logic_1164.all;

package data_structs is
	--! State Control Buttons
	type Buttons is record
		rst : std_logic;
		Start_Stop : std_logic;
		Store_Partial : std_logic;
	end record Buttons;

	--! Input Ports
	type FSM_In_Ports is record
		clk : std_logic; --! Clock
		button : Buttons;   --! Input Buttons
	end record FSM_In_Ports;

	--! Output Ports
	type FSM_Out_Ports is record
		enable  : std_logic; --! Enable Clock for Counter
		partial : std_logic; --! Tell Counter to Store Partial Time
	end record FSM_Out_Ports;

end package data_structs;
