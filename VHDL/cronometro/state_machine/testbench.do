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
vcom data_structs.vhdl fsm.vhdl testbench.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.test_bench

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -divider -height 30 "< Input Ports >"
add wave -label "Clock"  -radix binary  /tb_in_ports.clk
add wave -divider -height 15 "Buttons"
add wave -label "Reset" -radix binary /tb_in_ports.button.rst
add wave -label "Start Stop" -radix binary /tb_in_ports.button.Start_Stop
add wave -label "Store Partial" -radix binary /tb_in_ports.button.Store_Partial
add wave -divider -height 10 "Last Button"
add wave -label "Start Stop" -radix binary /dut/last_button_states.Start_Stop
add wave -label "Store Partial" -radix binary /dut/last_button_states.Store_Partial
add wave -divider -height 10 "Button State"
add wave -label "Start Stop" -radix binary /dut/button_states.Start_Stop
add wave -label "Store Partial" -radix binary /dut/button_states.Store_Partial
add wave -divider -height 15 "State"
add wave -label "State" /dut/state
add wave -divide -height 30 "< Output Ports >"
add wave -label "Enable"  -radix binary /tb_out_ports.enable
add wave -label "Partial" -radix binary /tb_out_ports.partial

#Simula
run 8ms

wave zoomfull
write wave wave.ps
