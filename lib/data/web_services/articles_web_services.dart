import 'package:dio/dio.dart';
import '../../constants/strings.dart';

class ArticlesWebService {
  late Dio dio;
  ArticlesWebService() {
    BaseOptions options = BaseOptions(
      validateStatus: (_) => true,
      baseUrl: baseUrl,
      connectTimeout: 20 * 60 * 1000,
      receiveTimeout: 20 * 60 * 1000,
    );

    dio = Dio(options);
  }
  Future<List<dynamic>> getAllArticles() async {
    try {
      Response response = await dio.get(baseUrl, queryParameters: {
        'language': 'ar',
        'category': 'sports',
        'apiKey': '1718c6729c0b4ed5ae9d9a1113ffbc0a',
      });
      print(response.data['articles'].toString());
      return response.data['articles'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
