// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../controller/login_controller.dart';
import '../android_home/home_screen.dart';

class AndroidLoginScreen extends StatefulWidget {
  const AndroidLoginScreen({super.key});

  @override
  State<AndroidLoginScreen> createState() => _AndroidLoginScreenState();
}

class _AndroidLoginScreenState extends State<AndroidLoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? username;
  String? password;

  String? usernameErrorText;
  String? passwordErrorText;

  bool usernameError = false;
  bool passwordError = false;

  EdgeInsets? padding;

  bool invalidLogin = false;

  LoginController loginController = LoginController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    EdgeInsets padding = EdgeInsets.all(size.height * 0.015);
    this.padding = padding;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(size.height * 0.02),
            //  Login Form
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.height * 0.03,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  userNameFormField(),
                  SizedBox(height: size.height * 0.02),
                  passwordFormField(),
                  invalidLogin == true
                      ? Column(
                          children: [
                            SizedBox(height: size.height * 0.02),
                            Text(
                              "Invalid username or password",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: size.height * 0.012,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  SizedBox(height: size.height * 0.04),
                  TextButton(
                    onPressed: () async {
                      _formKey.currentState!.validate();
                      if (!usernameError && !passwordError) {
                        _formKey.currentState!.save();
                        //  Login api validation
                        loginController
                            .findDetails(username!, password!)
                            .then((response) {
                          if (response == true) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AndroidHomeScreen()),
                              (route) => false,
                            );
                          } else {
                            setState(() {
                              invalidLogin = true;
                            });
                          }
                        });
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: size.height * 0.014),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Username form field
  TextFormField userNameFormField() {
    Size size = MediaQuery.sizeOf(context);
    return TextFormField(
      style: TextStyle(fontSize: size.height * 0.012),
      controller: usernameController,
      focusNode: usernameFocusNode,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: "Username",
        hintText: "Enter your username",
        labelStyle: TextStyle(fontSize: size.height * 0.014),
        floatingLabelStyle: TextStyle(fontSize: size.height * 0.014),
        hintStyle: TextStyle(fontSize: size.height * 0.012),
        errorStyle: TextStyle(fontSize: size.height * 0.012),
        contentPadding: padding,
        errorText: usernameErrorText,
      ),
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => username = newValue,
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            usernameError = true;
            usernameErrorText = "Please enter your username";
          }
        });
        return null;
      },
      onChanged: (value) {
        setState(() {
          usernameError = false;
          usernameErrorText = null;
          invalidLogin = false;
        });
      },
      onFieldSubmitted: (value) {
        if (!usernameError) {
          FocusScope.of(context).requestFocus(passwordFocusNode);
        }
      },
    );
  }

  // Password form field
  TextFormField passwordFormField() {
    Size size = MediaQuery.sizeOf(context);
    return TextFormField(
      style: TextStyle(fontSize: size.height * 0.012),
      controller: passwordController,
      focusNode: passwordFocusNode,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: "Password",
        hintText: "Enter your password",
        labelStyle: TextStyle(fontSize: size.height * 0.014),
        floatingLabelStyle: TextStyle(fontSize: size.height * 0.014),
        hintStyle: TextStyle(fontSize: size.height * 0.012),
        errorStyle: TextStyle(fontSize: size.height * 0.012),
        contentPadding: padding,
        errorText: passwordErrorText,
      ),
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.text,
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        setState(() {
          if (value!.isEmpty) {
            passwordError = true;
            passwordErrorText = "Please enter your password";
          }
        });
        return null;
      },
      onChanged: (value) {
        setState(() {
          passwordError = false;
          passwordErrorText = null;
          invalidLogin = false;
        });
      },
      onFieldSubmitted: (value) {
        if (!passwordError) {}
      },
    );
  }
}
