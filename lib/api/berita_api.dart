import 'package:http/http.dart' show Client;
import 'package:instabpkad/model/berita/berita_model.dart';

class BeritaService {
  final String baseUrl = "https://bpkad.ntbprov.go.id/api/berita";
  Client client = Client();

  Future<List<BeritaModel>> getBerita() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return beritaFromJson(response.body);
    } else {
      return throw Exception("data gagal diambil");
    }
  }
}
