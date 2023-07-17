import 'package:flutter/material.dart';


class AddArchive extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Archive"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: new InputDecoration(
                  hintText: "masukkan jenis file",
                  labelText: "Nama File",
                  icon: Icon(Icons.file_upload),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(5.0)
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
