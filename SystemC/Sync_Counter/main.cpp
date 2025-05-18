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
 * @brief Construct a new sc module object for an asynchronous count
 * 
 * @param [in-clock]	clock 		Sensitive to Rising Edge
 * @param [in-bool]		enable		Enables 'clock'
 * @param [in-bool]		load		Loads dataIn Into 'count'
 * @param [in-uint8]	data		Input Data to be Loaded
 * @param [out-uint8]	dataOut		Data Output
 */
SC_MODULE(Sync_Counter){
	/// In Ports
	sc_in_clk			clock;
	sc_in<bool>			enable;
	sc_in<bool>			load;
	sc_in<sc_uint<8>>	dataIn;
	/// Out Ports
	sc_out<sc_uint<8>> 	dataOut;
	/// Vars
	sc_uint<8> count;

	void process(){
		cout << "(Sync_Counter) [" << sc_time_stamp() << "] process called" << endl;
		if (enable){
			dataOut = ++count; // If count++, will take a cycle too long to update loaded data
			if (load){
				count = dataIn;
				dataOut = count;
			}
		}
	}

	SC_CTOR(Sync_Counter){
		SC_METHOD(process);
		sensitive << clock.pos();
		count = 0;
	}
};

int sc_main (int argc, char* argv[]) {

	cout << "Hello SystemC!" << endl;

	sc_signal<bool>		_clock;
	sc_signal<bool>		_enable;
	sc_signal<bool> 	_load;

	sc_signal<sc_uint<8> >  _count;
	sc_signal<sc_uint<8> >  _dataOut;
	sc_signal<sc_uint<8> >  _in;
	Sync_Counter count("Sync_Counter");

	count.clock(_clock);
	count.enable(_enable);
	count.load(_load);

	count.dataOut(_dataOut);
	count.dataIn(_in);

	sc_set_time_resolution(1, SC_NS);

	sc_trace_file *wf = sc_create_vcd_trace_file("trace");
	// Dump the desired signals
	sc_trace(wf, _clock, "clock");
	sc_trace(wf, _enable, "enable");
	sc_trace(wf, _load, "load");

	sc_trace(wf, _in, "dataIn");
	sc_trace(wf, _dataOut, "dataOut");


	cout << "[" << sc_time_stamp() << "] Starting simulation\n" << endl;

	sc_uint<1> clk = 0;
	sc_uint<1> enb = 1;
	sc_uint<1> lod = 0;
	sc_uint<8> dat = rand();
	for(int i = 0; i < 100; i++){
		_clock.write(clk);
		_enable.write(enb);
		_in.write(dat);
		_load.write(lod);

		if (i%5==0)
			dat = rand();
		enb = dat[0];
		lod = dat[1];

		clk = not clk;
		sc_start(1, SC_NS);
	}

	cout << "[" << sc_time_stamp() << "] Terminating simulation\n" << endl;
	sc_close_vcd_trace_file(wf);
	
	return 0;
}
