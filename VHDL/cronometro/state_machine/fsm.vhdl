library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.data_structs.all;

entity fsm is
    port(
        --! Input
    	in_ports : in FSM_In_Ports;
        --! Output
    	out_ports : out FSM_Out_Ports
    );
end entity fsm;

architecture RTL of fsm is
    --! @type	stateType
    --!
    --! @brief	Controls wether the counter is null, counting or stopped
    --!
    --! nill	Stopped
    --! count	Counting
    --! stop	Stopped
    type stateType is (nill, count, stop);
    signal state : stateType;

    signal button_states : Buttons := ('0', '0', '0');		--! Current button state = (in_buttons and (not late_buttons))
    signal last_button_states : Buttons := ('0', '0', '0');	--! Previous button states, late by one clock cycle

begin

    --! State Transition Handler
    fsm : process(in_ports.clk, in_ports.button.rst) is
    begin
        if in_ports.button.rst = '1' then
            state <= nill;
        elsif rising_edge(in_ports.clk) then
            case state is
                when nill =>
                    if button_states.Start_Stop = '1' then
                        state <= count;
                    end if;
                when count =>
                    if button_states.Start_Stop = '1' then
                        state <= stop;
                    end if;
                when stop =>
                    state <= nill;
            end case;
        end if;
    end process;

    --! Moore process
    moore : process(state) is
    begin
        case state is
            when nill =>
                out_ports.enable <= '0';
            when count =>
                out_ports.enable <= '1';
            when stop =>
                out_ports.enable <= '0';
        end case;
    end process;

    --! Mealy process
    mealy : process(state, in_ports.button.Store_Partial) is
    begin
        case state is
            when nill =>
                out_ports.partial <= '0';
            when count =>
                out_ports.partial <= '0';
                if button_states.Store_Partial = '1' then
                    out_ports.partial <= '1';
                end if;
            when stop =>
                out_ports.partial <= '0';
                if button_states.Store_Partial = '1' then
                    out_ports.partial <= '1';
                end if;
        end case;
    end process;

    --! Input Handler
    button_update : process(in_ports.clk) is
    begin
        if rising_edge(in_ports.clk) then
            if (in_ports.button.Start_Stop = '1' and last_button_states.Start_Stop = '0') then
                button_states.Start_Stop <= '1';
            elsif (in_ports.button.Store_Partial = '1' and last_button_states.Store_Partial = '0') then
                button_states.Store_Partial <= '1';
            else
                button_states.Start_Stop <= '0';
                button_states.Store_Partial <= '0';
            end if;
            last_button_states <= in_ports.button;
        end if;
    end process;

end architecture RTL;
