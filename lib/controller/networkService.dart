import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:vegitable_api/modal/prodect_modal.dart';

class NetWorkService {
  static Future<List<Prodect>> fetchdata() async {
    log("hello");
    const url = "https://fakestoreapi.com/products";
    log("1");
    final uri = Uri.parse(url);
    final res = await http.get(uri);

    final json = prodectFromJson(res.body);

    return json;
  }
}
