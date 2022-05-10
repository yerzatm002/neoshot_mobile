import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neoshot_mobile/features/home/views/home_page.dart';
import 'package:neoshot_mobile/utils/bloc/userBloc/user_bloc.dart';
import 'package:neoshot_mobile/utils/model/report_model.dart';
import 'package:neoshot_mobile/utils/services/report_service.dart';
import 'package:neoshot_mobile/utils/services/upload_image_service.dart';
import 'package:neoshot_mobile/utils/services/user_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<ReportModel> reports = [];

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  /// Controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController instagramController = TextEditingController();

  /// Password Controller
  TextEditingController lastPasswordController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final UploadImageService _uploadImageService = UploadImageService();
  final UserService _userProvider = UserService();
  late UserBloc _userBloc;
  final ReportService _reportService = ReportService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            _userBloc = BlocProvider.of<UserBloc>(context);

            if (state is UserInitial) {
              _userBloc.add(UserLoadEvent());
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              );
            }

            if (state is UserErrorState) {
              FlutterSecureStorage storage = const FlutterSecureStorage();
              storage.delete(key: 'token');
              Navigator.popAndPushNamed(context, '/first_page');
              return const Center(child: Text(""));
            }

            if (state is UserLoadedState) {
              return SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 400.0,
                        floating: false,
                        flexibleSpace: FlexibleSpaceBar(
                          /// Tab bar
                          title: ElevatedButton.icon(
                              onPressed: () {
                                FlutterSecureStorage storage =
                                    const FlutterSecureStorage();
                                storage.delete(key: 'token');
                                Navigator.popAndPushNamed(
                                    context, '/first_page');
                              },
                              label: const Text("LogOut"),
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 8,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.pinkAccent,
                                fixedSize: const Size(120, 20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                textStyle: GoogleFonts.orbitron(
                                    color: Colors.white, fontSize: 6),
                              )),
                          centerTitle: true,
                          titlePadding: const EdgeInsets.only(left: 200.0),
                          background: Container(
                            decoration:
                                const BoxDecoration(color: Colors.black),
                            child: Container(
                              color: Colors.white24,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  /// Avatar
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 50,
                                        child: Stack(
                                          children: [
                                            /// Image
                                            CircleAvatar(
                                              radius: 50,
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      state.userModel.image),
                                            ),

                                            /// Edit Button
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  XFile? image =
                                                      await _picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);

                                                  if (image != null) {
                                                    bool result =
                                                        await _uploadImageService
                                                            .uploadUserImage(
                                                                state.userModel
                                                                    .id,
                                                                image.path,
                                                                image.name);
                                                    if (result) {
                                                      _userBloc
                                                          .add(UserLoadEvent());
                                                    } else {}
                                                  }
                                                },
                                                child: const CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xffFF385C),
                                                  radius: 15,
                                                  child: Icon(
                                                    Icons.photo_camera,
                                                    color: Colors.white,
                                                    size: 13,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 15),

                                  /// Name
                                  Text(
                                    state.userModel.username,
                                    style: GoogleFonts.sigmarOne(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  const SizedBox(height: 15),

                                  Text(
                                    "200 subs",
                                    style:
                                        GoogleFonts.orbitron(color: Colors.red),
                                  ),
                                  const SizedBox(height: 25),

                                  /// Address and Instagram
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// Address
                                      const Icon(
                                        Icons.location_on_rounded,
                                        color: Colors.white,
                                      ),

                                      Text(
                                        state.userModel.city.name,
                                        style: GoogleFonts.orbitron(
                                            color: Colors.white),
                                      ),

                                      const SizedBox(width: 20),

                                      /// Instagram
                                      const Icon(
                                        Icons.camera_alt_rounded,
                                        color: Colors.white,
                                      ),

                                      Text(
                                        state.userModel.instagram,
                                        style: GoogleFonts.orbitron(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  /// Email
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// Instagram
                                      const Icon(
                                        Icons.mail_outline_rounded,
                                        color: Colors.white,
                                      ),

                                      Text(
                                        state.userModel.email,
                                        style: GoogleFonts.orbitron(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          TabBar(
                            overlayColor:
                                MaterialStateProperty.all(Colors.black),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(color: Colors.pink)),
                            tabs: const [
                              Tab(
                                // icon: Icon(Icons.photo),
                                text: "My Photos",
                              ),
                              Tab(
                                  // icon: Icon(Icons.lightbulb_outline),
                                  text: "Posts"),
                              Tab(
                                  // icon: Icon(Icons.edit),
                                  text: "Edit"),
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(
                    children: <Widget>[
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate([
                              /// Content
                              Column(
                                children: [
                                  const SizedBox(height: 20),

                                  /// Content 1
                                  Container(
                                    width: width - 40,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        image: const DecorationImage(
                                    image: AssetImage(
                                    'assets/background/san_francisco.jpg'),
                                    fit: BoxFit.fill,
                                  ),
                                        color: Colors.white60,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  const SizedBox(height: 20),

                                  /// Content 2
                                  SizedBox(
                                    width: width - 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: (width - 40) / 2 - 10,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        Container(
                                          width: (width - 40) / 2 - 10,
                                          height: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  /// Content 3
                                  SizedBox(
                                    width: width - 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: (width - 40) * 0.6 - 10,
                                          height: 250,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: (width - 40) * 0.4 - 10,
                                              height: 115,
                                              decoration: BoxDecoration(
                                                  color: Colors.white60,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              width: (width - 40) * 0.4 - 10,
                                              height: 115,
                                              decoration: BoxDecoration(
                                                  color: Colors.white60,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  /// Content 1
                                  Container(
                                    width: width - 40,
                                    height: 180,
                                    decoration: BoxDecoration(
                                        color: Colors.white60,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                  const SizedBox(height: 20),

                                  /// Content 3
                                  SizedBox(
                                    width: width - 40,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: (width - 40) * 0.6 - 10,
                                          height: 250,
                                          decoration: BoxDecoration(
                                              color: Colors.white60,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: (width - 40) * 0.4 - 10,
                                              height: 115,
                                              decoration: BoxDecoration(
                                                  color: Colors.white60,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                            const SizedBox(height: 20),
                                            Container(
                                              width: (width - 40) * 0.4 - 10,
                                              height: 115,
                                              decoration: BoxDecoration(
                                                  color: Colors.white60,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ]),
                          )
                        ],
                      ),
                      Scaffold(
                          backgroundColor: Colors.black,
                          body: SmartRefresher(
                            controller: refreshController,
                            enablePullUp: true,
                            onRefresh: () async {
                              final result = await _reportService.getReport();
                              if (result != null) {
                                refreshController.refreshCompleted();
                                reports.addAll(result);
                                setState(() {});
                              } else {
                                refreshController.refreshFailed();
                              }
                            },
                            onLoading: () async {
                              final result = await _reportService.getReport();
                              if (result != null) {
                                refreshController.loadComplete();
                                reports.addAll(result);
                                setState(() {});
                              } else {
                                refreshController.loadFailed();
                              }
                            },
                            child: ListView.separated(
                              itemBuilder: (context, index) {
                                final report = reports[index];
                                return Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ListTile(
                                    title: Text(report.fromUser),
                                    subtitle: Text(report.text),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: reports.length,
                            ),
                          )),
                      // CustomScrollView(
                      //   slivers: [
                      //     SliverList(
                      //       delegate: SliverChildListDelegate(
                      //           [
                      //             /// Content
                      //             Column(
                      //               children:  [
                      //                 const SizedBox(height: 20),
                      //                 Padding(
                      //                   padding: const EdgeInsets.all(10.0),
                      //                   child:Container(
                      //                       decoration: BoxDecoration(
                      //                           color: Colors.white60,
                      //                           borderRadius: BorderRadius.circular(15)
                      //                       ),
                      //                       child: const ListTile(
                      //                           title: Text("erzatnis@gmail.com"),
                      //                           subtitle: Text("something!"),
                      //                         ),
                      //                       )
                      //                   )
                      //               ],
                      //             )
                      //           ]
                      //       ),
                      //     )
                      //   ],
                      // ),
                      Scaffold(
                        backgroundColor: Colors.black,
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
                                        "User data",
                                        style: GoogleFonts.inter(
                                            color: Colors.pink,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  /// First Name
                                  TextField(
                                    controller: usernameController,
                                    decoration: const InputDecoration(
                                      hintText: "username",
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),

                                  /// Last Name
                                  TextField(
                                      controller: instagramController,
                                      decoration: const InputDecoration(
                                          hintText: "instagram"),
                                      style:
                                          const TextStyle(color: Colors.white)),
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
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });

                                          try {
                                            bool result = await _userProvider
                                                .changeUserInfo(
                                                    usernameController.text,
                                                    instagramController.text,
                                                    state.userModel.image);
                                            if (result) {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  // barrierColor: Colors.transparent,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      elevation: 0,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                      title: const Text(
                                                        "Data has been successfully changed!",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      content: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child: const Center(
                                                            child: Icon(
                                                                Icons
                                                                    .check_rounded,
                                                                color: Colors
                                                                    .green,
                                                                size: 50)),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              // Navigator.pop(context);
                                                              // Navigator.pop(context);
                                                              // Navigator.pop(context);
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const HomePage()),
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/'));
                                                            },
                                                            child: const Text(
                                                                "Good!"))
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  // barrierColor: Colors.transparent,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      elevation: 0,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(25),
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                            child: const Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 50)),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                // barrierColor: Colors.transparent,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    elevation: 0,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(25),
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                              size: 60),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        child: const Text("Save changes!")),
                                  ),

                                  const SizedBox(height: 50),

                                  /// Title
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Change Password",
                                        style: GoogleFonts.inter(
                                            color: const Color(0xffFF385C),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),

                                  /// Last Password
                                  TextField(
                                      obscureText: true,
                                      controller: lastPasswordController,
                                      decoration: const InputDecoration(
                                          hintText: "Current Password"),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(height: 10),

                                  /// New Password
                                  TextField(
                                      obscureText: true,
                                      controller: passwordController,
                                      decoration: const InputDecoration(
                                          hintText: "New Password"),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  const SizedBox(height: 10),

                                  /// Repeat New password
                                  TextField(
                                      obscureText: true,
                                      controller: confirmPasswordController,
                                      decoration: const InputDecoration(
                                          hintText: "Confirm Password"),
                                      style:
                                          const TextStyle(color: Colors.white)),
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
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });

                                          try {
                                            bool result = await _userProvider
                                                .changeUserPassword(
                                                    lastPasswordController.text,
                                                    passwordController.text);
                                            if (result) {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  // barrierColor: Colors.transparent,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      elevation: 0,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                      title: const Text(
                                                        "Password successfully changed!",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      content: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child: const Center(
                                                            child: Icon(
                                                                Icons
                                                                    .check_rounded,
                                                                color: Colors
                                                                    .green,
                                                                size: 50)),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              // Navigator.pop(context);
                                                              // Navigator.pop(context);
                                                              // Navigator.pop(context);
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const HomePage()),
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/'));
                                                            },
                                                            child: const Text(
                                                                "Good!"))
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  // barrierColor: Colors.transparent,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      elevation: 0,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(25),
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                            child: const Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 50)),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                // barrierColor: Colors.transparent,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    elevation: 0,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(25),
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                              size: 60),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        child: const Text("Save changes!")),
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
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  content: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child:
                                                            const CircularProgressIndicator(),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              });

                                          try {
                                            bool result =
                                                await _uploadImageService
                                                    .deleteUserImage(
                                                        state.userModel.id);
                                            if (result) {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  // barrierColor: Colors.transparent,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      elevation: 0,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      32.0))),
                                                      title: const Text(
                                                        "Image successfully deleted!",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      actionsAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      content: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(25),
                                                        width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25)),
                                                        child: const Center(
                                                            child: Icon(
                                                                Icons
                                                                    .check_rounded,
                                                                color: Colors
                                                                    .green,
                                                                size: 50)),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              // Navigator.pop(context);
                                                              // Navigator.pop(context);
                                                              // Navigator.pop(context);
                                                              Navigator.pushAndRemoveUntil(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              const HomePage()),
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/'));
                                                            },
                                                            child: const Text(
                                                                "Good!"))
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  // barrierColor: Colors.transparent,
                                                  builder: (_) {
                                                    return AlertDialog(
                                                      elevation: 0,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      content: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(25),
                                                            width: 100,
                                                            height: 100,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            25)),
                                                            child: const Center(
                                                                child: Icon(
                                                                    Icons
                                                                        .close_rounded,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 50)),
                                                          )
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            }
                                          } catch (e) {
                                            Navigator.pop(context);
                                            showDialog(
                                                context: context,
                                                // barrierColor: Colors.transparent,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    elevation: 0,
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    content: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(25),
                                                          width: 100,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          25)),
                                                          child: const Icon(
                                                              Icons.close,
                                                              color: Colors.red,
                                                              size: 60),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                          }
                                        },
                                        child: const Text("Delete an avatar!")),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: Text(""));
          },
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.8,
      color: Colors.black,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
