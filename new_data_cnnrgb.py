# -*- coding: utf-8 -*-
"""New data CNNrgb.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1BLwKzgOXsX1LfLFAd2eCTc1vEKW5rfyV
"""

import os
from os import listdir
import cv2
import pandas as pd
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers, models
from tensorflow.keras.utils import to_categorical
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from PIL import Image
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix
from sklearn.metrics import classification_report
from sklearn.metrics import roc_auc_score
from sklearn.metrics import roc_curve
from sklearn.metrics import auc
from sklearn.metrics import precision_recall_fscore_support
from sklearn.preprocessing import LabelEncoder
import re
import pathlib

from google.colab import drive
drive.mount('/content/drive')

!pip install pyheif

# Define your dataset directory
CrownPreparationFile = '/content/drive/MyDrive/one each error final segmentation'

# Define types
types = [
    "Finish line position", "Finish line continuity", "Finish line irregularity", "taper",
    "line angle roundness", "axial wall undercut", "amount of occlusal reduction",
    "Over reduction", "Ideal"
]

# Initialize lists to hold images and their labels
CrownPreparationimages = []
CrownPreparationlabels = []



target_size = (128, 128)  # Desired size to resize images

for i, PreparationType in enumerate(types, start=1):
    CrownPreparationFolder = os.path.join(CrownPreparationFile, str(i))
    for root, dirs, files in os.walk(CrownPreparationFolder):
        for file_name in files:
            img_path = os.path.join(root, file_name)
            _, file_extension = os.path.splitext(img_path)
            if file_extension.lower() == '.jpg':
            #for add photo output folder
            #if file_extension.lower() == '.png':
                img = Image.open(img_path)
            elif file_extension.lower() == '.heic':
                try:
                    heif_file = pyheif.read(img_path)
                    img = Image.frombytes(
                        heif_file.mode,
                        heif_file.size,
                        heif_file.data,
                        "raw",
                        heif_file.mode,
                        heif_file.stride,
                    )
                except Exception as e:
                    print(f"Error opening {img_path}: {e}")
                    continue
            else:
                print(f"Unsupported file format: {img_path}")
                continue

            # Convert image to RGB if not already in RGB mode
            if img.mode != 'RGB':
                img = img.convert('RGB')

            # Resize image to target size
            img = img.resize(target_size)

            # Append image and label
            CrownPreparationimages.append(np.array(img))
            CrownPreparationlabels.append(PreparationType)

CrownPreparationimages = np.array(CrownPreparationimages)
CrownPreparationlabels = np.array(CrownPreparationlabels)

2################ augmentation part ################

from keras.preprocessing.image import ImageDataGenerator

# Create an instance of the ImageDataGenerator
datagen = ImageDataGenerator(
    rotation_range=5,  # Randomly rotate images by 20 degrees
    horizontal_flip=True,  # Randomly flip images horizontally
    zoom_range=0.05  # Randomly zoom images by 20%
)

# Perform data augmentation
augmented_images = []
augmented_labels = []

for img, label in zip(CrownPreparationimages, CrownPreparationlabels):
    num_augmented_images = 0

    # Reshape the image to (1, height, width, channels)
    img = np.expand_dims(img, axis=0)

    # Generate augmented images
    for batch in datagen.flow(img, batch_size=1):
        augmented_images.append(batch[0])
        augmented_labels.append(label)
        num_augmented_images += 1
        if num_augmented_images >= 15:  # Generate 10 augmented images per original image
        # i change to 15 augmented images per original image
            break

# Convert augmented images and labels to NumPy arrays
CrownPreparationimages = np.array(augmented_images)
CrownPreparationlabels = np.array(augmented_labels)

from PIL import Image
import numpy as np
import matplotlib.pyplot as plt

print("Number of images loaded:", len(CrownPreparationimages))
print("Number of labels:", len(CrownPreparationlabels))

# Choose the index of the augmented image to display
image_indices = [6000, 7001, 8002, 9103]  # Change these indices as needed

plt.figure(figsize=(10, 10))
for i, idx in enumerate(image_indices):
    plt.subplot(2, 2, i + 1)
    image_uint8 = (augmented_images[idx]).astype(np.uint8)
    plt.imshow(image_uint8)
    plt.title('Label: {}'.format(augmented_labels[idx]))
    plt.axis('off')
plt.show()

print("Number of images loaded:", len(CrownPreparationimages))
print("Number of labels:", len(CrownPreparationlabels))

# one each contain 619 images
# with augmentation 3095 images

# one each final contain 667 images
# with augmentation 3335 images

# one each final contain 667 images
# with augmentation 6670 images  10 from 1

# one each final contain 682 images
# with augmentation 6820 images  10 from 1

# one each final contain 682 images
# with augmentation 9285 images  15 from 1

#early stop
#--------------------------
# ------RGB New data------
#--------------------------
#--added photo (1) folder--
#epoch 100 32,64,64,64,64 -> 23.6
#epoch 100 32,64,128,256,512 -> 21.4
#epoch 100 64,64,128,256,512 -> 25.24
#epoch 100 64,128,256,256,512 -> 19.63

#-----added photo output----
#epoch 100 32,64,64,64,64 -> 19.63
#epoch 100 32,64,128,256,512 -> 20.07
#epoch 100 64,64,128,256,512 -> 20.34
#epoch 100 64,128,256,256,512 -> 16.42

#-----one each error folder----
#epoch 100 64,64,128,256,512 -> 45.14
#CNN+SVM
#epoch 100 64,64,128,256,512,512 -> 25.54
#epoch 100 64,64,128,256,512 ->

#augmentation result
#epoch 100 64,64,128,256,512 -> 63.16
#epoch 300 64,64,128,256,512 -> 62
#epoch 100 64,64,128,256,512 -> augmentation: 1-Randomly rotate images by 10, 2-Randomly zoom images by 10 -> 69.62
#epoch 100 64,64,128,256,512 -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 71.08

#epoch 100 64,64,128,256,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 72.07
#epoch 100 64,64,128,256,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5, batch normalizition, dense 265 -> 66.68
#epoch 100 64,64,64,128,256 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5, batch normalizition, dense 128 -> 71.08

#-----one each error final folder----
#augmentation result
#epoch 100 64,64,128,256,512 with SVM -> augmentation: 1-Randomly rotate images by 10, 2-Randomly zoom images by 10 ->  73.31
#epoch 100 64,64,128,256,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 69.86

# 10 from 1 image
#epoch 100 64,64,128,256,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 74.78

# ------------------- 6 layers -------------------
# 10 from 1 image
# adding one more layer
#epoch 100 64,64,128,256,512,512 -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 72.94
#epoch 100 64,64,128,256,512,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 75.51

#epoch 100 64,128,128,256,512,512 -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 75.21
#epoch 100 64,128,128,256,512,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 74.92

#epoch 100 32,64,128,256,512,512 -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 73.90
#epoch 100 32,64,128,256,512,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 75.07


# ------------------- 6 layers -------------------
# 15 from 1 image
# adding one more layer
#epoch 100 64,64,128,256,512,512 with SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 77.92
#epoch 100 64,64,128,256,512,512 without SVM -> augmentation: 1-Randomly rotate images by 5, 2-Randomly zoom images by 5 -> 78.40

#change it to the telegram code with the pre square (if not work)
import tensorflow as tf
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelBinarizer
from tensorflow.keras import layers, models
from tensorflow.keras.callbacks import EarlyStopping
from sklearn.svm import SVC

# Assuming CrownPreparationimages and CrownPreparationlabels are already loaded and processed

# Split the dataset into training and testing
train_images, test_images, train_labels, test_labels = train_test_split(
    CrownPreparationimages, CrownPreparationlabels, test_size=0.2, random_state=42)

# Normalize pixel values to be between 0 and 1
train_images, test_images = train_images / 255.0, test_images / 255.0

# Convert labels to one-hot encoding
label_binarizer = LabelBinarizer()
train_labels = label_binarizer.fit_transform(train_labels)
test_labels = label_binarizer.transform(test_labels)

# Define early stopping callback
early_stopping = EarlyStopping(monitor='val_loss', patience=5)



model = models.Sequential([
    layers.Conv2D(64, (3, 3), activation='relu', input_shape=(128, 128, 3)),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(128, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(256, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),


    layers.Conv2D(512, (3, 3), activation='relu'),
    layers.BatchNormalization(),

    layers.Conv2D(512, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.Flatten(),


    layers.Dense(64, activation='relu'),
    layers.Dense(len(label_binarizer.classes_), activation='softmax')
])

# Compile the model
model.compile(optimizer='adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'])

# Train the model with early stopping
history = model.fit(train_images, train_labels, epochs=100,
                    validation_data=(test_images, test_labels),
                    callbacks=[early_stopping])

# Evaluate the model
test_loss, test_acc = model.evaluate(test_images, test_labels, verbose=2)
print('\nTest accuracy:', test_acc)

# Extract CNN features for training and testing
#train_cnn_features = model.predict(train_images)
#test_cnn_features = model.predict(test_images)

# Convert one-hot encoded labels back to 1D
#train_labels_1d = np.argmax(train_labels, axis=1)
#test_labels_1d = np.argmax(test_labels, axis=1)

# Train SVM classifier
#svm_model = SVC()
#svm_model.fit(train_cnn_features, train_labels_1d)

# Evaluate SVM model
#svm_accuracy = svm_model.score(test_cnn_features, test_labels_1d)
#print("SVM Test Accuracy:", svm_accuracy)

import tensorflow as tf

# Assuming 'model' is your trained Keras model
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

with open("model.tflite", "wb") as f:
    f.write(tflite_model)

import tensorflow as tf
from tensorflow.keras.preprocessing.image import load_img, img_to_array
import numpy as np
from collections import Counter

# Define your preprocessing function
def preprocess_image(image_path, target_size=(128, 128)):
    # Load image and resize
    img = load_img(image_path, target_size=target_size)
    # Convert image to array and normalize pixel values
    img_array = img_to_array(img) / 255.0
    return img_array

# Load TensorFlow Lite model
interpreter = tf.lite.Interpreter(model_path="/content/drive/MyDrive/model.tflite")
interpreter.allocate_tensors()

# Load test images (assuming you have a list of file paths)
test_image_paths = [
    '/content/drive/MyDrive/five_views/2/IMAGE 1445-11-06 02:09:24.jpg',
    '/content/drive/MyDrive/five_views/2/IMAGE 1445-11-06 02:09:28.jpg',
    '/content/drive/MyDrive/five_views/2/IMAGE 1445-11-06 02:09:31.jpg',
    '/content/drive/MyDrive/five_views/2/IMAGE 1445-11-06 02:09:34.jpg',
    '/content/drive/MyDrive/five_views/2/IMAGE 1445-11-06 02:09:37.jpg'
]
types = [
    "Finish line position", "Finish line continuity", "Finish line irregularity", "taper",
    "line angle roundness", "axial wall undercut", "amount of occlusal reduction",
    "Over reduction", "Ideal"
]

# Preprocess test images
test_images = [preprocess_image(image_path) for image_path in test_image_paths]
test_images = np.array(test_images)

# Number of top labels to retrieve for each image
N = 3  # Adjust as needed

# Prepare input and output tensors
input_details = interpreter.get_input_details()
output_details = interpreter.get_output_details()

# Run inference for each test image
predicted_labels_all = []

for image in test_images:
    # Set input tensor
    interpreter.set_tensor(input_details[0]['index'], np.expand_dims(image, axis=0))

    # Run inference
    interpreter.invoke()

    # Get output tensor
    output_data = interpreter.get_tensor(output_details[0]['index'])

    # Sort predictions by probability and get top N labels
    top_n_indices = np.argsort(output_data[0])[::-1][:N]  # Adjust N as needed
    top_n_labels = [(index, output_data[0][index]) for index in top_n_indices]

    # Append top N labels to the list
    predicted_labels_all.extend(top_n_indices)

# Count the occurrences of each label
label_counts = Counter(predicted_labels_all)

# Filter labels that appeared at least in two images
final_labels = [label for label, count in label_counts.items() if count >= 2 and types[label] != "Ideal"]

# Print the final predicted labels
print("Final Predicted Labels:")
for label in final_labels:
    if label < len(types):
        print(f"- {types[label]}")
        if types[label] == "Finish line position":
            print("Ensure that the finish line is not more than 1.5mm above the gumline and no more than 1.5mm below the gumline.")
        elif types[label] == "taper":
            print("Be sure the taper is not more than 12mm.")
        elif types[label] == "amount of occlusal reduction":
            print("Ensure that the occlusal reduction is not less than 3mm.")
        else:
            print("You have to re-curve the tooth again")
    else:
        print("Excellent work")

# add one more layer
model = models.Sequential([
    layers.Conv2D(64, (3, 3), activation='relu', input_shape=(128, 128, 3)),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(128, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(256, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(512, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.Conv2D(512, (3, 3), activation='relu'),
    layers.BatchNormalization(),
    layers.Flatten(),

    layers.Dense(64, activation='relu'),
    layers.Dense(len(label_binarizer.classes_), activation='softmax')
])

from sklearn.metrics import confusion_matrix
import numpy as np
# Predict the classes of the test images
test_predictions = model.predict(test_images)
test_predictions_classes = np.argmax(test_predictions, axis=1)
test_true_classes = np.argmax(test_labels, axis=1)  # Convert one-hot encoded test labels back to class indices for comparison
# Generate the confusion matrix
cm = confusion_matrix(test_true_classes, test_predictions_classes)

import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(10, 8))
sns.heatmap(cm, annot=True, fmt="d", cmap="Blues")
plt.xlabel('Predicted labels')
plt.ylabel('True labels')
plt.title('Confusion Matrix')
plt.show()

# this for the grayscale DONT CHANGE
input_shape = (128, 128, 3)
num_classes = len(np.unique(train_labels))

model = models.Sequential([
    layers.Conv2D(32, (3, 3), activation='relu', input_shape=input_shape),
   # layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(64, (3, 3), activation='relu'),
   # layers.BatchNormalization(),
    layers.MaxPooling2D((2, 2)),

    #layers.Conv2D(128, (3, 3), activation='relu'),
   # layers.BatchNormalization(),
   # layers.MaxPooling2D((2, 2)),

   # layers.Conv2D(512, (3, 3), activation='relu'),
   # layers.BatchNormalization(),
   # layers.MaxPooling2D((2, 2)),

   # layers.Conv2D(512, (3, 3), activation='relu'),
   # layers.BatchNormalization(),
    #layers.MaxPooling2D((2, 2)),

    layers.Flatten(),
    layers.Dense(64, activation='relu'),
    layers.Dropout(0.5),
   # layers.Dense(32, activation='relu'),
   # layers.Dropout(0.5),
    layers.Dense(num_classes, activation='softmax'),
])

model.compile(optimizer='adam', loss='categorical_crossentropy', metrics=['accuracy'])

label_encoder = LabelEncoder()
train_labels_encoded = label_encoder.fit_transform(train_labels)
test_labels_encoded = label_encoder.transform(test_labels)
train_labels_one_hot = to_categorical(train_labels_encoded)
test_labels_one_hot = to_categorical(test_labels_encoded)

CrownPreparationimages = np.array(CrownPreparationimages)
CrownPreparationlabels = np.array(CrownPreparationlabels)
print(CrownPreparationimages.shape)

modelHistory= model.fit(train_images, train_labels_one_hot, epochs=300, batch_size=32, validation_split=0.2)

plt.plot(modelHistory.history['accuracy'], label='accuracy')
plt.plot(modelHistory.history['val_accuracy'], label = 'val_accuracy')
plt.xlabel('Epoch')
plt.ylabel('Accuracy')
plt.ylim([0.5, 1])
plt.legend(loc='lower right')


test_loss, test_accuracy = model.evaluate(test_images, test_labels_one_hot, verbose=2)
print(f'Test Loss: {test_loss:.4f}, Test Accuracy: {test_accuracy:.4f}')

print(test_accuracy)