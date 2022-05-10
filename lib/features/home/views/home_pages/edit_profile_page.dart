import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/features/home/views/home_pages/profile_page.dart';
import 'package:neoshot_mobile/utils/model/user_model.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.userModel}) : super(key: key);

  final UserModel userModel;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  /// Controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  /// Password Controller
  TextEditingController lastPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ///User Service
  final UserService _userProvider = UserService();

  @override
  Widget build(BuildContext context) {
    /// Size
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const SizedBox(height: 30),

                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Данные клиента",
                      style: GoogleFonts.inter(
                          color: const Color(0xffFF385C),
                          fontWeight: FontWeight.bold,
                          fontSize: 26
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// First Name
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                      hintText: "username"
                  ),
                ),
                const SizedBox(height: 10),

                /// Last Name
                TextField(
                  controller: instagramController,
                  decoration: const InputDecoration(

                      hintText: "instagram"
                  ),
                ),
                const SizedBox(height: 30),

                /// Button
                SizedBox(
                  width: width * 0.95,
                  child: ElevatedButton(
                      onPressed: () async {

                        showDialog(
                            context: context,
                            // barrierColor: Colors.transparent,
                            builder: (_) {
                              return AlertDialog(
                                elevation: 0,
                                contentPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                content: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(25),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: const CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                              );
                            }
                        );

                        try {
                          bool result = await _userProvider.changeUserInfo(usernameController.text, instagramController.text, widget.userModel.image);
                          if(result) {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                // barrierColor: Colors.transparent,
                                builder: (_) {
                                  return AlertDialog(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    title: const Text("Data has been successfully changed!", textAlign: TextAlign.center,),
                                    actionsAlignment: MainAxisAlignment.center,
                                    content: Container(
                                      padding: const EdgeInsets.all(25),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: const Center(child: Icon(Icons.check_rounded, color: Colors.green, size: 50)),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                                          },
                                          child: const Text("Good!")
                                      )
                                    ],
                                  );
                                }
                            );
                          } else {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                // barrierColor: Colors.transparent,
                                builder: (_) {
                                  return AlertDialog(
                                    elevation: 0,
                                    contentPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    content: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(25),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: const Center(child: Icon(Icons.close_rounded, color: Colors.red, size: 50)),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            );
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              // barrierColor: Colors.transparent,
                              builder: (_) {
                                return AlertDialog(
                                  elevation: 0,
                                  contentPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  content: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(25),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: const Icon(Icons.close, color: Colors.red, size: 60),
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        }

                      }, child:
                  const Text("Save changes!")
                  ),
                ),

                const SizedBox(height: 50),


                /// Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Изменение пароля",
                      style: GoogleFonts.inter(
                          color: const Color(0xffFF385C),
                          fontWeight: FontWeight.bold,
                          fontSize: 26
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                /// Last Password
                TextField(
                  controller: lastPasswordController,
                  decoration: const InputDecoration(
                      hintText: "Старый пароль"
                  ),
                ),
                const SizedBox(height: 10),

                /// New Password
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "Новыый пароль"
                  ),
                ),
                const SizedBox(height: 10),

                /// Re New password
                TextField(
                  controller: confirmPasswordController,
                  decoration: const InputDecoration(
                      hintText: "Повторите новый пароль"
                  ),
                ),
                const SizedBox(height: 30),

                /// Button
                SizedBox(
                  width: width * 0.95,
                  child: ElevatedButton(
                      onPressed: () async {

                        showDialog(
                            context: context,
                            // barrierColor: Colors.transparent,
                            builder: (_) {
                              return AlertDialog(
                                elevation: 0,
                                contentPadding: EdgeInsets.zero,
                                backgroundColor: Colors.transparent,
                                content: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(25),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: const CircularProgressIndicator(),
                                    )
                                  ],
                                ),
                              );
                            }
                        );

                        try {
                          bool result = await _userProvider.changeUserPassword(lastPasswordController.text, passwordController.text);
                          if(result) {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                // barrierColor: Colors.transparent,
                                builder: (_) {
                                  return AlertDialog(
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(32.0))),
                                    title: const Text("Пароль успешно изменен", textAlign: TextAlign.center,),
                                    actionsAlignment: MainAxisAlignment.center,
                                    content: Container(
                                      padding: const EdgeInsets.all(25),
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(25)
                                      ),
                                      child: const Center(child: Icon(Icons.check_rounded, color: Colors.green, size: 50)),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
                                          },
                                          child: const Text("Хорошо")
                                      )
                                    ],
                                  );
                                }
                            );
                          } else {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                // barrierColor: Colors.transparent,
                                builder: (_) {
                                  return AlertDialog(
                                    elevation: 0,
                                    contentPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    content: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(25),
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: const Center(child: Icon(Icons.close_rounded, color: Colors.red, size: 50)),
                                        )
                                      ],
                                    ),
                                  );
                                }
                            );
                          }
                        } catch (e) {
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              // barrierColor: Colors.transparent,
                              builder: (_) {
                                return AlertDialog(
                                  elevation: 0,
                                  contentPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  content: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(25),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(25)
                                        ),
                                        child: const Icon(Icons.close, color: Colors.red, size: 60),
                                      )
                                    ],
                                  ),
                                );
                              }
                          );
                        }

                      }, child:
                  const Text("Сохранить изменение")
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
