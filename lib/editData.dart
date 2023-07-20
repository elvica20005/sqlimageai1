import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'main.dart';
import 'details.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {
  final List list;
  final int index;


  EditData({super.key, required this.list, required this.index});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  File? _image;
  final picker = ImagePicker();

  TextEditingController  id = TextEditingController();
  TextEditingController  name = TextEditingController();
  TextEditingController  autor = TextEditingController();
  TextEditingController  editorial = TextEditingController();
  //TextEditingController  cpassword;

  Future ChoiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path.toString());
    });
  }

  Future EditData() async {
    final uri =
    Uri.parse("http://192.168.0.238/imagenes/editdata.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = name.text;
    request.fields['autor'] = autor.text;
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
  void initState(){
    id=TextEditingController(text: widget.list[widget.index]['id']);
    name=TextEditingController(text: widget.list[widget.index]['name']);
    autor=TextEditingController(text: widget.list[widget.index]['autor']);
    editorial=TextEditingController(text: widget.list[widget.index]['editorial']);

    //cpassword=new TextEditingController(text: widget.list[widget.index]['password']);
    super.initState();
    EditData().whenComplete(() {
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT DATA"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              widget.list[widget.index]['id'],
              style: const TextStyle(fontSize: 20.0),
            ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                    hintText: "Titulo",
                    labelText: "Titulo"),
              ),
            TextField(
              controller: autor,
              decoration: const InputDecoration(
                  hintText: "Autor",
                  labelText: "Autor"),
            ),
            TextField(
              controller: editorial,
              decoration: const InputDecoration(
                  hintText: "Editorial",
                  labelText: "Editorial"),
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
                child: const Text("Guardar"),
                onPressed: () {
                  EditData();
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