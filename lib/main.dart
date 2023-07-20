import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'AllPersonData.dart';
import 'editData.dart';
import 'details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future allPerson() async {
    var url = "http://192.168.0.238/imagenes/viewAll.php";
    var response = await http.get(Uri.parse(url));
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    allPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base de Datos Libros'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AllPersonData()));
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: GestureDetector(
        child: FutureBuilder(
            future: allPerson(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List list = snapshot.data;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                          ),
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context,
                                        MaterialPageRoute(builder:
                                        (context)=>Details(list: list, index: index)));
                                  },
                                  child: Container(
                                    child: Image.network(
                                        "http://192.168.0.238/imagenes/uploads/${list[index]['image']}"),
                                  ),
                                  //subtitle: Center(child: Text(list[index]['name'])),
                                ),
                              ),
                            ],
                          ),
                        );
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }),
        /*onTap: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditarLibro()));
        },*/
      ),
    );
  }
}
