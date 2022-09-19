import 'package:malu/models/models.dart';

class VendorService {
  Future<List<Vendor>> getVendors() async {
    return [
      const Vendor(
          imageUrl: 'assets/images/food1.jpg',
          name: 'McDonald\'s',
          distance: '3.5 km',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '1'),
      const Vendor(
          imageUrl: 'assets/images/food4.jpg',
          name: 'Coco Fresh',
          distance: '3.5 km',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '2'),
      const Vendor(
          imageUrl: 'assets/images/food3.jpg',
          name: 'Mary Grace',
          distance: '3.5 km',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '3'),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Chatime',
          distance: '3.5 km',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '4'),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Conti\'s',
          distance: '3.5 km',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '5'),
      const Vendor(
          imageUrl: 'assets/images/food2.jpg',
          name: 'Cabalen',
          distance: '3.5 km',
          score: 4.9,
          ratingCount: 107.3,
          weeklyOrderCount: 2.7,
          category: ['Asian', 'Snacks', 'Pastry'],
          description: 'The best food to eat ...',
          id: '6'),
    ];
  }
  /* VendorService({
    http.Client? httpClient,
    this.baseUrl = 'https://api.rawg.io/api',
  }) : _httpClient = httpClient ?? http.Client();

  final String baseUrl;
  final Client _httpClient; */

  /* Uri getUrl({
    required String url,
    Map<String, String>? extraParameters,
  }) {
    final queryParameters = <String, String>{
      'key': dotenv.get('GAMES_API_KEY')
    };
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/$url').replace(
      queryParameters: queryParameters,
    );
  } */

  /* Future<Game> getGames() async {
    final response = await _httpClient.get(
      getUrl(url: 'games'),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return Game.fromJson(
          json.decode(response.body),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingGames('Error getting games');
    }
  } */

  /* Future<List<Genre>> getGenres() async {
    final response = await _httpClient.get(
      getUrl(url: 'genres'),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<Genre>.from(
          json.decode(response.body)['results'].map(
                (data) => Genre.fromJson(data),
              ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingGames('Error getting genres');
    }
  } */

  /* Future<List<Result>> getGamesByCategory(int genreId) async {
    final response = await _httpClient.get(
      getUrl(
        url: 'games',
        extraParameters: {
          'genres': genreId.toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<Result>.from(
          json.decode(response.body)['results'].map(
                (data) => Result.fromJson(data),
              ),
        );
      } else {
        throw ErrorEmptyResponse();
      }
    } else {
      throw ErrorGettingGames('Error getting games');
    }
  } */
}
