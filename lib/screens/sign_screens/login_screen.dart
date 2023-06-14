import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation/components/text/text_button.dart';
import 'package:graduation/components/text/text_form_field.dart';
import 'package:graduation/constants/colors.dart';
import 'package:graduation/screens/home_screen.dart';
import 'package:graduation/screens/sign_screens/register_screen.dart';
import 'forget_screen.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  static const String loginScreenRoute = 'login screen';
  final _formKey = GlobalKey<FormState>();
  final String apiEndpoint = 'http://185.132.55.54:8000/login/';
  final TextEditingController emailLoginController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();

  Future<void> sendPostRequest() async {
    Map<String, dynamic> data = {
      'email': emailLoginController.text,
      'password': passwordLoginController.text,
    };
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var response = await http.post(Uri.parse(apiEndpoint),
        headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      // Success
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      print('${response.statusCode}');
    } else {
      // Error
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  void dispose() {
    emailLoginController.dispose();
    passwordLoginController.dispose();
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello ... !',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 10,
                              color: defBlue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Enter Your Account To Login',
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width / 17.5,
                              color: defBlue,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableTextFormField(
                      controller: emailLoginController,
                      text: 'Email',
                      prefix: Icon(Icons.email),
                      textInputType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    ReusableTextFormField(
                      controller: passwordLoginController,
                      text: 'Password',
                      prefix: Icon(Icons.lock),
                      suffix: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.remove_red_eye),
                      ),
                      textInputType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          ForgetScreen.forgetScreenRoute,
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'FORGET?',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ReusableTextButton(
                      color: defBlue,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await apiEndpoint;
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeScreen.homeScreenRoute,
                            (route) => false,
                          );
                        }
                      },
                      text: 'LOGIN',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "If you don't have an account, please ",
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RegisterScreen.registerScreenRoute,
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: MediaQuery.of(context).size.width / 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
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
