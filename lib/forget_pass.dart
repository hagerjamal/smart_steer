import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_app/helpers/dio_helper.dart';
import 'home_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final isinvalidemail = false.obs;
  // bool _isPasswordVisible = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();
  bool get _isButtonEnabled {
    return _emailController.text.isNotEmpty;
  }

  String? _emailError;
  String? _newPasswordError;
  String? _confirmNewPasswordError;

  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  // final passwordRegex =RegExp(r'^\d{6}$');
  final passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{10,}$');

  void _validate() async {
    setState(() {
      _emailError = null;
      //  _passwordError = null;
    });

    String email = _emailController.text.trim();
    // String password = _passwordController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        "Incomplete Information",
        "Please complete your info.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 2),
      );
      return;
    }

    if (email.isEmpty) {
      setState(() {
        _emailError = "Please enter a valid email address.";
      });
    } else if (!emailRegex.hasMatch(email)) {
      setState(() {
        _emailError = "Please enter a valid email address.";
      });
    }

    // if (password.isEmpty) {
    //   setState(() {
    //     _passwordError = "Incorrect Password.";
    //   });
    // } else if (!passwordRegex.hasMatch(password)) {
    //   setState(() {
    //     _passwordError =
    //         "Password must contain at least 10 charachters contains,special charachters,uppercase letter,numbers .";
    //   });
    // }

    if (_emailError == null) {
      try {
        var response = await DioHelper.postData(
          path: 'forgot-password',
          body: {
            'email': email,
            // 'password': password,
          },
        );

        // Print full response to debug console
        debugPrint('API Response: ${response.data}');

        // Extract backend message

        String backendMessage =
            response.data['message'] ?? "No message provided by backend.";

        if (response.statusCode == 200) {
          isinvalidemail.value = true;
          Get.snackbar(
            "Server Response /n Welcome ",
            backendMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
          Get.to(HomeScreen());
        } else {
          // Display backend message in the app in case of 401
          Get.snackbar(
            "Server Response",
            backendMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.blue,
            colorText: Colors.white,
            duration: Duration(seconds: 2),
          );
        } // if i cannot access api
      } catch (e) {
        // Handle Dio or network errors
        debugPrint('Error occurred: $e');
        Get.snackbar(
          "Error",
          "An error occurred while logging in. Please try again later.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 2),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Logo
          Positioned(
            top: 50,
            left: 60,
            child: Image.asset(
              'images/smart_steer_icon.png',
              height: 250,
            ),
          ),
          // Form Section
          Positioned(
            top: 320,
            bottom: 0,
            left: 10,
            right: 10,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: _emailError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                        onPressed: _validate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          fixedSize: Size(250, 50),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Obx(() {
                      if (isinvalidemail.value) {
                        return Column(
                          children: [
                            SizedBox(height: 15),
                            TextField(
                              controller: _newPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                errorText: _newPasswordError,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            TextField(
                              controller: _confirmNewPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirm New Password',
                                errorText: _confirmNewPasswordError,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                            SizedBox(height: 15),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24),
                                  fixedSize: Size(250, 50),
                                ),
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
