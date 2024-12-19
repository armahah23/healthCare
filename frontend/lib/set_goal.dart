import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'Tell_us_about.dart';

class SetGoalPage extends StatefulWidget {
  @override
  _SetGoalPageState createState() => _SetGoalPageState();
}

class _SetGoalPageState extends State<SetGoalPage> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _daysController = TextEditingController();
  final _hoursController = TextEditingController();
  final _workoutDaysController = TextEditingController();

  String? weightError;
  String? daysError;
  String? hoursError;
  String? workoutDaysError;

  @override
  void dispose() {
    _weightController.dispose();
    _daysController.dispose();
    _hoursController.dispose();
    _workoutDaysController.dispose();
    super.dispose();
  }

  bool validateForm() {
    bool isValid = true;
    setState(() {
      // Weight validation
      if (_weightController.text.isEmpty) {
        weightError = 'Weight is required';
        isValid = false;
      } else {
        double? weight = double.tryParse(_weightController.text);
        if (weight == null || weight <= 0 || weight > 200) {
          weightError = 'Enter valid weight (1-200 kg)';
          isValid = false;
        } else {
          weightError = null;
        }
      }

      // Days validation
      if (_daysController.text.isEmpty) {
        daysError = 'Number of days is required';
        isValid = false;
      } else {
        int? days = int.tryParse(_daysController.text);
        if (days == null || days < 1 || days > 365) {
          daysError = 'Enter valid days (1-365)';
          isValid = false;
        } else {
          daysError = null;
        }
      }

      // Hours validation
      if (_hoursController.text.isEmpty) {
        hoursError = 'Hours per day is required';
        isValid = false;
      } else {
        int? hours = int.tryParse(_hoursController.text);
        if (hours == null || hours < 1 || hours > 24) {
          hoursError = 'Enter valid hours (1-24)';
          isValid = false;
        } else {
          hoursError = null;
        }
      }

      // Workout days validation
      if (_workoutDaysController.text.isEmpty) {
        workoutDaysError = 'Workout days is required';
        isValid = false;
      } else {
        int? workoutDays = int.tryParse(_workoutDaysController.text);
        if (workoutDays == null || workoutDays < 1 || workoutDays > 7) {
          workoutDaysError = 'Enter valid days (1-7)';
          isValid = false;
        } else {
          workoutDaysError = null;
        }
      }
    });
    return isValid;
  }

  Widget _buildInputField(String question, TextEditingController controller, String hint, String? errorText) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[600]),
              filled: true,
              fillColor: Colors.grey[850],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              errorText: errorText,
              errorStyle: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
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
                      MaterialPageRoute(builder: (context) => FitnessPlanForm()),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/fitness.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Set Your Goal!',
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
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildInputField(
                      'What is your prefer weight to reduce?',
                      _weightController,
                      'Enter weight in kg',
                      weightError
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      'How many days you plan to workout?',
                      _daysController,
                      'Enter number of days',
                      daysError
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      'How much hours you can spent for a day?',
                      _hoursController,
                      'Enter hours per day',
                      hoursError
                    ),
                    const SizedBox(height: 20),
                    _buildInputField(
                      'How many days per week you plan to workout?',
                      _workoutDaysController, 
                      'Enter workout days per week',
                      workoutDaysError
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (validateForm()) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}