import 'package:flut_demo/core/resources/data_state.dart';
import 'package:flut_demo/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
