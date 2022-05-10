import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:neoshot_mobile/configuration/route_generator.dart';
import 'package:neoshot_mobile/features/auth/views/first_page.dart';
import 'package:neoshot_mobile/features/auth/views/login_page.dart';
import 'package:neoshot_mobile/features/auth/views/register_page.dart';
import 'package:neoshot_mobile/features/home/views/home_page.dart';
import 'package:neoshot_mobile/features/profile/views/profile_page.dart';



String? token;

Future<void> main() async {



  WidgetsFlutterBinding.ensureInitialized();

  try {
    const storage = FlutterSecureStorage();
    token = await storage.read(key: 'token');
    debugPrint("Token: " + token.toString());
  } catch(e) {
    debugPrint("Has exception in getting token " + e.toString());
  }


  runApp(const MyApp());
}


Map<String, WidgetBuilder> routes = {
  '/' : (context) => const HomePage(),
  '/first_page' : (context) => const FirstPage(),
  '/login' : (context) => const LoginPage(),
  '/register' : (context) => const RegisterPage(),
  '/profile' : (context) => const ProfilePage()
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: const Color(0xffFF385C),

          /// AppBar Theme
          appBarTheme: const AppBarTheme(
              color: Color(0xffFF385C),
              shadowColor: Colors.transparent
          ),

          /// Elevated Button Theme
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(

                  padding: const EdgeInsets.all(15),
                  primary: const Color(0xffFF385C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  )
              ).merge(
                ButtonStyle(elevation: MaterialStateProperty.all(0)),
              )
          ),

          /// TextField Theme
          inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color:  Color(0xffBBBBBB))
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color:  Color(0xffBBBBBB))
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color:  Colors.black54)
              ),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color:  Color(0xffBBBBBB))
              ),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Color(0xffBBBBBB))
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              hintStyle: const TextStyle(
                  color: Color(0xffBBBBBB)
              )
          ),



          indicatorColor: const Color(0xffFF385C),

          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xffFF385C),
          )


      ),
      title: 'NeoShot',
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: token != null ? '/' : '/first_page',
    );
  }
}