vlib work
vlog mem_test_tb.v
vsim tb +test_name=5wr_5rd
add wave -position insertpoint sim:/tb/*
run -all


