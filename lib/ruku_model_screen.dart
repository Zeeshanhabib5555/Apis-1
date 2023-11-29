import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'Models/RukuModel.dart';

class RukuModelScreen extends StatefulWidget {
  @override
  _RukuModelScreenState createState() => _RukuModelScreenState();
}

class _RukuModelScreenState extends State<RukuModelScreen> {
  late Future<RukuModel> rukuModelFuture;

  @override
  void initState() {
    super.initState();
    rukuModelFuture = fetchRukuData();
  }

  Future<RukuModel> fetchRukuData() async {
    final response = await http
        .get(Uri.parse('https://api.alquran.cloud/v1/ruku/7/en.asad'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RukuModel.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Ruku Screen',style: TextStyle(color: Colors.white,fontSize: 30,fontStyle: FontStyle.italic),)),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<RukuModel>(
        future: rukuModelFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final RukuModel rukuModel = snapshot.data!;

            return ListView.builder(
              itemCount: rukuModel.data.ayahs.length,
              itemBuilder: (context, index) {
                Ayah ayah = rukuModel.data.ayahs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 5),
                  child: Card(
                    color: Color(0xFF80CBC4),
                    child: ListTile(
                      title:
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Ruku ${ayah.ruku}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.blue),),
                          Text(
                            'Ayah ${ayah.numberInSurah}: \n${ayah.text}\n Manzil ${ayah.manzil} \n Juz ${ayah.juz}',
                            style: TextStyle(fontSize: 18,),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(' \n Surah: ${ayah.surah.englishName}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.red),),
                          Text(' \n Page No: ${ayah.page}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.deepPurple),),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
// class UpdateText extends StatelessWidget {
//   String title;
//   String value;
//    UpdateText({Key? key, required this.title , required this.value}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: Colors.blue),),
//         Text(value),
//       ],
//     );
//   }
// }
