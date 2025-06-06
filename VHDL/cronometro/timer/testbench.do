# ============================================================================
# Name        : testbench.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar adder
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom ../state_machine/data_structs.vhdl timer.vhdl testbench.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.test_bench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -divider -height 30 "< Input Ports >"
add wave -label "Clock"  -radix binary  /tb_clk
add wave -divider -height 15 "Control"
add wave -label "Enable" -radix binary /tb_FSM.enable
add wave -label "Store Partial" -radix binary /tb_FSM.partial
add wave -divide -height 30 "< Output Ports >"
add wave -label "Absolute"  -radix unsigned /tb_absolute
add wave -label "Partial"   -radix unsigned /tb_partial
add wave -divide -height 30 "< Output Signals >"
add wave -label "Absolute"  -radix unsigned /dut/absolute_signal
add wave -label "Partial"   -radix unsigned /dut/partial_signal

#Simula
run 8ms

wave zoomfull
write wave wave.ps
