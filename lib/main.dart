import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BMICalculatorScreen(),
  ));
}

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({super.key});

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  String gender = "Male";
  double height = 170;
  double weight = 65;

  double calculateBMI() {
    return weight / pow(height / 100, 2);
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

  @override
  Widget build(BuildContext context) {
    double bmi = calculateBMI();

    return Scaffold(
      backgroundColor: Colors.pink.shade800,
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFF4E50), Color(0xFFF9D423)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // العنوان والايقونة
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "BMI Calculator",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg"),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // اختيار الجنس
              const Text(
                "GENDER",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genderButton("Male", Icons.male, gender == "Male", () {
                    setState(() => gender = "Male");
                  }),
                  const SizedBox(width: 12),
                  genderButton("Female", Icons.female, gender == "Female", () {
                    setState(() => gender = "Female");
                  }),
                ],
              ),

              const SizedBox(height: 20),

              // الطول
              const Text(
                "HEIGHT",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Slider(
                value: height,
                min: 100,
                max: 220,
                divisions: 120,
                label: height.toStringAsFixed(0),
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
                onChanged: (value) {
                  setState(() {
                    height = value;
                  });
                },
              ),
              Text("${height.toStringAsFixed(0)} cm",
                  style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 20),

              // الوزن
              const Text(
                "WEIGHT",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              Slider(
                value: weight,
                min: 30,
                max: 150,
                divisions: 120,
                label: weight.toStringAsFixed(0),
                activeColor: Colors.white,
                inactiveColor: Colors.white54,
                onChanged: (value) {
                  setState(() {
                    weight = value;
                  });
                },
              ),
              Text("${weight.toStringAsFixed(0)} kg",
                  style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 30),

              // النتيجة
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    children: [
                      Text(
                        "YOUR BMI",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        bmi.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        getBMICategory(bmi),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            height = 170;
                            weight = 65;
                            gender = "Male";
                          });
                        },
                        backgroundColor: Colors.pink,
                        child: const Icon(Icons.refresh, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget genderButton(String text, IconData icon, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.pink.shade600 : Colors.pink.shade200,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
