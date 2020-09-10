NAME := xor_encrypt

sim:
	vivado -mode batch -source run_xsim.tcl -nolog -nojournal

clean:
	rm -rf ${NAME}.xpr
	rm -rf ${NAME}.runs
	rm -rf ${NAME}.srcs
	rm -rf ${NAME}.sim
	rm -rf ${NAME}.cache
	rm -rf ${NAME}.hw
	rm -rf ${NAME}.ip_user_files
	rm -rf *.str