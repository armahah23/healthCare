import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'set_goal.dart';

class FitnessPlanForm extends StatefulWidget {
  @override
  _FitnessPlanFormState createState() => _FitnessPlanFormState();
}

class _FitnessPlanFormState extends State<FitnessPlanForm> {
  final _formKey = GlobalKey<FormState>();
  String? gender;
  String? genderError;
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  String? ageError;
  String? heightError;
  String? weightError;

  @override
  void dispose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    super.dispose();
  }

  bool validateForm() {
    bool isValid = true;
    setState(() {
      if (gender == null) {
        genderError = 'Please select a gender';
        isValid = false;
      } else {
        genderError = null;
      }

      if (ageController.text.isEmpty) {
        ageError = 'Age is required';
        isValid = false;
      } else {
        int? age = int.tryParse(ageController.text);
        if (age == null || age < 1 || age > 120) {
          ageError = 'Enter valid age (1-120)';
          isValid = false;
        } else {
          ageError = null;
        }
      }

      if (heightController.text.isEmpty) {
        heightError = 'Height is required';
        isValid = false;
      } else {
        double? height = double.tryParse(heightController.text);
        if (height == null || height < 50 || height > 300) {
          heightError = 'Enter valid height (50-300 cm)';
          isValid = false;
        } else {
          heightError = null;
        }
      }

      if (weightController.text.isEmpty) {
        weightError = 'Weight is required';
        isValid = false;
      } else {
        double? weight = double.tryParse(weightController.text);
        if (weight == null || weight < 20 || weight > 500) {
          weightError = 'Enter valid weight (20-500 kg)';
          isValid = false;
        } else {
          weightError = null;
        }
      }
    });
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.deepOrange],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(40),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('assets/fitness.png'),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Tell us about you!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'We will create your fitness plan',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 160, 160),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Form Section
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel('Gender:'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        buildRadioOption('Male', 'male'),
                        const SizedBox(width: 30),
                        buildRadioOption('Female', 'female'),
                      ],
                    ),
                    if (genderError != null)
                      Text(
                        genderError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    const SizedBox(height: 20),
                    buildLabel('Age:'),
                    buildTextField(ageController, 'Enter your Age', ageError),
                    const SizedBox(height: 20),
                    buildLabel('Height:'),
                    buildTextField(heightController, 'Enter your height (cm)', heightError),
                    const SizedBox(height: 20),
                    buildLabel('Weight:'),
                    buildTextField(weightController, 'Enter your weight (kg)', weightError),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (validateForm()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SetGoalPage()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText, String? errorText) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.red),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
    );
  }

  Widget buildRadioOption(String title, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: gender,
          onChanged: (newValue) {
            setState(() {
              gender = newValue;
              genderError = null;
            });
          },
          activeColor: Colors.orange,
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}