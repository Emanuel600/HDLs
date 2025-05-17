# ============================================================================
# Name        : shifter.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar mux de SIZE bits
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom shifter.vhdl tb_shifter.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_shifter

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -label input       -radix hex /input_tb
add wave -label ctl         -radix hex /shift_cntrl_tb
add wave -label output      -radix hex   /shift_out_tb

#Simula
run 4us

wave zoomfull
write wave wave.ps
