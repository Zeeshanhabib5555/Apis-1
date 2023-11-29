import 'dart:convert';

import 'package:flutter/material.dart';

import 'Models/ruku_model_2.dart';
import 'package:http/http.dart' as http;
class RukuModelScreen2 extends StatefulWidget {
  const RukuModelScreen2({Key? key}) : super(key: key);

  @override
  State<RukuModelScreen2> createState() => _RukuModelScreen2State();
}

class _RukuModelScreen2State extends State<RukuModelScreen2> {

  late Future<RukuModel2> rukuModelFuture;

  @override
  void initState() {
    super.initState();
    rukuModelFuture = fetchRukuData();
  }

  Future<RukuModel2> fetchRukuData() async {
    final response = await http
        .get(Uri.parse('http://api.alquran.cloud/v1/ruku/7/quran-uthmani'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return RukuModel2.fromJson(data);
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
      body: FutureBuilder<RukuModel2>(
        future: rukuModelFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final RukuModel2 rukuModel = snapshot.data!;

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
