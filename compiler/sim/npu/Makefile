SIM=iverilog
SIMARGS=-D VCD_DUMP
TB=npu_tb
LOGF=$(SIM).log
EXE=simv
SIGDIR=../../gen/sigmoid
MIFDIR=../../gen/mif
MIFTARGET=../../gen/mif/mif
INCDIR=../../inc
SIGSCRIPT=sigmoid_generator.py

VCSARGS="-R -sverilog -debug_pp +vcs+lic+wait +v2k -full64 -line +negtchk +sdfverbose +define+DREAD_WRITE_MEMORY +define+GLOBAL_PARAMS +define+VCD_DUMP"
IVERARGS="-DREAD_WRITE_MEMORY -DVCD_DUMP"

# Test size
TESTSIZE = 200000  #64
BENCHMARK= sobel  #fft
NUM_PE=8

.PHONY: all npu sim

all: genmif sim

genmif:
	(cd $(MIFDIR)  ; make $(BENCHMARK) NUM_PE=$(NUM_PE) TESTSIZE=$(TESTSIZE))
	#cd  $(MIFDIR)
	mv $(MIFTARGET) .
	mv $(MIFDIR)/*.inc .

npu: sim

sim:
	cp $(INCDIR)/*.inc .
ifeq ($(SIM),iverilog)
	iverilog $(IVERARGS) -o $(EXE) -c $(TB).f | tee $(LOGF)
	./$(EXE)
else ifeq ($(SIM),vcs)
	vcs $(VCSARGS) -f $(TB).f | tee $(LOGF)
endif

clean:
	(cd $(MIFDIR); make clean)
	rm -rf $(EXE) $(LOGF) $(TB).vcd
	rm -rf mif *.inc *.vpd
	rm -rf csrc
	rm -rf simv.daidir
	rm -rf ucli.key
