
TESTSIZE=1024  #16
NUM_PE=8

all: blackscholes facedet fft inversek2j jmeint jpeg kmeans sobel nr

blackscholes:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)

fft:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE) -data_offset 20000

inversek2j:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)

jmeint:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE) -input_lines 6

jpeg:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)

kmeans:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)

sobel:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)

mnist:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)
nr:
	python npu_compiler.py -nn nn_configs/$@.nn -dat training_data/$@.data -i $(TESTSIZE) -pe $(NUM_PE)
clean:
	rm -rf mif/ npu_compiler.log test.inc
