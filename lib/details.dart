import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:sqlimageai1/editData.dart';
import 'package:http/http.dart' as http;
import 'package:sqlimageai1/editData.dart';

class Details extends StatefulWidget {
  final List list;
  final int index;

  //File? _image;

  Details({super.key, required this.list, required this.index});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _image = _image;
    setState(() {
      _image = _image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.list[widget.index]['name']}",
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (_image != null)
                  SizedBox(
                    width: 300,
                    height: 420,
                    child: Image.file(_image!),
                  ),
                Text(
                  widget.list[widget.index]['id'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  widget.list[widget.index]['name'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  widget.list[widget.index]['autor'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                Text(
                  widget.list[widget.index]['editorial'],
                  style: const TextStyle(fontSize: 20.0),
                ),
                MaterialButton(
                    child: Text("Editar"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditData(
                                  list: widget.list, index: widget.index)));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
