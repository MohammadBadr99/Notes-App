import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //////////////////////////////////////////////////////////////////////////////
  ///////////////////////////IMAGE PICKER///////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////

  late XFile Image;
  final imagePicker = ImagePicker();

  UploadImageFromGallery() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Image = XFile(pickedImage.path);
    } else {}
  }

  UploadImageFromCamera() async {
    var PickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (PickedImage != null) {
      Image = XFile(PickedImage.path);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Add new Note"),
      ),
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.only(top: 10),
        child: ListView.separated(
          separatorBuilder: (context, i) {
            return const Divider(
              height: 10,
              color: Colors.transparent,
            );
          },
          itemBuilder: (context, i) {
            return i == 0
                ? Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      maxLength: 50,
                      decoration: const InputDecoration(
                        counterStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        label: Text(
                          "Title",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.white, width: 3),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.blue, width: 3),
                        ),
                        prefixIcon: Icon(
                          Icons.title,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      TextFormField(
                        maxLines: null,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          label: Text(
                            "Enter your notes",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.white, width: 3),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: Colors.blue, width: 3),
                          ),
                          prefixIcon: Icon(
                            Icons.text_fields,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Divider(
                        color: Colors.transparent,
                      ),
                      GestureDetector(
                        onTapDown: (tab) {},
                        onTapUp: (tab) {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  color: Colors.grey,
                                  height: 150,
                                  child: ListView(
                                    children: [
                                      Container(
                                        color: Colors.amber,
                                        width: double.infinity,
                                        child: const Text(
                                          "Please Choose an Image",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      InkWell(
                                        onTap: UploadImageFromGallery,
                                        //onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.image),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            Text(
                                              "Choose from gallery",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      InkWell(
                                        onTap: UploadImageFromCamera,
                                        //onTap: () {},
                                        child: Row(
                                          children: const [
                                            Icon(Icons.camera),
                                            VerticalDivider(
                                              width: 10,
                                            ),
                                            Text(
                                              "Import from camera",
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        onTapCancel: () {},
                        child: Container(
                          height: 40,
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 80),
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Row(
                            children: const [
                              VerticalDivider(
                                color: Colors.transparent,
                                width: 25,
                              ),
                              Icon(Icons.image),
                              VerticalDivider(
                                color: Colors.transparent,
                              ),
                              Text(
                                "Choose Image",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          print("Hi");
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  );
          },
          itemCount: 2,
        ),
      ),
    );
  }
}
