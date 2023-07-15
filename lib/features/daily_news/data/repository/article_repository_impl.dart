import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flut_demo/core/constants/constants.dart';
import 'package:flut_demo/core/resources/data_state.dart';
import 'package:flut_demo/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flut_demo/features/daily_news/data/models/article.dart';
import 'package:flut_demo/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  // IMPORTANT: Here, we return List of ArticleModel, not List of Article Entities,
  // because we are in data layer. Article Entity is in domain layer.
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
