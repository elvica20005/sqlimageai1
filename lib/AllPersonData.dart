import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'main.dart';



class AllPersonData extends StatefulWidget {
  const AllPersonData({super.key});

  @override
  _AllPersonDataState createState() => _AllPersonDataState();
}

class _AllPersonDataState extends State<AllPersonData> {

  File? _image;
  final picker = ImagePicker();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController autorcontrol = TextEditingController();
  TextEditingController editorial = TextEditingController();

  Future ChoiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path.toString());
    });
  }

  Future UploadImage() async {
    final uri =
    Uri.parse("http://192.168.0.238/imagenes/upload.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = namecontroller.text;
    request.fields['autor'] = autorcontrol.text;
    request.fields['editorial'] = editorial.text;
    var pic = await http.MultipartFile.fromPath("image", _image!.path);
    request.files.add(pic);

    var response = await request.send();
    if (response.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Image Uploaded");
    }
    setState(() {});
  }

  @override
  void initState() {
    //TODO: implement initState
    super.initState();
    UploadImage().whenComplete(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MySQL Image Upload"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: namecontroller,
                decoration: const InputDecoration(labelText: "Titulo"),
              ),
            ),
            TextField(
              controller: autorcontrol,
              decoration: const InputDecoration(labelText: "Autor"),
            ),
            TextField(
              controller: editorial,
              decoration: const InputDecoration(labelText: "Editorial"),
            ),
            IconButton(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  ChoiceImage();
                }),
            Container(
              child: _image == null
                  ? const Text("No image Selected")
                  : Image.file(_image!),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
                child: const Text("Upload Image"),
                onPressed: () {
                  UploadImage();
                  Future.delayed(const Duration(milliseconds: 100), () {
                    //Do something
                  });
                  Future.delayed(const Duration(milliseconds: 2000), () {
                    //Do something
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  });
                })
          ],
        ),
      ),
    );
  }
}