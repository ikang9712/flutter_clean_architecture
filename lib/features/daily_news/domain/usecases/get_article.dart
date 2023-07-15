import 'package:flut_demo/core/resources/data_state.dart';
import 'package:flut_demo/core/usecase/usecase.dart';
import 'package:flut_demo/features/daily_news/domain/entities/article.dart';
import 'package:flut_demo/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUseCase
    implements UsecCase<DataState<List<ArticleEntity>>, void> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewsArticles();
  }
}
