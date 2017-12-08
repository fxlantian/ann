#!/usr/bin/python

#import pachages
from keras.preprocessing.image import ImageDataGenerator, array_to_img, img_to_array, load_img
import numpy as np  
import matplotlib.pyplot as plt 

filename = './capture.txt'

datagen = ImageDataGenerator(
	rotation_range=30,
	width_shift_range=0.1,
	height_shift_range=0.1,
	shear_range=0.2,
	zoom_range=0.2,
	horizontal_flip=False,
	vertical_flip=False,
	fill_mode='nearest')

datagen1 = ImageDataGenerator(
	rotation_range=0,
	width_shift_range=0,
	height_shift_range=0,
	shear_range=0,
	zoom_range=0,
	horizontal_flip=False,
	vertical_flip=False,
	fill_mode='nearest')

imgs = []
label = 0
histogram = np.zeros(256)
lf1 = 0;
lf2 = 0;
bf1 = 0;
bf2 = 0;
threshold = 0
with open(filename, 'r') as f:
	lines = f.readlines()
	print(len(lines),"\n")
linenum = 0;
for line in lines:
	#print line,"\n"
	try:
		number = [int(x) for x in line.strip().split(' ')]
	except Exception:
		continue
	linenum += 1;
	if len(number) > 100:
		for i in range(len(number)):
			histogram[number[i]] += 1

		exit_flag = False
		for i in range(255):
			if histogram[i]<=3 and histogram[i+1]>3:
				for j in range(i,255):
					if histogram[j]>=3 and histogram[j+1]<3:
						if j - i > 10:
							lf1 = i
							lf2 = j
							exit_flag = True
							break
			if exit_flag:
				break
		exit_flag = False
		for i in range(255, lf2, -1):
			if histogram[i]<=10 and histogram[i-1]>10:
				for j in range(i,lf2,-1):
					if histogram[j]>=10 and histogram[j-1]<10:
						if i - j > 10:
							bf1 = i
							bf2 = j
							exit_flag = True
							break
			if exit_flag:
				break

		threshold = 100
		print "threshold", threshold
		for i in range(len(number)):
			if(number[i] < threshold):
				number[i] = 255
			else:
				number[i] = 0

		x = np.array(number).reshape(1,28,28,1)
		i = 0
		for batch in datagen.flow(x,
			batch_size=1, 
			save_to_dir='./compiler',
			save_prefix='{}'.format(label)):
			if i >= 10:
				break
			i += 1

		if threshold < 80:
			print 'lf1',lf1
			print 'lf2',lf2
			print 'bf1',bf1
			print 'bf2',bf2
			print '(bf2 + bf1)/2',(bf2 + bf1)/2
			print '(lf1 + lf2)/2',(lf1 + lf2)/2
			print 'threshold',threshold
			x = range(256)
			plt.figure()
			plt.plot(x,histogram,label="histogram")
			plt.xlabel("gray")
			plt.ylabel("quantity")
			plt.title("gray histogram") 
			plt.show() 
			break
	else:
		label = number[0]
		print "label:",label


	

