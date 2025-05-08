# ============================================================================
# Name        : mult_control.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar mult_control de SIZE bits
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom mult_control.vhdl counter.vhdl tb_mult_control.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_mult_control

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Entradas
add wave -label clock   -radix binary       /tb_clk
add wave -label start   -radix binary       /tb_start
add wave -label rst     -radix binary       /tb_reset_a
add wave -label count   -radix unsigned     /tb_count
# Estados
add wave -position insertpoint sim:/tb_mult_control/dut/state
# Saídas
add wave -label mux_sel     -radix binary       /tb_input_sel
add wave -label shift_sel   -radix binary       /tb_shift_sel
add wave -label done        -radix binary       /tb_done
add wave -label clk_ena     -radix binary       /tb_clk_ena
add wave -label sclr        -radix binary       /tb_sclr_n
add wave -label state_out   -radix unsigned     /tb_state_out

#Simula
run 700 ns

wave zoomfull
write wave wave.ps
