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
vcom counter.vhdl adder.vhdl mult_control.vhdl mult.vhdl
vcom mux.vhdl reg16.vhdl seven_segment_cntrl.vhdl shifter.vhdl
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
# Segmentos
add wave -label seg_a       -radix binary       /tb_seg_a
add wave -label seg_b       -radix binary       /tb_seg_b
add wave -label seg_c       -radix binary       /tb_seg_c
add wave -label seg_d       -radix binary       /tb_seg_d
add wave -label seg_e       -radix binary       /tb_seg_e
add wave -label seg_f       -radix binary       /tb_seg_f
add wave -label seg_g       -radix binary       /tb_seg_g
add wave -label seg_dp      -radix binary       /tb_seg_dp

#Simula
run 700 ns

wave zoomfull
write wave wave.ps
