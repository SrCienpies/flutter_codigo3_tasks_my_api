import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    String path = "http://192.168.100.5:8000/api/task-list/";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenido",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "My Tasks",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage("https://images.pexels.com/photos/3310693/pexels-photo-3310693.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
