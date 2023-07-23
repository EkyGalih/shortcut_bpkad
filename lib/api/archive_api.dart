import 'package:http/http.dart' show Client;
import 'package:instabpkad/model/archive/archive_model.dart';

class ArchiveService {
  final String baseUrl = "https://bpkad.ntbprov.go.id/api/kip";
  Client client = Client();

  Future<List<ArchiveModel>> getArchive() async {
    final response = await client.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return archiveFromjson(response.body);
    } else {
      return throw Exception("data file gagal diambil!");
    }
  }
}
