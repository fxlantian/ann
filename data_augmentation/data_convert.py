#!/usr/bin python
#-*- coding: utf-8 -*-

# import packages
train_dir = "./train/"
test_dir = "./test/"
compiler_dir = "./compiler/"

from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img
from os import listdir
nr = open('nr.train', 'w')
files =  [f for f in listdir(train_dir)]
nr.write('%d 784 10\n'%len(files))
for file in files:
	img = load_img(train_dir+file)
	x = img_to_array(img)
	x = x[:, :, 0]
	x /= 255
	for p in x.flatten():
		nr.write('%.10f '%(float(p)))
	nr.write('\n')
	for i in range(10):
		if(int(file[0]) == i):
			nr.write('%.10f '%float(1))
		else:
			nr.write('%.10f '%float(0))
	nr.write('\n')

nr = open('test.txt', 'w')
files =  [f for f in listdir(test_dir)]
nr.write('%d 784 10\n'%len(files))
for file in files:
	img = load_img(test_dir+file)
	x = img_to_array(img)
	x = x[:, :, 0]
	x /= 255
	for p in x.flatten():
		nr.write('%.10f '%(float(p)))
	nr.write('\n')
	for i in range(10):
		if(int(file[0]) == i):
			nr.write('%.10f '%float(1))
		else:
			nr.write('%.10f '%float(0))
	nr.write('\n')

	

