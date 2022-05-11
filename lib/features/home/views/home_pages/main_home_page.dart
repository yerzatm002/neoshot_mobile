import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neoshot_mobile/configuration/configuration.dart';
import 'package:neoshot_mobile/utils/bloc/postBloc/post_bloc.dart';
import 'package:neoshot_mobile/utils/model/post_model.dart';
import 'package:neoshot_mobile/utils/repositories/post_repository.dart';
import 'package:neoshot_mobile/utils/services/post_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  List<Post> posts = [];

  PostRepository postRepository = PostRepository();
  late PostBloc postBloc;

  final RefreshController refreshController =
  RefreshController(initialRefresh: true);

  final PostService _postService = PostService();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery
        .of(context)
        .size
        .width;

    return BlocProvider(
        create: (context) => PostBloc(postRepository: postRepository),
        child: Scaffold(
              backgroundColor: Colors.black,
              body: Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        // shrinkWrap: true,
                        //   physics: const ClampingScrollPhysics(),
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Column(
                              children: [
                                /// Header Title
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 120),
                                    /// Title
                                    Text(
                                      "NeoShot",
                                      style: GoogleFonts.sigmarOne(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    )
                                  ],
                                ),

                                /// Search
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width - 40,
                                      child: TextField(
                                        style: const TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          fillColor: Colors.white38,
                                          filled: true,
                                          hintText: "Search",
                                          prefixIcon: const Icon(
                                            Icons.search,
                                            color: Colors.white,
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0),
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0),
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0),
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0),
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  width: 0),
                                              borderRadius: BorderRadius.circular(
                                                  20)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),

                                /// Categories
                                SizedBox(
                                  height: 50,
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: [

                                      /// Category
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        child: Text(
                                          "Trending",
                                          style: GoogleFonts.sigmarOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        child: Text(
                                          "Tag 1",
                                          style: GoogleFonts.sigmarOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        child: Text(
                                          "Tag 2",
                                          style: GoogleFonts.sigmarOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        child: Text(
                                          "Tag 2",
                                          style: GoogleFonts.sigmarOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        child: Text(
                                          "Tag 2",
                                          style: GoogleFonts.sigmarOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),

                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.white38,
                                            borderRadius: BorderRadius.circular(
                                                15)),
                                        child: Text(
                                          "Tag 2",
                                          style: GoogleFonts.sigmarOne(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                            BlocBuilder<PostBloc, PostState>(
                            builder: (context, state){
                              postBloc = BlocProvider.of<PostBloc>(context);
                              if (state is PostInitial) {
                                postBloc.add(PostLoadEvent());
                                return Container();
                              }
                              if (state is PostLoadingState) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (state is PostErrorState) {
                                return Center(
                                  child: Text(
                                    "",
                                    style: GoogleFonts.inter(color: Colors.red),
                                  ),
                                );
                              }

                              if(state is PostLoadedState){
                                return ListView.builder(
                                  shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: state.posts.length,
                                    itemBuilder: (context, index){
                                      print(state.posts[index].fimage);
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                                        child: Container(
                                          width:  40,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            color: Colors.white60,
                                            borderRadius: BorderRadius.circular(15),
                                            image: DecorationImage(
                                              image: NetworkImage(state.posts[index].fimage),

                                              /// Change from Fill to Cover
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                );
                              }
                              return const Center(
                                child: Text("Unknown error"),
                              );
                            }
                            )
                            //      Scaffold(
                            //        backgroundColor: Colors.black,
                            //        body: SmartRefresher(
                            //          controller: refreshController,
                            //          enablePullUp: true,
                            //          onRefresh: () async {
                            //            final result = await _postService.getPosts();
                            //            if (result != null) {
                            //              refreshController.refreshCompleted();
                            //              posts.addAll(result);
                            //              setState(() {});
                            //            } else {
                            //              refreshController.refreshFailed();
                            //            }
                            //          },
                            //          onLoading: () async {
                            //            final result = await _postService.getPosts();
                            //            if (result != null) {
                            //              refreshController.loadComplete();
                            //              posts.addAll(result);
                            //              setState(() {});
                            //            } else {
                            //              refreshController.loadFailed();
                            //            }
                            //          },
                            //          child: ListView.separated(
                            //            itemBuilder: (context, index) {
                            //              final post = posts[index];
                            //              return Column(children: [
                            //              /// Content 1
                            //              Container(
                            //                width:  40,
                            //                height: 180,
                            //                decoration: BoxDecoration(
                            //                  color: Colors.white60,
                            //                  borderRadius: BorderRadius.circular(15),
                            //                  image: DecorationImage(
                            //                    image: NetworkImage(post.fimage),
                            //                    fit: BoxFit.fill,
                            //                  ),
                            //                ),
                            //              ),
                            //              const SizedBox(height: 20),
                            //            ]);
                            //            },
                            //            separatorBuilder: (context, index) =>
                            //            const Divider(),
                            //            itemCount: posts.length,
                            //          ),
                            //        )
                            //      )
                          ]
                      )
                  )
          // return SmartRefresher(
          // controller: refreshController,
          // enablePullUp: true,
          // onRefresh: () async {
          //   final result = await _postService.getPosts();
          //   if (result!.isNotEmpty) {
          //     refreshController.refreshCompleted();
          //     posts.addAll(result);
          //     setState(() {});
          //   } else {
          //     refreshController.refreshFailed();
          //   }
          // },
          // onLoading: () async {
          //   final result = await _postService.getPosts();
          //   if (result!.isNotEmpty) {
          //     refreshController.loadComplete();
          //     posts.addAll(result);
          //     setState(() {});
          //   } else {
          //     refreshController.loadFailed();
          //   }
          // },
          // child: ListView.separated(
          //   itemBuilder: (context, index) {
          //     final post = posts[index];
          //
          //     return Scaffold(
          //
          //
          //       ///Content
          //
          //       /// Content
          //       Column(
          //         children: [
          //
          //           /// Content 1
          //           Container(
          //             width: width - 40,
          //             height: 180,
          //             decoration: BoxDecoration(
          //               color: Colors.white60,
          //               borderRadius: BorderRadius.circular(15),
          //               image: DecorationImage(
          //                 image: NetworkImage(post.fimage),
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //           ),
          //           const SizedBox(height: 20),
          //
          //           // /// Content 2
          //           // SizedBox(
          //           //   width: width - 40,
          //           //   child: Row(
          //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           //     children: [
          //           //       Container(
          //           //         width: (width - 40) / 2 - 10,
          //           //         height: 120,
          //           //         decoration: BoxDecoration(
          //           //           color: Colors.white60,
          //           //           borderRadius: BorderRadius.circular(15),
          //           //           image: DecorationImage(
          //           //             image: NetworkImage(posts[index+1].firstImage),
          //           //             fit: BoxFit.fill,
          //           //           ),
          //           //         ),
          //           //       ),
          //           //       Container(
          //           //         width: (width - 40) / 2 - 10,
          //           //         height: 120,
          //           //         decoration: BoxDecoration(
          //           //           color: Colors.white60,
          //           //           borderRadius: BorderRadius.circular(15),
          //           //           image: DecorationImage(
          //           //             image: NetworkImage(posts[index+2].firstImage),
          //           //             fit: BoxFit.fill,
          //           //           ),
          //           //         ),
          //           //       ),
          //           //     ],
          //           //   ),
          //           // ),
          //           // const SizedBox(height: 20),
          //           //
          //           //
          //           // /// Content 3
          //           // SizedBox(
          //           //   width: width - 40,
          //           //   child: Row(
          //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           //     children: [
          //           //       Container(
          //           //         width: (width - 40) * 0.6 - 10,
          //           //         height: 250,
          //           //         decoration: BoxDecoration(
          //           //           color: Colors.white60,
          //           //           borderRadius: BorderRadius.circular(15),
          //           //           image: DecorationImage(
          //           //             image: NetworkImage(posts[index+3].firstImage),
          //           //             fit: BoxFit.fill,
          //           //           ),
          //           //         ),
          //           //       ),
          //           //       Column(
          //           //         children: [
          //           //           Container(
          //           //             width: (width - 40) * 0.4 - 10,
          //           //             height: 115,
          //           //             decoration: BoxDecoration(
          //           //               color: Colors.white60,
          //           //               borderRadius: BorderRadius.circular(15),
          //           //               image: DecorationImage(
          //           //                 image: NetworkImage(posts[index+4].firstImage),
          //           //                 fit: BoxFit.fill,
          //           //               ),
          //           //             ),
          //           //           ),
          //           //           const SizedBox(height: 20),
          //           //           Container(
          //           //             width: (width - 40) * 0.4 - 10,
          //           //             height: 115,
          //           //             decoration: BoxDecoration(
          //           //               color: Colors.white60,
          //           //               borderRadius: BorderRadius.circular(15),
          //           //               image: DecorationImage(
          //           //                 image: NetworkImage(posts[index+4].firstImage),
          //           //                 fit: BoxFit.fill,
          //           //               ),
          //           //             ),
          //           //           ),
          //           //         ],
          //           //       ),
          //           //     ],
          //           //   ),
          //           // ),
          //         ],
          //       ),
          //       ],
          //     ),)
          //     ,
          //     );
          //   },
          //   separatorBuilder: (context, index) => Divider(),
          //   itemCount: posts.length,
          ),

        );

  }
}
