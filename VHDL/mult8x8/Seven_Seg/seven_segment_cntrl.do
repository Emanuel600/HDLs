# ============================================================================
# Name        : seven_segment_cntrl.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar decoder de 7seg
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom seven_segment_cntrl.vhdl tb_seven_segment_cntrl.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_seven_segment_cntrl

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -label input   -radix unsigned /tb_input
add wave -label output  -radix binary   /tb_segs

#Simula
run 500 ns

wave zoomfull
write wave wave.ps
