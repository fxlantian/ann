SIM=iverilog
SIMARGS=-D VCD_DUMP
TB=sigmoid_tb
LOGF=iverilog.log
EXE=simv
SRCDIR=../../gen/mif/
INCDIR=../../inc/
GENSCRIPT=npu_compiler.py

all: sigmoid

sigmoid:
	(cd $(SRCDIR) ; make fft)
	cp $(INCDIR)/*.inc .
	mv $(SRCDIR)/mif/*mif .
	mv $(SRCDIR)/*.inc .
	iverilog -o $(EXE)  -c $(TB).f $(SIMARGS) | tee $(LOGF)
	./$(EXE)

clean:
	rm -rf $(EXE) $(LOGF) $(TB).vcd
	rm *.mif *.inc
