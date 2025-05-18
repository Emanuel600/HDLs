/**
 * @file main.cpp
 * @author Emanuel Staub Araldi
 * @brief Implements a simple, 8-bit memory cell
 * @version 0.1
 * @date 2025-05-06
 * 
 * @copyright Copyright (c) 2025
 * 
 */

#include <iostream>
#include <systemc.h>

using namespace std;

/**
 * @brief Construct a new sc module object for an asynchronous mem
 * 
 * @param [in-clk]		clk			Clock - Rising Edge Sensitive
 * @param [in-bool]		rd 			Read Memory Address (addr)
 * @param [in-bool]		wr 			Write to Memory Address (addr)
 * @param [in-uint8]	addr		Memory Address to be read/written from/to
 * @param [in-uint8]	dataIn		Data to be Written to Memory
 * @param [out-uint8]	dataOut		Data Output
 */
SC_MODULE(MEMORY){
	sc_in_clk	clk;			/// Clock (Rising Edge Sensitive)
	sc_in<bool> rd;				/// Read  (Reads memory address from addr)
	sc_in<bool> wr;				/// Write (Writes to addr)
	///
	sc_in<uint8_t> addr;		/// Memory Address to read/write from/to
	sc_in<uint8_t> dataIn;		/// Data to be written
	///
	sc_out<uint8_t> dataOut;	/// Output
	///
	char mem_data[256];			/// Memory Data (Initially random)

	void process(){
		cout << "(MEMORY) [" << sc_time_stamp() << "] process called" << endl;
		if(rd)
			dataOut = mem_data[addr];
		else if (wr)
			mem_data[addr] = dataIn;
	}

	SC_CTOR(MEMORY){
		SC_METHOD(process);
		sensitive << clk.pos();
	}
};

int sc_main (int argc, char* argv[]) {
	sc_signal<bool>		_clk;
	sc_signal<bool>		_rd;
	sc_signal<bool>		_wr;
	sc_signal<uint8_t>  _addr, _dataIn;

	sc_signal<uint8_t>  _dataOut;
	MEMORY mem("MEMORY");

	mem.clk(_clk); mem.rd(_rd); mem.wr(_wr); mem.dataIn(_dataIn); mem.addr(_addr);
	mem.dataOut(_dataOut);

	sc_set_time_resolution(1, SC_NS);

	sc_trace_file *wf = sc_create_vcd_trace_file("trace");
	// Dump the desired signals
	sc_trace(wf, _clk, "clk");
	sc_trace(wf, _rd, "rd");
	sc_trace(wf, _wr, "wr");
	sc_trace(wf, _addr, "addr");
	sc_trace(wf, _dataIn, "dataIn");
	sc_trace(wf, _dataOut, "dataOut");

	cout << "@" << sc_time_stamp() << " Starting simulation\n" << endl;

	sc_uint<8> tb_addr = rand();
	sc_uint<8> tb_data = rand();
	sc_uint<1> tb_rdwr;
	sc_uint<1> tb_clk = 1;

	for(int i = 0; i < 40; i++){
		_clk.write(tb_clk);
		_addr.write(tb_addr);
		_wr.write(tb_rdwr);
		_rd.write(!tb_rdwr);
		_addr.write(tb_addr);
		_dataIn.write(tb_data);
		if (i%5==0){
			tb_addr = rand();
			tb_data = rand();
		}
	 	tb_rdwr = rand();
		tb_clk = !tb_clk;
		sc_start(1, SC_NS);
	}

	cout << "@" << sc_time_stamp() << " Terminating simulation\n" << endl;
	sc_close_vcd_trace_file(wf);
	
	return 0;
}
