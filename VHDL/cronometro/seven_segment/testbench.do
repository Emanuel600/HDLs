# ============================================================================
# Name        : testbench.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar decoder de 7seg
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom seven_segment.vhdl testbench.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.test_bench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -divider -height 20 "Counter"
add wave -label "counter" -radix hex /count
add wave -divider -height 20 "7 Seg"
add wave -label "1st 7 Seg"  -radix symbolic /sev_seg0
add wave -label "2nd 7 Seg"  -radix symbolic /sev_seg1
add wave -label "3rd 7 Seg"  -radix symbolic /sev_seg2
add wave -label "4th 7 Seg"  -radix symbolic /sev_seg3

#Simula
run 20 us

wave zoomfull
write wave wave.ps
