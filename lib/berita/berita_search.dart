import 'package:flutter/material.dart';

import '../api/berita_api.dart';
import '../model/berita/berita_model.dart';

class SearchBerita extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromARGB(255, 204, 202, 202),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide.none,
          ),
          hintText: "Cari Berita",
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: Colors.blue.shade900,
        ),
        onChanged: (text) {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 204, 202, 202),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        hintText: "Cari Berita",
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.blue.shade900,
      ),
      onChanged: (text) {
        Navigator.pop(context);
      },
    );
  }

  final BeritaService _beritaList = BeritaService();
  @override
  Widget buildResults(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<BeritaModel>>(
        future: _beritaList.getBerita(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) => ListTile(
                  title: Text(
                    data?[index].title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    // removeAllHtmlTags(snapshot.data[index]['content']),
                    "By ${data?[index].author}",
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    // Navigator.push(context,
                    // MaterialPageRoute(builder: (c) => DetailBerita()));
                  },
                  // trailing: Text(
                  //   getCustomFormattedDateTime(
                  //       snapshot.data[index]['created_at'], "MM/dd/yyyy"),
                  //   style: TextStyle(color: Colors.amber),
                  // ),
                  // leading: Image.network("https://bpkad.ntbprov.go.id/" +
                  //     snapshot.data[index].image),
                  leading: Image.network(
                      "https://bpkad.ntbprov.go.id/${data?[index].image}")),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 204, 202, 202),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        hintText: "Cari Berita",
        prefixIcon: const Icon(Icons.search),
        prefixIconColor: Colors.blue.shade900,
      ),
    );
  }
}
