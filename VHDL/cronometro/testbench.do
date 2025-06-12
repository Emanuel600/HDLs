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
# --- Pacotes Primeiro
vcom state_machine/data_structs.vhdl seven_segment/seven_segment.vhdl
# --> Arquivos base 
vcom counter/counter.vhdl state_machine/fsm.vhdl timer/timer.vhdl register/reg16.vhdl
# --> Arquivo principal e testbench
vcom cronometro.vhdl testbench.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.test_bench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -divider -height 30 "< Input Ports >"
add wave -label "Clock"  -radix binary  /dut/clk_1k
add wave -divider -height 15 "Buttons"
add wave -label "Reset" -radix binary /tb_buttons.rst
add wave -label "Start Stop" -radix binary /tb_buttons.Start_Stop
add wave -label "Store Partial" -radix binary /tb_buttons.Store_Partial
add wave -divider -height 30 "State"
add wave -label "State" /dut/state_machine/state
add wave -divide -height 30 "< Internal Count >"
add wave -label "Absolute"  -radix hex /dut/timer_e/absolute
add wave -label "Partial" -radix hex /dut/timer_e/partial

#Simula
run 8ms

wave zoomfull
write wave wave.ps
