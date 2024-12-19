import 'package:flutter/material.dart';
import 'home.dart';
import 'set_goal.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FitnessPlanForm(),
  ));
}

class FitnessPlanForm extends StatefulWidget {
  @override
  _FitnessPlanFormState createState() => _FitnessPlanFormState();
}

class _FitnessPlanFormState extends State<FitnessPlanForm> {
  String? gender;
  String? ageGroup;
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
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
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Navigator.pushReplacementNamed(context, '/home');
                      // Alternative way:
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
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
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildOptionButton('Weight Loss'),
                buildOptionButton('Fitness Body'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildLabel('Gender:'),
                buildRadioOption('Male', 'male'),
                buildRadioOption('Female', 'female'),
              ],
            ),
            const SizedBox(height: 20),
            buildLabel('Age:'),
            buildTextField(heightController, 'Enter your Age'),
            const SizedBox(height: 20),
            buildLabel('Height:'),
            buildTextField(heightController, 'Enter your height'),
            const SizedBox(height: 10),
            buildLabel('Weight:'),
            buildTextField(weightController, 'Enter your weight'),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SetGoalPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildOptionButton(String title) {
    return ElevatedButton(
      onPressed: () {
        // Handle option selection
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      ),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  Widget buildRadioOption(String title, String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: value.contains('male') || value.contains('female')
              ? gender
              : ageGroup,
          onChanged: (newValue) {
            setState(() {
              if (value.contains('male') || value.contains('female')) {
                gender = newValue;
              } else {
                ageGroup = newValue;
              }
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

  Widget buildTextField(TextEditingController controller, String hintText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
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
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
