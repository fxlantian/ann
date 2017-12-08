SIM=iverilog
SIMARGS=-D VCD_DUMP
TB=fifo_fwf_tb
LOGF=iverilog.log
EXE=simv
SRCDIR=../../gen/sigmoid/
INCDIR=../../inc/
GENSCRIPT=sigmoid_generator.py

all: fifo_fwf

fifo_fwf:
	cp $(INCDIR)*.inc .
	iverilog -o $(EXE) -c $(TB).f $(SIMARGS) | tee $(LOGF)
	./$(EXE)

clean:
	rm -rf $(EXE) $(LOGF) $(TB).vcd
	rm *.inc