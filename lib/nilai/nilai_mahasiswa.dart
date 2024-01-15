import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';

class NilaiList extends StatefulWidget {
  int idAll;
  NilaiList(this.idAll);

  @override
  State<NilaiList> createState() => _NilaiList();
}

class _NilaiList extends State<NilaiList> {
  List nilaimhs = [];
  int id = 0;

  @override
  void initState() {
    id = widget.idAll;
    nilaiMahasiswa();
    super.initState();
  }

  Future<void> nilaiMahasiswa() async {
    String urlnilai = "http://10.127.253.3:9003/api/v1/nilai/$id";
    try {
      var response = await http.get(Uri.parse(urlnilai));
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        nilaimhs = List.from(data);
      });
    } catch (exc) {
      print(exc);
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(57, 81, 68, 1.0),
        foregroundColor: Color.fromRGBO(240, 235, 206, 1.0),
        title: Text(
          "Nilai Mahasiswa",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: nilaimhs.isEmpty
            ? Center(
              child: Text(
                'Tidak ada data',
                style: TextStyle(fontSize: 20),
              ),
            )
          : ListView.builder(
            itemCount: nilaimhs.length,
            itemBuilder: (context, index) {
              return _listnilai(index);
            },
          ),
      ),
    );
  }

  Widget _listnilai(int index) {
    int nilai = nilaimhs[index]["nilai"]["nilai"];
    String kategori = getKategoriNilai(nilai);
    return Column(
      children: [
          ListTile(
            title: Text(
              nilaimhs[index]["mahasiswa"]["nama"],
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins'
              ),
            ),
            subtitle: Text(
              "Matakuliah : ${nilaimhs[index]["matakuliah"]["nama"]}",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins'),
            ),
            trailing: Text(
                "Nilai : ${nilaimhs[index]["nilai"]["nilai"]} | $kategori",
                  style: const TextStyle(
                    fontSize: 10,
                    fontFamily: 'Poppins',
                  ),
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
