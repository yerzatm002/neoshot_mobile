import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      // onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: [


            /// Background Image
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/background/background_image.jpg')
                ),
              ),
            ),



            /// Color and Content
            Container(
              // decoration: const BoxDecoration(
              //     gradient: LinearGradient(
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //         colors: [
              //           Color.fromRGBO(255, 255, 255, 0.9),
              //           Color.fromRGBO(255, 255, 255, 0.2),
              //           Colors.transparent,
              //           Colors.transparent,
              //         ]
              //     )
              // ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [


                  /// Title
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Text(
                  //           "Добро пожаловать! \n Мы рады видеть вас \n с нами",
                  //           style: GoogleFonts.inter(
                  //               fontSize: 26,
                  //               color: Colors.white,
                  //               fontWeight: FontWeight.bold
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ),
                  //         const SizedBox(height: 150),
                  //       ],
                  //     )
                  //   ],
                  // ),

                  /// Button of register and login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [

                          /// Button
                          SizedBox(
                            width: width * 0.7,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: const BorderSide(color: Colors.red)
                                      )
                                  )
                              ),
                                onPressed: () {
                                  Navigator.pushNamed(context, '/login');
                                }, child:
                            const Text("Sign In")
                            ),
                          ),
                          const SizedBox(height: 5),

                          /// Register
                          Row(
                            children: [
                              Text(
                                "You don't have an account?",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/register');
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline
                                    ),
                                  )
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
