import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/features/home/views/home_pages/add_page.dart';
import 'package:neoshot_mobile/features/home/views/home_pages/favorite_page.dart';
import 'package:neoshot_mobile/features/home/views/home_pages/main_home_page.dart';
import 'package:neoshot_mobile/features/home/views/home_pages/profile_page.dart';
import 'package:neoshot_mobile/utils/bloc/userBloc/user_bloc.dart';
import 'package:neoshot_mobile/utils/repositories/user_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return BlocProvider(
      create: (context) => UserBloc(userRepository: _userRepository),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: const [
            MainHomePage(),
            AddPage(),
            FavoritePage(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.pink, Colors.black])),
          child: BottomNavyBar(
            backgroundColor: Colors.transparent,
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
              _pageController.jumpToPage(index);
            },
            items: [
              BottomNavyBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                title: const Text("Home"),
                icon: const Icon(Icons.home),
              ),
              BottomNavyBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                title: const Text("Add"),
                icon: const Icon(Icons.add_circle_outline_rounded),
              ),
              BottomNavyBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                title: const Text("Favorite"),
                icon: const Icon(Icons.favorite_border_rounded),
              ),
              BottomNavyBarItem(
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                title: const Text("Profile"),
                icon: const Icon(Icons.person_outline_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

