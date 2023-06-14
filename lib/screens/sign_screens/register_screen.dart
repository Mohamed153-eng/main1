import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/components/text/text_button.dart';
import 'package:graduation/components/text/text_form_field.dart';
import 'package:graduation/constants/colors.dart';
import 'login_screen.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  static const String registerScreenRoute = 'register screen';
  final _formKey = GlobalKey<FormState>();
  final String apiEndpoint = 'http://185.132.55.54:8000/register/';

  final TextEditingController firstNameRegisterController =
      TextEditingController();
  final TextEditingController lastNameRegisterController =
      TextEditingController();
  final TextEditingController emailRegisterController = TextEditingController();
  final TextEditingController phoneNumberRegisterController =
      TextEditingController();
  final TextEditingController addressRegisterController =
      TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();

  Future<void> sendPostRequest() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'email': emailRegisterController.text,
        'password': passwordRegisterController.text,
        'first_name': firstNameRegisterController.text,
        'last_name': lastNameRegisterController.text,
        'phone_number': phoneNumberRegisterController.text,
        'address': addressRegisterController.text,
      };
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

      var response = await http.post(Uri.parse(apiEndpoint),
          headers: headers, body: jsonEncode(data));
      print(response.headers);
      if (response.statusCode == 400) {
        // Bad Request
        var responseBody = jsonDecode(response.body);
        print('Bad Request: ${responseBody['message']}');
        print('${response.statusCode}');
      } else if (response.statusCode == 200) {
        // Success
        var responseBody = jsonDecode(response.body);
        print(responseBody);
      } else {
        // Other error
        print('Error: ${response.reasonPhrase}');
      }
    }
  }

  @override
  void dispose() {
    emailRegisterController.dispose();
    passwordRegisterController.dispose();
    firstNameRegisterController.dispose();
    lastNameRegisterController.dispose();
    phoneNumberRegisterController.dispose();
    addressRegisterController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey, // Assign the form key
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Your Account',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 12.5,
                              color: defBlue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableTextFormField(
                      controller: firstNameRegisterController,
                      text: 'First name',
                      prefix: Icon(Icons.person),
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ReusableTextFormField(
                      controller: lastNameRegisterController,
                      text: 'Last name',
                      prefix: Icon(Icons.person_pin_rounded),
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ReusableTextFormField(
                      controller: emailRegisterController,
                      text: 'Email',
                      prefix: Icon(Icons.email),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ReusableTextFormField(
                      controller: phoneNumberRegisterController,
                      text: 'Phone Number',
                      prefix: Icon(Icons.phone_android_rounded),
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Phone Number';
                        }
                        if (value.length == 12) {
                          return 'Phone Number 12 Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ReusableTextFormField(
                      controller: addressRegisterController,
                      text: 'Address',
                      prefix: Icon(Icons.maps_home_work_outlined),
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your Address';
                        }
                        if (value.length == 12) {
                          return 'Address  12 Address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    ReusableTextFormField(
                      controller: passwordRegisterController,
                      text: 'Password',
                      prefix: Icon(Icons.lock),
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ReusableTextButton(
                      color: defBlue,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await sendPostRequest();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.loginScreenRoute,
                            (Route<dynamic> route) => false,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _formKey.currentState!.validate()
                                    ? 'The account has been created'
                                    : 'The account has not been created',
                              ),
                            ),
                          );
                        }
                      },
                      text: 'REGISTER',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

