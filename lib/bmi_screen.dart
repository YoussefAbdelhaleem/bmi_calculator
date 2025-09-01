import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bmi_cubit.dart';
import 'bmi_state.dart';

class BMICalculatorScreen extends StatelessWidget {
  const BMICalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BMICubit(),
      child: Scaffold(
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
            child: BlocBuilder<BMICubit, BMIState>(
              builder: (context, state) {
                if (state is! BMIUpdated) {
                  return const Center(child: CircularProgressIndicator());
                }
                final cubit = context.read<BMICubit>();

                return Column(
                  children: [
  
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "BMI Calculator",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          CircleAvatar(
                            radius: 14,
                            backgroundImage: NetworkImage(
                              "https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg",
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                   
                    const Text(
                      "GENDER",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        genderButton(
                          "Male",
                          Icons.male,
                          state.gender == "Male",
                          () => cubit.changeGender("Male"),
                        ),
                        const SizedBox(width: 12),
                        genderButton(
                          "Female",
                          Icons.female,
                          state.gender == "Female",
                          () => cubit.changeGender("Female"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                 
                    const Text(
                      "HEIGHT",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Slider(
                      value: state.height,
                      min: 100,
                      max: 220,
                      divisions: 120,
                      label: state.height.toStringAsFixed(0),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      onChanged: (value) => cubit.changeHeight(value),
                    ),
                    Text(
                      "${state.height.toStringAsFixed(0)} cm",
                      style: const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 20),

                 
                    const Text(
                      "WEIGHT",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Slider(
                      value: state.weight,
                      min: 30,
                      max: 150,
                      divisions: 120,
                      label: state.weight.toStringAsFixed(0),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white54,
                      onChanged: (value) => cubit.changeWeight(value),
                    ),
                    Text(
                      "${state.weight.toStringAsFixed(0)} kg",
                      style: const TextStyle(color: Colors.white),
                    ),

                    const SizedBox(height: 30),

                    
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 30,
                        ),
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
                              state.bmi.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.pink,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              cubit.getBMICategory(state.bmi),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            FloatingActionButton(
                              onPressed: cubit.reset,
                              backgroundColor: Colors.pink,
                              child: const Icon(
                                Icons.refresh,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget genderButton(
    String text,
    IconData icon,
    bool selected,
    VoidCallback onTap,
  ) {
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
            Text(text, style: const TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}