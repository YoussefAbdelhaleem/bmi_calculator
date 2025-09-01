abstract class BMIState {}

class BMIInitial extends BMIState {}

class BMIUpdated extends BMIState {
  final String gender;
  final double height;
  final double weight;
  final double bmi;

  BMIUpdated({
    required this.gender,
    required this.height,
    required this.weight,
    required this.bmi,
  });
}