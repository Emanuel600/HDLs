# ============================================================================
# Name        : counter.do
# Author      : Emanuel Staub Araldi, Copiado de Renan Augusto Starke
# Version     : 0.1
# Copyright   : Renan, Departamento de Eletrônica, Florianópolis, IFSC
# Description : Script simples para testar counter
# ============================================================================


#Cria biblioteca do projeto
vlib work

#compila projeto: todos os aquivo. Ordem é importante
vcom counter.vhdl tb_counter.vhdl

#Simula (work é o diretorio, testbench é o nome da entity)
vsim -voptargs="+acc" -t ns work.tb_counter

#Mosta forma de onda
view wave

#Adiciona ondas específicas
# -radix: binary, hex, dec
# -label: nome da forma de onda

# Com labels
add wave -label clk    -radix binary    /tb_clk
add wave -label data_b -radix binary    /tb_aclr_n
add wave -label prod   -radix unsigned  /tb_count_out

#Simula
run 5us

wave zoomfull
write wave wave.ps
