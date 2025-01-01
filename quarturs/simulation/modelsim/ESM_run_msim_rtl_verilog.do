transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/PRNG.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/mapping_table.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/IRT.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/Instr_Buffer.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/IDT.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/ESM_core_IIM.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/ESM_core_IDA.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/ESM_core.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/ESM.v}
vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/code {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/code/candidate_list.v}

vlog -vlog01compat -work work +incdir+C:/Users/nawaz/OneDrive/Desktop/pdf/winter\ intern/ESM-module/quarturs/.test {C:/Users/nawaz/OneDrive/Desktop/pdf/winter intern/ESM-module/quarturs/.test/tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  tb

add wave *
view structure
view signals
run -all
