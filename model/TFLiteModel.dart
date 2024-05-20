import 'package:flutter/services.dart';

class TFLiteModel {
  late final String labels;
  late final String model;

  TFLiteModel({required this.labels, required this.model});

  Future<void> loadModel() async {
    // Load labels
    final labelData = await rootBundle.loadString(labels);
    // Load model
    final modelData = await rootBundle.load(model);

    // Use modelData and labelData as needed
  }
}

void main() {
  TFLiteModel tfliteModel = TFLiteModel(
    labels: 'assets/labels.txt',
    model: 'assets/model.tflite',
  );

  tfliteModel.loadModel();
}
