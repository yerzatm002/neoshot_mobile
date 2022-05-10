
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neoshot_mobile/utils/services/post_service.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  // final PostService _postService = PostService();
  // final _addFormKey = GlobalKey<FormState>();
  // final _titleController = TextEditingController();
  //
  // late XFile _image;
  // final picker = ImagePicker();
  //
  // Future getImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = XFile(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }
  //
  // Widget _buildImage() {
  //   if (_image == null) {
  //     return const Padding(
  //       padding: EdgeInsets.fromLTRB(1, 1, 1, 1),
  //       child: Icon(
  //         Icons.add,
  //         color: Colors.grey,
  //       ),
  //     );
  //   } else {
  //     return Text(_image.path);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // body:  Form(
      //   key: _addFormKey,
      //   child: SingleChildScrollView(
      //     child: Card(
      //         child: Column(
      //           children: <Widget>[
      //             Column(
      //               children: <Widget>[
      //                 const Text('Image Title'),
      //                 TextFormField(
      //                   controller: _titleController,
      //                   decoration: const InputDecoration(
      //                     hintText: 'Enter Title',),
      //                   validator: (value) {
      //                     if (value!.isEmpty) {
      //                       return 'Please enter title';
      //                     }
      //                     return null;
      //                   },
      //                 ),
      //               ],
      //             ),
      //
      //
      //             Container(
      //                 child: OutlineButton(
      //                     onPressed: getImage,
      //                     child: _buildImage())),
      //             Container(
      //               child: Column(
      //                 children: <Widget>[
      //                   RaisedButton(
      //                     onPressed: () {
      //                       if(_addFormKey.currentState!.validate()) {
      //                         _addFormKey.currentState!.save();
      //                         List<XFile> images = [];
      //                         images.add(_image);
      //                         List<String> tags = [];
      //                         _postService.savePost(_titleController.text, images, tags);}},
      //                     child: const Text('Save'),
      //
      //                   )
      //                 ],
      //               ),
      //             ),
      //           ],
      //         )),
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton.icon(
                onPressed: (){ },
                label: const Text("Add photo"),
                icon: const Icon(Icons.add_a_photo),

            ),
            // Text("Don't available yet",
            //   style: GoogleFonts.sigmarOne(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 20
            //   ),
            // ),
            //
            // Text("):",
            //   style: GoogleFonts.sigmarOne(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold,
            //     fontSize: 30
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

