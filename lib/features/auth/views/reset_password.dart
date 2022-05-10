import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final UserService _userProvider = UserService();

  String? errorText;
  double opacity = 0;
  bool isButtonDisabled = true;
  final TextEditingController _emailController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 20),
              color: Color.fromRGBO(2, 32, 44, 0.05),
              spreadRadius: 10,
              blurRadius: 15)
        ]);
  }

  bool isRepeatSmsDisabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Text(
                "OOps, you forgot your password!?",
                style: GoogleFonts.inter(
                    color: const Color(0xffFF385C),
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "After resetting the password, please check your email, where you can get the temporary password!",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            const SizedBox(
              height: 35,
            ),

            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "email@email.com",
                  counterText: ""
              ),
              maxLength: 30 ,
            ),
            const SizedBox(height: 10),

            // PinPut(
            //   onChanged: (value) {},
            //   textStyle:
            //   GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 18),
            //   fieldsCount: 6,
            //   eachFieldHeight: 55,
            //   eachFieldWidth: 55,
            //   focusNode: _pinPutFocusNode,
            //   controller: _pinPutController,
            //   submittedFieldDecoration: _pinPutDecoration,
            //   selectedFieldDecoration: _pinPutDecoration,
            //   followingFieldDecoration: _pinPutDecoration.copyWith(
            //     borderRadius: BorderRadius.circular(15.0),
            //     border: Border.all(
            //       color: Colors.transparent,
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () async {
                  bool otpStatus = await _userProvider.resetPassword(_emailController.text);
                  if (otpStatus) {
                    Navigator.pushNamed(context, '/login');
                  } else {
                    errorText = "Check the correctness of the email";
                    opacity = 1;
                    setState(() {});
                  }
                },
                child: const Text("Reset Password")),
            const SizedBox(
              height: 30,
            ),
            Opacity(
                opacity: opacity,
                child: Text(
                  errorText ?? "",
                  style: const TextStyle(color: Colors.red),
                ))
          ],
        ),
      ),
    );
  }
}
