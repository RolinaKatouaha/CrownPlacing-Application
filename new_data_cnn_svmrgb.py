# -*- coding: utf-8 -*-
"""New data CNN_SVMrgb.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1if4d80GFaHrP0ZeT_QP7HXn_IO9-C0ra
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
from sklearn.preprocessing import LabelBinarizer
from tensorflow.keras.callbacks import EarlyStopping
from sklearn.svm import SVC

from google.colab import drive
drive.mount('/content/drive')

!pip install pyheif
import pyheif

# Define your dataset directory
CrownPreparationFile = '/content/drive/MyDrive/one each error final'

# Define types
types = [
    "Finish line position", "Finish line continuity", "Finish line irregularity", "taper",
    "line angle roundness", "axial wall undercut", "amount of occlusal reduction",
    "Over reduction","Ideal"
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

######## --------------Gray Data-------------- ########

# Define your dataset directory
CrownPreparationFile = '/content/drive/MyDrive/added photo (1)'

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
                img = Image.open(img_path).convert('L')  # Convert to grayscale
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
                    ).convert('L')  # Convert to grayscale
                except Exception as e:
                    print(f"Error opening {img_path}: {e}")
                    continue
            else:
                print(f"Unsupported file format: {img_path}")
                continue

            # Resize image to target size
            img = img.resize(target_size)

            # Append image and label
            CrownPreparationimages.append(np.array(img))
            CrownPreparationlabels.append(PreparationType)

CrownPreparationimages = np.array(CrownPreparationimages)
CrownPreparationlabels = np.array(CrownPreparationlabels)

print("Number of images loaded:", len(CrownPreparationimages))
print("Number of labels:", len(CrownPreparationlabels))

# Split the dataset into training and testing
train_images, test_images, train_labels, test_labels = train_test_split(
    CrownPreparationimages, CrownPreparationlabels, test_size=0.2, random_state=42)

######## --------------Gray Images-------------- ########
# Expand dimensions for single-channel grayscale images
train_images = np.expand_dims(train_images, axis=-1)
test_images = np.expand_dims(test_images, axis=-1)

# Normalize pixel values to be between 0 and 1
train_images, test_images = train_images / 255.0, test_images / 255.0

# Convert labels to one-hot encoding
label_binarizer = LabelBinarizer()
train_labels = label_binarizer.fit_transform(train_labels)
test_labels = label_binarizer.transform(test_labels)

# Define early stopping callback
early_stopping = EarlyStopping(monitor='val_loss', patience=5)


#first 32,64,64 -> 39
#second 32,64,128 -> 32
#third 32,64,64,64 -> 41
#forth 32,64,64,128 -> 39
#fifth epoch 10 32,64,64,64-> 43
#sixth epoch 300 32,64,64,64,64 -> 29
#siventh epoch 300 32,64,128 -> 29
#siventh epoch 8 32,64,128 -> 33


#early stop
#--------------------------
# ------RGB New data------
#--------------------------
#cnn+svm  epoch 100 32 64 64 64 64 64 -> 20
#cnn+svm  epoch 100 32 64 64 128 64 64 -> 25
#cnn+svm  epoch 100 32 64 128 128 64 64 -> 24
#cnn+svm  epoch 100 32 128 128 128 64 64 -> 29
#cnn+svm  epoch 100 64 128 128 128 64 64 -> 23
#cnn+svm  epoch 100 64 128 128 256 64 64 -> 27
#cnn+svm  epoch 100 64 128 256 256 64 64 -> 25
#cnn+svm  epoch 100 64 128 256 512 64 64 -> 26

#cnn  epoch 100 64 128 256 512 64 64 ->
#cnn  epoch 300 64 128 256 512 64 64 ->

#--------------------------
# ------gray New data------
#--------------------------







model = models.Sequential([
    layers.Conv2D(64, (3, 3), activation='relu', input_shape=(128, 128, 3)),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(128, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(256, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(512, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),

    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.Flatten(),

    layers.Dense(64, activation='relu'),
    layers.Dense(len(label_binarizer.classes_), activation='softmax')

])

# Compile the model
model.compile(optimizer='adam',
              loss='categorical_crossentropy',
              metrics=['accuracy'])

# Train the model with early stopping
history = model.fit(train_images, train_labels, epochs=300,
                    validation_data=(test_images, test_labels),
                    callbacks=[early_stopping])
#history = model.fit(train_images, train_labels, epochs=300,
                    #validation_data=(test_images, test_labels))

# Extract CNN features for training and testing
train_cnn_features = model.predict(train_images)
test_cnn_features = model.predict(test_images)

# Convert one-hot encoded labels back to 1D
train_labels_1d = np.argmax(train_labels, axis=1)
test_labels_1d = np.argmax(test_labels, axis=1)

# Train SVM classifier
svm_model = SVC()
svm_model.fit(train_cnn_features, train_labels_1d)

# Evaluate SVM model
svm_accuracy = svm_model.score(test_cnn_features, test_labels_1d)
print("SVM Test Accuracy:", svm_accuracy)

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