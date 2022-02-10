import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:doeat/models/models.dart';

class VendorsApiClient {
  static const baseUrl = 'http://api.github.com';
  final http.Client httpClient;

  VendorsApiClient({required this.httpClient});

  Future<List<Vendor>> fetchVendors() async {
    final List<Vendor> allVendors = [];
    //http.Response response = await httpClient.get('$baseUrl/vendors');
    //List<dynamic> responseData = jsonDecode(response.body);
    /* responseData.forEach((singleVendor) {
      allVendors
          .add(Vendor(login: singleVendor['login'], id: singleVendor['id']));
    }); */
    return allVendors;
  }
}
