import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_state.dart';

class BMICubit extends Cubit<BMIState> {
  String gender = "Male";
  double height = 170;
  double weight = 65;

  BMICubit() : super(BMIInitial()) {
    calculateBMI();
  }

  void changeGender(String newGender) {
    gender = newGender;
    calculateBMI();
  }

  void changeHeight(double newHeight) {
    height = newHeight;
    calculateBMI();
  }

  void changeWeight(double newWeight) {
    weight = newWeight;
    calculateBMI();
  }

  void reset() {
    gender = "Male";
    height = 170;
    weight = 65;
    calculateBMI();
  }

  double _calculateBMI() {
    return weight / pow(height / 100, 2);
  }

  void calculateBMI() {
    emit(
      BMIUpdated(
        gender: gender,
        height: height,
        weight: weight,
        bmi: _calculateBMI(),
      ),
    );
  }

  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return "You are underweight.";
    } else if (bmi < 25) {
      return "You have a normal body weight. Great job!";
    } else if (bmi < 30) {
      return "You are overweight.";
    } else {
      return "You are obese.";
    }
  }
}