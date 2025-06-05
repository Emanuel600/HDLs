# ============================================================================
# Name        : reg16.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar um registrador de 16 bits
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom reg16.vhdl tb_reg16.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_reg16

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -label clk     -radix binary   /tb_clk
add wave -label clr     -radix binary   /tb_sclr_n
add wave -label ena     -radix binary   /tb_clk_ena
add wave -label in      -radix dec      /tb_datain
add wave -label out     -radix dec      /tb_reg_out

#Simula
run 5 us

wave zoomfull
write wave wave.ps
