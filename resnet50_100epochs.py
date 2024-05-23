# -*- coding: utf-8 -*-
"""ResNet50_100epochs

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1-f6HtHtdf46R8Epcy7_4qxYiv8KfHDlg
"""

import tensorflow as tf
from tensorflow.keras import layers, models, optimizers
from tensorflow.keras.preprocessing.image import ImageDataGenerator

from google.colab import drive
drive.mount('/content/drive')

# Define your dataset directory
CrownPreparationFile = '/content/drive/MyDrive/one each error final'

# Define types
types = [
    "Finish line position", "Finish line continuity", "Finish line irregularity", "taper",
    "line angle roundness", "axial wall undercut", "amount of occlusal reduction",
    "Over reduction","Ideal"
]

# Define image dimensions and batch size
img_width, img_height = 224, 224
batch_size = 16

# Data augmentation and normalization
train_datagen = ImageDataGenerator(
    rescale=1./255,
    rotation_range=5,
    width_shift_range=0.2,
    height_shift_range=0.2,
    shear_range=0.2,
    zoom_range=0.05,
    horizontal_flip=True,
    fill_mode='nearest'
)

# Load and augment training images
train_generator = train_datagen.flow_from_directory(
    CrownPreparationFile,
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='categorical'
)

import matplotlib.pyplot as plt
from collections import Counter
# Get the image types from the generator
image_types = [types[i] for i in train_generator.classes]

# Plot the histogram of image types
image_type_counts = Counter(image_types)
names = list(image_type_counts.keys())
values = list(image_type_counts.values())

plt.bar(names, values)
plt.xlabel("Image Types")
plt.ylabel("Count")
plt.title("Histogram of Image Types")
plt.xticks(rotation=45)
plt.show()

# Define the ResNet model
def build_resnet(input_shape, num_classes):
    resnet = tf.keras.applications.ResNet50(
        include_top=False,
        weights='imagenet',
        input_shape=input_shape
    )

    for layer in resnet.layers:
        layer.trainable = False

    model = models.Sequential([
        resnet,
        layers.GlobalAveragePooling2D(),
        layers.Dense(num_classes, activation='softmax')
    ])

    return model

#early stop
#--------------------------
# ------RGB New data------
#--------------------------
#--added photo (1) folder--
# loss:2.0373 accuracy:23.34
#--------------------------

#--one each error folder---
# loss: 1.9450 - accuracy: 29.58

#augmented
#--one each error folder---
# loss:  - accuracy:

#-----added photo output----
# loss: accuracy:


#one each error

from tensorflow.keras.callbacks import EarlyStopping
# Build the model
model = build_resnet((img_width, img_height, 3), num_classes=len(types))

# Compile the model
model.compile(optimizer=optimizers.Adam(),
              loss='categorical_crossentropy',
              metrics=['accuracy'])
# Define EarlyStopping callback
early_stopping = EarlyStopping(monitor='val_loss', patience=3, verbose=1)

# Train the model
history = model.fit(
    train_generator,
    steps_per_epoch=train_generator.samples // batch_size,
    epochs=100,
    callbacks=[early_stopping]
)

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
from sklearn.metrics import confusion_matrix

test_datagen = ImageDataGenerator(rescale=1./255)

test_generator = test_datagen.flow_from_directory(
    '/content/drive/MyDrive/Final Crown Preparation',
    target_size=(img_width, img_height),
    batch_size=batch_size,
    class_mode='categorical',
    shuffle=False  # Important to keep the order of images and labels consistent
)

# Predict the classes of the test images
test_predictions = model.predict(test_generator)
test_predictions_classes = np.argmax(test_predictions, axis=1)
test_true_classes = test_generator.classes  # Use the 'classes' attribute of the generator to get true labels

# Generate the confusion matrix
cm = confusion_matrix(test_true_classes, test_predictions_classes)

# Plot confusion matrix
plt.figure(figsize=(10, 8))
sns.heatmap(cm, annot=True, fmt="d", cmap="Blues")
plt.xlabel('Predicted labels')
plt.ylabel('True labels')
plt.title('Confusion Matrix')
plt.show()