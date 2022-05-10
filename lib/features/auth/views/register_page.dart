import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/features/auth/views/activate_page.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  /// Provider
  final UserService _userProvider = UserService();

  /// TextField Controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  /// Validate
  bool _usernameValidate = true;
  bool _emailValidate = true;
  bool _passwordValidate = true;
  bool _confirmPasswordValidate = true;

  /// Error text
  String? errorText;

  /// Validator
  void registerValidator() {
    if (usernameController.text.isNotEmpty) {
      setState(() {
        _usernameValidate = true;
      });
    } else {
      setState(() {
        _usernameValidate = false;
      });
    }
    if (emailController.text.isNotEmpty) {
      setState(() {
        _emailValidate = true;
      });
    } else {
      setState(() {
        _emailValidate = false;
      });
    }
    if (passwordController.text.isNotEmpty) {
      setState(() {
        _passwordValidate = true;
      });
    } else {
      setState(() {
        _passwordValidate = false;
      });
    }
    if (confirmPasswordController.text == passwordController.text &&
        confirmPasswordController.text.isNotEmpty) {
      setState(() {
        _confirmPasswordValidate = true;
      });
    } else {
      setState(() {
        _confirmPasswordValidate = false;
      });
    }
  }

  /// Opacity
  bool circularBarIndicatorOpacity = false;
  bool errorTextOpacity = false;
  bool isButtonDisabled = false;


  @override
  Widget build(BuildContext context) {

    /// Size
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage(
                      "assets/background/register.jpg"
                  )
              )
          ),
          child: ListView(
            children: [
              const SizedBox(height: 200),
              Container(
                height: 800,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30))
                ),
                padding: const EdgeInsets.fromLTRB(30, 30.0, 30.0, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    /// Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Sign Up",
                          style: GoogleFonts.inter(
                              color: const Color(0xffFF385C),
                              fontWeight: FontWeight.bold,
                              fontSize: 26
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    /// Username
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "username",
                          counterText: "",
                          errorText: _usernameValidate ? null : "Write your username!"
                      ),
                      maxLength: 20,
                    ),
                    const SizedBox(height: 10),

                    /// Email
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          hintText: "example@email.ru",
                          counterText: "",
                          errorText: _emailValidate ? null : "Please, write your email!"
                      ),
                      maxLength: 30,
                    ),
                    const SizedBox(height: 10),

                    /// Password
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: "password",
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 10),

                    /// Confirm Password
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          errorText: _confirmPasswordValidate == false
                              ? "Passwords don't match"
                              : null),
                      controller: confirmPasswordController,
                    ),
                    const SizedBox(height: 20),


                    SizedBox(
                      width: width * 0.95,
                      child: ElevatedButton(
                          onPressed: () async {
                            registerValidator();
                            if (_confirmPasswordValidate &&
                                _passwordValidate &&
                                _usernameValidate &&
                                _emailValidate ) {
                              if (passwordController.text ==
                                  confirmPasswordController.text) {
                                setState(() {
                                  circularBarIndicatorOpacity = true;
                                  errorTextOpacity=false;
                                });

                                log("Email: " + emailController.text + ", Password: " + passwordController.text);

                                int status =  await _userProvider.register(usernameController.text, emailController.text, passwordController.text);
                                if (status == 200) {
                                  Navigator.pushNamed(context, '/activate',arguments: ActivateEmailConstructor(email: emailController.text, password: passwordController.text));
                                  // }
                                }
                                else {
                                  setState(() {
                                    errorText= "Such email have already an account";
                                    errorTextOpacity = true;
                                    circularBarIndicatorOpacity = false;
                                  });
                                }
                              }
                            }
                          },
                          child: const Text("Sign up"))
                    ),
                    const SizedBox(height: 20),

                    /// Already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text(
                              "Sign In",
                              style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration.underline
                              ),
                            )
                        )
                      ],
                    ),
                    const SizedBox(height: 30),

                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}
