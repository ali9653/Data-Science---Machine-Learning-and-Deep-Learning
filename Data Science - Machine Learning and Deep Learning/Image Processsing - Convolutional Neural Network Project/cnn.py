# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

# -*- coding: utf-8 -*-
"""
Created on Tue Oct 29 13:35:43 2019

@author: ALI
"""

# Import Libraries


from keras.models import Sequential
from keras.layers import Convolution2D
from keras.layers import MaxPooling2D
from keras.layers import Flatten
from keras.layers import Dense

# Initialize CNN 

classifier = Sequential()

# Convolution Layer

classifier.add(Convolution2D(32,3,3,input_shape = (64,64,3), activation='relu'))

# Max Pooling

classifier.add(MaxPooling2D(pool_size=(2,2)))

# Adding second Convolutional layer to improve accuracy

classifier.add(Convolution2D(32,3,3, activation='relu'))
classifier.add(MaxPooling2D(pool_size=(2,2)))


# Flattening

classifier.add(Flatten())

# Full Connection

classifier.add(Dense(output_dim = 128 , activation='relu'))
classifier.add(Dense(output_dim = 1 , activation='sigmoid'))

# Complie CNN

classifier.compile(optimizer= 'adam' , loss = 'binary_crossentropy' , metrics= ['accuracy'])


# Fitting the CNN to images

from keras.preprocessing.image import ImageDataGenerator

train_datagen = ImageDataGenerator(
        rescale=1./255,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True)

test_datagen = ImageDataGenerator(rescale=1./255)  

train_set  = train_datagen.flow_from_directory(
        'Convolutional_Neural_Networks/dataset/training_set',
        target_size=(64, 64),
        batch_size=32,
        class_mode='binary')

test_set = test_datagen.flow_from_directory(
        'Convolutional_Neural_Networks/dataset/test_set',
        target_size=(64, 64),
        batch_size=32,
        class_mode='binary')

classifier.fit_generator(
        train_set,
        steps_per_epoch=8000,
        epochs=25,
        validation_data=test_set ,
        validation_steps=2000)


# Making New Predictions

import numpy as np
from keras.preprocessing import image
test_image = image.load_img('Convolutional_Neural_Networks/dataset/single_prediction/cat_or_dog_1.jpg',target_size = (64,64))
test_image = image.img_to_array(test_image)
test_image = np.expand_dims(test_image, axis=0)
result = classifier.predict(test_image)
train_set.class_indices

if result[0][0] == 1:
    prediction = 'dog'
else:
    prediction = 'cat'


from tensorflow.python.client import device_lib
print(device_lib.list_local_devices()




pip install tensorflow-gpu










