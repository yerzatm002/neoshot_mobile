
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          physics: const BouncingScrollPhysics(),
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
                      fontSize: 25
                  ),
                )
              ],
            ),

            /// Content
            Column(
              children: [

                /// Content 1
                Container(
                  width: width - 40,
                  height: 180,
                  decoration: BoxDecoration(
                      color: Colors.white60,
                      borderRadius: BorderRadius.circular(15)
                  ),
                ),
                const SizedBox(height: 20),

                /// Content 2
                SizedBox(
                  width: width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (width - 40) / 2 - 10,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      Container(
                        width: (width - 40) / 2 - 10,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),


                /// Content 3
                SizedBox(
                  width: width - 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (width - 40) * 0.6 - 10,
                        height: 250,
                        decoration: BoxDecoration(
                            color: Colors.white60,
                            borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: (width - 40) * 0.4 - 10,
                            height: 115,
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: (width - 40) * 0.4 - 10,
                            height: 115,
                            decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(15)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
