/**
 * @file main.cpp
 * @author Emanuel Staub Araldi
 * @brief 
 * @version 0.1
 * @date 2025-04-29
 * 
 * @copyright Copyright (c) 2025
 * 
 */

#include <iostream>
#include <systemc.h>

using namespace std;

/**
 * @brief Construct a new sc module object for an asynchronous mux
 * 
 * @param [in-bool]		select 		Select which data channel is sent to output
 * @param [in-uint8]	dataA		Default Data Channel (Selected with select==0)
 * @param [in-uint8]	dataB		Non-Default Data Channel (Selected with select==1)
 * @param [out-uint8]	dataOut		Data Output
 */
SC_MODULE(Mux_Async){
	sc_in<bool> select;
	///
	sc_in<uint8_t> dataA;
	sc_in<uint8_t> dataB;
	///
	sc_out<uint8_t> dataOut;

	void process(){
		cout << "(MUX_ASYNC) [" << sc_time_stamp() << "] process called" << endl;
		dataOut = select ? dataB : dataA;
	}

	SC_CTOR(Mux_Async){
		SC_METHOD(process);
		sensitive << dataA << dataB << select;
	}
};

int sc_main (int argc, char* argv[]) {

	cout << "Hello SystemC!" << endl;

	sc_signal<bool>		_sel;
	sc_signal<uint8_t>  _a, _b;

	sc_signal<uint8_t>  _dataOut;
	Mux_Async mux("Mux_Async");

	mux.dataA(_a); mux.dataB(_b); mux.select(_sel);
	mux.dataOut(_dataOut);

	sc_set_time_resolution(1, SC_NS);

	sc_trace_file *wf = sc_create_vcd_trace_file("trace");
	// Dump the desired signals
	sc_trace(wf, _a, "a");
	sc_trace(wf, _b, "b");
	sc_trace(wf, _sel, "select");
	sc_trace(wf, _dataOut, "dataOut");

	cout << "@" << sc_time_stamp() << " Starting simulation\n" << endl;

	sc_uint<8> dA = rand();
	sc_uint<8> dB = rand();
	sc_uint<1> sel;
	for(int i = 0; i < 8; i++){
		_a.write(dA);
		_b.write(dB);
		_sel.write(dA[0]);
		dA = rand();
	 	dB = rand();
		sc_start(1, SC_NS);
	}

	cout << "@" << sc_time_stamp() << " Terminating simulation\n" << endl;
	sc_close_vcd_trace_file(wf);
	
	return 0;
}
