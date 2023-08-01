// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

class PegawaiModel {
  final name;
  final nip;
  final jabatan;
  final foto;

  PegawaiModel({
    required this.name,
    required this.nip,
    required this.jabatan,
    required this.foto,
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> map) {
    return PegawaiModel(
      name: map['name'],
      nip: map['nip'],
      jabatan: map['jabatan'],
      foto: map['foto'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "nip": nip,
      "jabatan": jabatan,
      "foto": foto,
    };
  }

  @override
  String toString() {
    return 'PegawaiModel{name: $name, nip: $nip,jabatan: $jabatan, foto: $foto}';
  }
}

List<PegawaiModel> pegawaiFromJson(String jsonData) {
  final data = json.decode(jsonData)['data']['data'];
  return List<PegawaiModel>.from(
      data.map((pegawai) => PegawaiModel.fromJson(pegawai)).toList());
}

String pegawaiToJson(PegawaiModel data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}
