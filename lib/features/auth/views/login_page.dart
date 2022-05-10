import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/features/auth/views/activate_page.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  /// Api provider
  UserService provider = UserService();

  /// TextField Controller
  TextEditingController emailController = TextEditingController();
  bool isButtonDisabled = true;
  TextEditingController passwordController = TextEditingController();

  /// Error Status opacity
  bool errorStatusOpacity = false;

  /// Loading opacity
  bool circularIndicatorOpacity = false;

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
              "assets/background/login.png"
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
                        "Sign In",
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

                  /// Email
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      if (value.isEmpty ||
                          value.length <= 30) {
                        setState(() {
                          isButtonDisabled = true;
                        });
                      } else if(value.length>30) {
                        setState(() {
                          isButtonDisabled = false;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "example@email.ru",
                        counterText: ""
                    ),
                    maxLength: 30 ,
                  ),
                  const SizedBox(height: 10),

                  /// Password
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                        hintText: "password"
                    ),
                    controller: passwordController,
                  ),
                  const SizedBox(height: 40),

                  /// Button
                  SizedBox(
                    width: width * 0.9,
                    child: ElevatedButton(
                        onPressed: () async {

                          setState(() {
                            errorStatusOpacity = false;
                            circularIndicatorOpacity = true;
                          });
                          try {
                          log("Email: " + emailController.text + ", Password: " + passwordController.text);
                          int status = await provider.login(emailController.text, passwordController.text);
                          setState(() {
                          circularIndicatorOpacity = false;
                          });
                          if(status == 200) {
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                          } else if(status == 500) {
                            Navigator.pushNamed(context, '/activate',arguments: ActivateEmailConstructor(email: emailController.text, password: passwordController.text));
                          }else{
                            setState(() {
                              errorStatusOpacity = true;
                            });
                          }
                          } catch(e) {
                            setState(() {
                              circularIndicatorOpacity = false;
                              errorStatusOpacity = true;
                            });
                          }
                        }, child:
                    const Text("Sign in")
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// Reset password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot your password?",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/resetPassword');
                          },
                          child: Text(
                            "Reset",
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
                  const SizedBox(height: 80),

                  /// Error Status
                  errorStatusOpacity ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Номер или пароль набран не правильно!",
                        style: GoogleFonts.inter(
                            color: Colors.red
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ) : Container(),

                  /// Loading Status
                  circularIndicatorOpacity ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator()
                    ],
                  ) : Container(),


                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
