import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';

class ActivateEmailConstructor {
  const ActivateEmailConstructor(
      {Key? key,
        required this.email,
        required this.password});

  final String email;
  final String password;
}

class ActivateEmail extends StatefulWidget {
  const ActivateEmail({Key? key,
        required this.email,
        required this.password})
        : super(key: key);
  final String email;
  final String password;

  @override
  State<ActivateEmail> createState() => _ActivateEmailState();
}

class _ActivateEmailState extends State<ActivateEmail> {
  final UserService _userProvider = UserService();

  String? errorText;
  double opacity = 0;
  bool isButtonDisabled = true;
  final TextEditingController _pinPutController = TextEditingController();
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
                "Confirmation code",
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
              "To confirm that you are the owner of the email please enter the confirmation code from your email",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 13),
            ),
            const SizedBox(
              height: 35,
            ),

            TextFormField(
              controller: _pinPutController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: "code",
                  counterText: ""
              ),
              maxLength: 10 ,
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
                  int otpStatus = await _userProvider.activate(widget.email, _pinPutController.text);
                  if (otpStatus == 200) {
                      Navigator.pushNamed(context, '/');
                  } else if (otpStatus == 403) {
                    errorText = "Check the correctness of the code";
                    opacity = 1;
                    setState(() {});
                  }
                },
                child: const Text("Activate")),
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
