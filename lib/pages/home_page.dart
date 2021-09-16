import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  initState(){
    super.initState();
    getData();
  }

  getData() async{
    String path = "http://192.168.100.5:8000/api/task-list/";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

