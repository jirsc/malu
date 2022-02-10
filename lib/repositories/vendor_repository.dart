import 'dart:async';
import 'package:doeat/utils/utils.dart';
import 'package:doeat/models/models.dart';

class VendorRepository {
  const VendorRepository({
    required this.service,
  });

  final VendorService service;

  Future<List<Vendor>> getVendors() async {
    return await service.getVendors();
  }

  /* Future<Game> getGames() async => service.getGames();

  Future<List<Genre>> getGenres() async => service.getGenres();

  Future<List<Result>> getGamesByCategory(int genreId) async =>
      service.getGamesByCategory(genreId); */
}
