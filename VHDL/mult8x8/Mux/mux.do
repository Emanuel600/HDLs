# ============================================================================
# Name        : mux.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar mux de SIZE bits
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom mux_when.vhdl mux.vhdl tb_mux.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_mux

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -label mux_in_a     -radix unsigned /mux_in_a_tb
add wave -label mux_in_b     -radix unsigned /mux_in_b_tb
add wave -label mux_sel      -radix binary   /mux_sel_tb
add wave -label mux_out      -radix unsigned /mux_out_tb
add wave -label mux_out_when -radix unsigned /mux_out_when_tb

#Simula
run 4us

wave zoomfull
write wave wave.ps
