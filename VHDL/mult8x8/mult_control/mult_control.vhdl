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

--! @brief Handles Control Logic for an 8x8 Multiplier
entity mult_control is
    port(
        --- Inputs ---
        clk       : in  std_logic;      --! Clock
        reset_a   : in  std_logic;      --! Reset State Machine
        start     : in  std_logic;      --! Starts Multiplication
        count     : in  unsigned(1 downto 0); --! Counts Clockcycles since beggining
        --- Outputs ---
        input_sel : out std_logic_vector(1 downto 0); --! Selects 'high' or 'low' bits on mux
        shift_sel : out std_logic_vector(1 downto 0); --! Selects how many bits to shift
        state_out : out unsigned(2 downto 0); --! Outputs state (DEBUG)
        done      : out std_logic;      --! Flags end of operation
        clk_ena   : out std_logic;      --! Enables Clock for other components
        sclr_n    : out std_logic       --! Clears Output Register
    );
end entity mult_control;

architecture RTL of mult_control is
    type stateType is (IDLE, LSB, MID, MSB, CALC_DONE, ERR);
    signal state : stateType;           --! Step of Multiplication
begin
    st : process(clk, reset_a) is       --! Handle State Transition
    begin
        if reset_a = '1' then
            state <= IDLE;
        elsif rising_edge(clk) then
            case state is
                when IDLE =>
                    if start = '1' then
                        state <= LSB;
                    elsif start = '0' then
                        state <= IDLE;
                    end if;
                when LSB =>
                    if start = '0' and count = "00" then
                        state <= MID;
                    else
                        state <= ERR;
                    end if;
                when MID =>
                    if start = '0' and count = "01" then
                        state <= MID;
                    elsif start = '0' and count = "10" then
                        state <= MSB;
                    else
                        state <= ERR;
                    end if;
                when MSB =>
                    if start = '0' and count = "11" then
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
    end process;

    ctl : process(state, count, start)         --! Control Logic
    begin
        input_sel <= "00";
        shift_sel <= "00";
        case state is
            when IDLE =>
		if start = '0' then
                	done    <= '0';
                	clk_ena <= '0';
                	sclr_n  <= '1';
		elsif start = '1' then
                	done    <= '0';
                	clk_ena <= '1';
                	sclr_n  <= '0';
		end if;
            when LSB =>
		if (start='0') and (count="00") then
        		input_sel <= "00";
        		shift_sel <= "00";
                	done    <= '0';
                	clk_ena <= '1';
                	sclr_n  <= '1';
		else
                	done    <= '0';
                	clk_ena <= '1';
                	sclr_n  <= '0';
		end if;
            when MID =>
                if (start = '0') and (count = "01") then
                    	input_sel <= "01";  -- Low 'a' and High 'b'
                    	shift_sel <= "01";  -- Shift 4 bits
                	done      <= '0';
                	clk_ena   <= '1';
                	sclr_n    <= '1';
	    	elsif (start = '0') and (count = "10") then
                    	input_sel <= "10";  -- High 'a' and Low 'b'
                    	shift_sel <= "01";  -- Shift 4 bits
                	done      <= '0';
                	clk_ena   <= '1';
                	sclr_n    <= '1';
		else
                	done      <= '0';
                	clk_ena   <= '0';
                	sclr_n    <= '1';

                end if;
            when MSB =>
		if (start = '0') and (count = "11") then
			input_sel <= "11"
			shift_sel <= "10"
                	done      <= '0';
                	clk_ena   <= '1';
                	sclr_n    <= '1';
		else
                	done      <= '0';
                	clk_ena   <= '0';
                	sclr_n    <= '1';
		end if;
            when CALC_DONE =>
		if start = '0' then
                	done      <= '1';
                	clk_ena   <= '0';
                	sclr_n    <= '1';
		else
                	done      <= '0';
                	clk_ena   <= '0';
                	sclr_n    <= '1';
		end if;
            when ERR =>
		if start = '0' then
                	done    <= '0';
                	clk_ena <= '0';
                	sclr_n  <= '1';
		end if;
        end case;
    end process;

    sto : process(state)                --! Sends state value out
    begin
        case state is
            when IDLE =>
                state_out <= to_unsigned(0, 3);
            when LSB =>
                state_out <= to_unsigned(1, 3);
            when MID =>
                state_out <= to_unsigned(2, 3);
            when MSB =>
                state_out <= to_unsigned(3, 3);
            when CALC_DONE =>
                state_out <= to_unsigned(4, 3);
            when ERR =>
                state_out <= to_unsigned(5, 3);
        end case;
    end process;

end architecture RTL;
