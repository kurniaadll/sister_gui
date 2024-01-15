import 'package:flutter/material.dart';
import 'package:mahasiswa_sister/mahasiswa/data_mahasiswa.dart';

class MahasiswaSearchDelegate extends SearchDelegate {
  final List<dynamic> mahasiswa;

  MahasiswaSearchDelegate(this.mahasiswa);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: Color.fromRGBO(57, 81, 68, 1.0),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: Color.fromRGBO(57, 81, 68, 1.0),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> searchResults = mahasiswa
        .where((mhs) =>
        mhs['nama'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            searchResults[index]['nama'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          subtitle: Text(
              searchResults[index]['email'],
              style: const TextStyle(
                fontSize: 12,
                fontFamily: 'Poppins',
            ),
          ),
          trailing: Text(
              searchResults[index]['tgllahir'],
              style: const TextStyle(
                fontSize: 10,
                fontFamily: 'Poppins',
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DataMahasiswa(
                  id: searchResults[index]['id'],
                  nm: searchResults[index]['nama'],
                  ml: searchResults[index]['email'],
                  tgl: searchResults[index]['tgllahir'],)
                )
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<dynamic> suggestionList = mahasiswa
        .where((mhs) =>
        mhs['nama'].toString().toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index]['nama'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              fontFamily: 'Poppins',
            ),
          ),
          subtitle: Text(
            suggestionList[index]['email'],
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
            ),
          ),
          trailing: Text(
            suggestionList[index]['tgllahir'],
            style: const TextStyle(
              fontSize: 10,
              fontFamily: 'Poppins',
            ),
          ),
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => DataMahasiswa(
                  id: suggestionList[index]['id'],
                  nm: suggestionList[index]['nama'],
                  ml: suggestionList[index]['email'],
                  tgl: suggestionList[index]['tgllahir'],
                )
                )
            );
          },
        );
      },
    );
  }
}
