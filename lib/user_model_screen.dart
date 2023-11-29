import 'dart:convert';

import 'package:flutter/material.dart';

import 'Models/UsersModel.dart';
import 'package:http/http.dart' as http;

class UserModelScreen extends StatefulWidget {
  const UserModelScreen({Key? key}) : super(key: key);

  @override
  State<UserModelScreen> createState() => _UserModelScreenState();
}

class _UserModelScreenState extends State<UserModelScreen> {
  
  List<UsersModel> userList = [];
  
  Future<List<UsersModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){

      for(Map i in data){  // i is any variable that count 0,1,2....., and add data in userList to from json
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Center(child: Text("User Model Screen")),
      ),
      body: Column(
        children: [
          FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<UsersModel>> snapshot){
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                else{
                  List<UsersModel> userList = snapshot.data!;
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                      itemBuilder: (context, index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             ReusableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                              ReusableRow(title: 'Username', value: snapshot.data![index].username.toString()),
                              ReusableRow(title: 'Email', value: snapshot.data![index].email.toString()),


                            ],
                          ),
                        ),
                      );
                  
                      }
                      ),
                );

              })
        ],
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title;
  String value;

   ReusableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Text(title),
        SizedBox(width: 30,),
        Text(value),

      ],
    );
  }
}

