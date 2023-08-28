import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
List<dynamic> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          const url='https://randomuser.me/api/?results=50';
          final uri=Uri.parse(url);
          final response= await http.get(uri);
          final body=response.body;
          final json=jsonDecode(body);

          setState(() {
            users=json['results'];
          });

        },

        child: const Icon(Icons.send_outlined),
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder:(context,index)=>
           ListTile(
             leading: CircleAvatar(
               radius: 25,
               backgroundImage: NetworkImage(users[index]['picture']['large']),

             ),
             title:Text(''
                 '${users[index]['name']['first']} '
                 '${users[index]['name']['last']}'
             ) ,
             subtitle: Text(users[index]['email']),
           ),
      ),

    );
  }
}
