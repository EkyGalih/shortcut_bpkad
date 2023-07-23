import 'package:http/http.dart' show Client;
import 'package:instabpkad/model/pegawai/pegawai_model.dart';

class PegawaiService {
  final String baseUrl = "https://bpkad.ntbprov.go.id/api/pegawai";
  Client client = Client();

  Future<List<PegawaiModel>> getPegawai() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return pegawaiFromJson(response.body);
    } else {
      return throw Exception("data pegawai gagal diambil");
    }
  }
}
