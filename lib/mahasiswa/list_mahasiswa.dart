import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mahasiswa_sister/first_page.dart';
import 'package:mahasiswa_sister/mahasiswa/data_mahasiswa.dart';
import 'package:mahasiswa_sister/mahasiswa/insert_mahasiswa.dart';
import 'package:http/http.dart' as http;
import 'package:mahasiswa_sister/mahasiswa/search_mahasiswa.dart';
import 'package:mahasiswa_sister/nilai/list_nilai.dart';

class ListMahasiswa extends StatefulWidget {
  const ListMahasiswa({super.key});

  @override
  State<ListMahasiswa> createState() => _ListMahasiswaState();
}

class _ListMahasiswaState extends State<ListMahasiswa> {

  List mahasiswa = [];

  Future<void> getUser() async {
    String urlGet = "http://10.127.253.3:9001/api/v1/mahasiswa";
    try {
      var response = await http.get(Uri.parse(urlGet));

      if (response.statusCode == 200) {
        print(response.body);

        if (response.body.isNotEmpty) {
          setState(() {
            mahasiswa = jsonDecode(response.body);
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

  Future<void> deleteMahasiswa(int idmhs) async{
    String Urldel = "http://10.127.253.3:9001/api/v1/mahasiswa/${idmhs}";
    try{
      var responDel = await http.delete(
        Uri.parse(Urldel),
        headers: <String, String>{
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({"id" : idmhs}),
      );

      var result = json.decode(responDel.body);
      if(result["success"] == "true"){
        print('Data berhasil dihapus');
      }else{
        print('Data gagal dihapus');
      }

      LandingPage();
    }catch(exc){
      print(exc);
    }
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromRGBO(240, 235, 206, 1),
        backgroundColor: Color.fromRGBO(57, 81, 68, 1.0),
        elevation: 0,
        title: const Text(
          'List Mahasiswa',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ListNilai()
                )
            );
          },
          icon: const Icon(
            Icons.checklist_rtl,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MahasiswaSearchDelegate(mahasiswa),
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
          itemCount: mahasiswa.length,
          itemBuilder: (context, index) {
            return _listuser(index);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (context) => const InsertMahasiswa()));
        },
        backgroundColor: const Color.fromRGBO(78, 108, 80, 1.0),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _listuser(int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DataMahasiswa(
                id: mahasiswa[index]['id'],
                nm: mahasiswa[index]['nama'],
                ml: mahasiswa[index]['email'],
                tgl: mahasiswa[index]['tgllahir'],)
              )
            );
          },
          child: ListTile(
            title: Text(
              "${mahasiswa[index]['nama']}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
            subtitle: Text(
              "${mahasiswa[index]['email']}",
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                "${mahasiswa[index]['tgllahir']}",
                style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
                ),
                ),
                IconButton(
                  onPressed: () async{
                    await deleteMahasiswa(mahasiswa[index]["id"]);
                    getUser();
                  },
                  icon: Icon(Icons.delete,size: 17, color: Color.fromRGBO(57, 81, 68, 1.0)),
                ),
              ],
            )
          ),
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
