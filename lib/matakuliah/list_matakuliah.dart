import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa_sister/matakuliah/edit_matakuliah.dart';
import 'package:mahasiswa_sister/matakuliah/insert_matakuliah.dart';
import 'package:mahasiswa_sister/matakuliah/search_matakuliah.dart';

class ListMatakuliah extends StatefulWidget {
  const ListMatakuliah({Key? key}) : super(key: key);

  @override
  _ListMatakuliahState createState() => _ListMatakuliahState();
}

class _ListMatakuliahState extends State<ListMatakuliah> {
  List<dynamic> matakuliah = [];

  Future<void> getMatakuliah() async {
    String urlGet = "http://10.127.253.3:9002/api/v1/matakuliah";
    try {
      var response = await http.get(Uri.parse(urlGet));

      if (response.statusCode == 200) {
        print(response.body);

        if (response.body.isNotEmpty) {
          setState(() {
            matakuliah = jsonDecode(response.body);
          });
        } else {
          print("Empty response body");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getMatakuliah();
  }

  Future<void> deleteMatakuliah(int idmatkul) async {
    String Urldel = "http://10.127.253.3:9002/api/v1/matakuliah/$idmatkul";
    try {
      var responDel = await http.delete(
        Uri.parse(Urldel),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"id" : idmatkul}),
      );

      if (responDel.statusCode == 200) {
        print('Data berhasil dihapus');
      } else {
        print('Gagal menghapus data. Status: ${responDel.statusCode}');
      }
    } catch (exc) {
      print(exc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(240, 235, 206, 1),
        backgroundColor: Color.fromRGBO(57, 81, 68, 1.0),
        elevation: 0,
        title: const Text(
          'List Matakuliah',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MatakuliahSearchDelegate(matakuliah),
              );
            },
            icon: const Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: matakuliah.length,
          itemBuilder: (context, index) {
            return _listMatakuliah(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (context) => const InsertMatakuliah()));
        },
        backgroundColor: const Color.fromRGBO(78, 108, 80, 1.0),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _listMatakuliah(int index) {
    return Column(
      children: [
          ListTile(
            title: Text(
              "${matakuliah[index]['nama']}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            subtitle: Text(
              "${matakuliah[index]['kode']}, ${matakuliah[index]['sks'].toString()} SKS",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditMatakuliah(
                          id: matakuliah[index]["id"],
                          nama: matakuliah[index]["nama"],
                          kode: matakuliah[index]["kode"],
                          sks: matakuliah[index]["sks"].toString(),
                          )
                        )
                    );
                  },
                  icon: Icon(Icons.edit,size: 17, color: Color.fromRGBO(78, 108, 80, 1.0)),
                ),
                IconButton(
                  onPressed: () async{
                    await deleteMatakuliah(matakuliah[index]["id"]);
                    getMatakuliah();
                  },
                  icon: Icon(Icons.delete,size: 17, color: Color.fromRGBO(78, 108, 80, 1.0)),
                ),
              ],
            )
        ),
        const Divider(
          color: Colors.grey,
          height: 1,
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
      ],
    );
  }
}
