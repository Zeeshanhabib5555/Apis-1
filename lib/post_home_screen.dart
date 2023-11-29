import 'dart:convert';

import 'package:flutter/material.dart';

import 'Models/PostModel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postlist = []; // Declare the name of the list / array
  initState() {
    super.initState();
    getPostApi();
    // postlist=getPostApi() as List<PostModel>;
  }

  Future<List<PostModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      print(response.body);
      print('data hit');
      for (Map i in data) {
        postlist.add(PostModel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Center(child: Text("APIs")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, AsyncSnapshot<List<PostModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Loading'));
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else {
                    List<PostModel> postlist = snapshot.data!;
                    return ListView.builder(
                        itemCount: postlist.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("ID",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orangeAccent,fontSize: 15),),
                            Text(postlist[index].id.toString()),
                                SizedBox(height: 15,),
                                Text("TITLE",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 15),),
                          Text(postlist[index].title.toString()),
                                SizedBox(height: 15,),
                                Text("BODY",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 15),),
                                Text(postlist[index].body.toString()),
                              ],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
