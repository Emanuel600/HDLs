# ============================================================================
# Name        : mult_8x8.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar mult_8x8 de SIZE bits
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom Counter/counter.vhdl Adder/adder.vhdl mult_control/mult_control.vhdl Mult/mult.vhdl
vcom Mux/mux.vhdl Register/reg16.vhdl Seven_Seg/seven_segment_cntrl.vhdl Shifter/shifter.vhdl
vcom mult_8x8.vhdl tb_mult_8x8.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.test_bench

#Mosta forma de onda
view wave

# Sinais Básicos
add wave -label clk         -radix binary       /tb_clk
add wave -label start       -radix binary       /tb_start
add wave -label reset       -radix binary       /tb_reset_a
add wave -label done_flag   -radix binary       /tb_done_flag
# Dados de Entrada
add wave -label data_a       -radix unsigned     /tb_dataa
add wave -label data_b       -radix unsigned     /tb_datab
# Saída
add wave -label tb_product8x8_out -radix unsigned /tb_product8x8_out
# Estado
add wave -label state -position intersetpoint     /test_bench/dut/ctrl/state
# Clear
add wave -label clear -position intersetpoint     /test_bench/dut/ctrl/sclr_n
# Clock Enable
add wave -label clock_enable -position intersetpoint     /test_bench/dut/ctrl/clk_ena
# Shift Select
add wave -label shift_select -position intersetpoint     /test_bench/dut/ctrl/shift_sel
# Mux Select
add wave -label mux_sel -position intersetpoint     /test_bench/dut/ctrl/input_sel
# Reg Out
add wave -label product_8x8 -radix unsigned /test_bench/dut/reg/reg_out

#Simula
run 2 us

wave zoomfull
write wave wave.ps
