SIM=iverilog
SIMARGS=-D VCD_DUMP
TB=sigmoid_lut_tb
LOGF=iverilog.log
EXE=simv
SRCDIR=../../gen/mif/
INCDIR=../../inc/
GENSCRIPT=npu_compiler.py

all: sigmoid_lut exe

sigmoid_lut:
	(cd $(SRCDIR) ; make fft)
	cp $(INCDIR)/*.inc .
	mv $(SRCDIR)/mif/*mif .
	mv $(SRCDIR)/*.inc .
exe:
	iverilog -o $(EXE) -DREAD_WRITE_MEMORY -c $(TB).f $(SIMARGS) | tee $(LOGF)
	./$(EXE)

clean:
	rm -rf $(EXE) $(LOGF) $(TB).vcd
	rm *.mif *.inc
