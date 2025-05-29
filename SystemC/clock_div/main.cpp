/**
 * @file main.cpp
 * @author Emanuel Staub Araldi
 * @brief 
 * @version 0.1
 * @date 2025-05-29
 * 
 * @copyright Copyright (c) 2025
 * 
 */

#include "sysc/communication/sc_clock_ports.h"
#include <iostream>
#include <systemc.h>

using namespace std;

/**
 * @brief Construct a new sc module object for an asynchronous count
 * 
 * @param [in-clock]	clock 		Sensitive to Rising Edge
 * @param [in-bool]	enable		Enables 'clock'
 * @param [out-uint8]	clock_out	Output Clock
 */
SC_MODULE(clock_div){
	/// In Ports
	sc_in_clk		clock;
	sc_in<bool>		enable;
	/// Out Ports
	sc_out<bool> 		clock_out;

	void process(){
		cout << "(clock_div) [" << sc_time_stamp() << "] process called" << endl;
		if (enable){
			clock_out = not clock_out;// If count++, will take a cycle too long to update loaded data
		}
	}

	SC_CTOR(clock_div){
		SC_METHOD(process);
		sensitive << clock.pos();
	}
};

SC_MODULE(counter){
	/// In Ports
	sc_in_clk		clock;
	sc_in<bool>		enable;
	/// Out Ports
	sc_out<bool>		trigger; /// Toggles when count = top
	/// vars
	sc_uint<10> 		count;
	const sc_uint<10>	top = 1000;

	void process(){
		cout << "(counter) [" << sc_time_stamp() << "] process called" << endl;
		if (not enable){
			cout << "(counter) <| ENABLE OFF |>" << endl;
			return;
		}
		count = count + 1;
		if (count == top) {
			cout << "(counter) <| TOP REACHED |>" << endl;
			count = 0;
			trigger = not trigger;
		} else{
			cout << "(counter) <| INCREMENT |> [counter = " << count << " ]" << endl;
		}
	}

	SC_CTOR(counter){
		SC_METHOD(process);
		sensitive << clock.pos();
		count = 0;
	}
};

int sc_main (int argc, char* argv[]) {

	cout << "Hello SystemC!" << endl;

	sc_signal<bool>	_clock;
	sc_signal<bool>		_enable;
	sc_signal<bool>		_clock_out1;
	sc_signal<bool>		_clock_out2;
	sc_signal<bool>		_clock_out3;
	sc_signal<bool>		_clock_out4;
	sc_signal<bool>		_clock_out5;

	sc_signal<bool> 	_trigger;
	/**
	clock_div div1("Clock_Div_1");
	clock_div div2("Clock_Div_2");
	clock_div div3("Clock_Div_3");
	clock_div div4("Clock_Div_4");
	clock_div div5("Clock_Div_5");

	div1.clock(_clock);
	div1.enable(_enable);
	div1.clock_out(_clock_out1);

	div2.clock(_clock_out1);
	div2.enable(_enable);
	div2.clock_out(_clock_out2);

	div3.clock(_clock_out2);
	div3.enable(_enable);
	div3.clock_out(_clock_out3);

	div4.clock(_clock_out3);
	div4.enable(_enable);
	div4.clock_out(_clock_out4);

	div5.clock(_clock_out4);
	div5.enable(_enable);
	div5.clock_out(_clock_out5);
	*/

	counter count("Counter");
	count.clock(_clock);
	count.enable(_enable);
	count.trigger(_trigger);

	sc_set_time_resolution(100, SC_NS);

	sc_trace_file *wf = sc_create_vcd_trace_file("trace");
	// Dump the desired signals
	sc_trace(wf, _clock, "clock");
	sc_trace(wf, _enable, "enable");
	sc_trace(wf, _trigger, "clock_div_out");


	_enable.write(true);
	sc_uint<1> clk = 1;

	cout << "[" << sc_time_stamp() << "] Starting simulation\n" << endl;

	for (size_t i = 0; i < 20000; i++) {
		_clock.write(clk);
		clk = not clk;
		sc_start(500, SC_NS);
	}

	cout << "[" << sc_time_stamp() << "] Terminating simulation\n" << endl;
	sc_close_vcd_trace_file(wf);
	
	return 0;
}
