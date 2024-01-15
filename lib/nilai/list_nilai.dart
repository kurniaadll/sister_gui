import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:mahasiswa_sister/nilai/insert_nilai.dart';

class ListNilai extends StatefulWidget {
  const ListNilai({super.key});

  @override
  State<ListNilai> createState() => _ListNilai();
}

class _ListNilai extends State<ListNilai> {
  List nilai = [];
  List<Map<String, dynamic>> namaMahasiswa = [];
  List<Map<String, dynamic>> namaMatakuliah = [];

  @override
  void initState() {
    getNilai();
    getMahasiswa();
    getMatakuliah();
    super.initState();
  }

  Future<void> getMahasiswa() async {
    String urlMahasiswa = 'http://10.127.253.3:9001/api/v1/mahasiswa';
    try {
      var response = await http.get(Uri.parse(urlMahasiswa));
      final List<dynamic> dataMhs = jsonDecode(response.body);

      setState(() {
        namaMahasiswa = List.from(dataMhs);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> getMatakuliah() async {
    String urlMatakuliah = 'http://192.168.100.137:9002/api/v1/matakuliah';
    try {
      var response = await http.get(Uri.parse(urlMatakuliah));
      final List<dynamic> dataMatkul = jsonDecode(response.body);

      setState(() {
        namaMatakuliah = List.from(dataMatkul);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> getNilai() async {
    String urlNilai = 'http://10.127.253.3:9003/api/v1/nilai';
    try {
      var response = await http.get(Uri.parse(urlNilai));
      nilai = jsonDecode(response.body);
      setState(() {
        nilai = jsonDecode(response.body);
      });
    } catch (exc) {
      print(exc);
    }
  }

  Future<void> deleteNilai(int id) async {
    String urlNilai = "http://10.127.253.3:9003/api/v1/nilai/${id}";
    try {
      await http.delete(Uri.parse(urlNilai));
      setState(() {
        getNilai();
      });
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
          'List Nilai',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
          child: ListView.builder(
            itemCount: nilai.length,
            itemBuilder: (context, index) {
              return _listNilai(index);
            },
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator
              .of(context)
              .push(MaterialPageRoute(builder: (context) => const InsertNilai()));
        },
        backgroundColor: const Color.fromRGBO(78, 108, 80, 1.0),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }


  String getKategoriNilai(int nilai) {
    if (nilai >= 91 && nilai <= 100) {
      return 'A';
    } else if (nilai >= 84 && nilai < 90) {
      return 'A-';
    } else if (nilai >= 77 && nilai < 83) {
      return 'B+';
    } else if (nilai >= 71 && nilai < 76) {
      return 'B';
    } else if (nilai >= 66 && nilai < 70) {
      return 'B-';
    } else if (nilai >= 61 && nilai < 65) {
      return 'C+';
    } else if (nilai >= 55 && nilai < 60) {
      return 'C';
    } else if (nilai >= 41 && nilai < 54) {
      return 'D';
    } else {
      return 'E';
    }
  }

  Widget _listNilai(int index) {
    int nilaii = nilai[index]["nilai"];
    String kategori = getKategoriNilai(nilaii);
    return Column(
      children: [
          ListTile(
            title: Text(
              "${namaMahasiswa.firstWhere((mahasiswa) => mahasiswa["id"] == nilai[index]["idmahasiswa"], orElse: () => {})["nama"] ?? ""}",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'),
            ),
            subtitle: Text(
              "Matakuliah: ${namaMatakuliah.firstWhere((matakuliah) => matakuliah["id"] == nilai[index]["idmatakuliah"], orElse: () => {})["nama"] ?? ""}\nNilai: ${nilai[index]["nilai"]} | $kategori",
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins'),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () async{
                    await deleteNilai(nilai[index]["id"]);
                    getNilai();
                  },
                  icon: Icon(Icons.delete,size: 17, color: Color.fromRGBO(78, 108, 80, 1.0)),
                ),
              ],
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