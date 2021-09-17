import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List tasks = [];

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async {
    String path = "http://192.168.100.5:8000/api/task-list/";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.get(_uri);
    if (response.statusCode == 200) {
      tasks = json.decode(response.body);
      setState(() {});
    }
  }

  updateTask(Map task) async {
    String path = "http://192.168.100.5:8000/api/task-update/${task["id"]}/";
    Uri _uri = Uri.parse(path);
    http.Response response = await http.post(
      _uri,
      headers: {
        "Content-Type": "application/json"
      },
      body: json.encode({
        "title": task["title"],
        "description": task["description"],
        "completed": task["completed"],
      }),
    );
    if(response.statusCode == 200){
      print("Actualizado");
    }
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
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bienvenido",
                        style: TextStyle(
                          color: Color(0xff2B2B2B),
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        "My Tasks",
                        style: TextStyle(
                          color: Color(0xff454545),
                          fontWeight: FontWeight.w700,
                          fontSize: 40.0,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/3310693/pexels-photo-3310693.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  ),
                ],
              ),
              SizedBox(
                height: 14.0,
              ),
              ListView.builder(
                itemCount: tasks.length,
                primary: true,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12.withOpacity(0.04),
                          offset: Offset(2, 6),
                          blurRadius: 12,
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        tasks[index]["title"],
                        style: TextStyle(
                          decoration: tasks[index]["completed"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      subtitle: Text(tasks[index]["description"]),
                      trailing: Checkbox(
                        value: tasks[index]["completed"],
                        onChanged: (bool? value) {
                          tasks[index]["completed"] = value;
                          updateTask(tasks[index]);
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
