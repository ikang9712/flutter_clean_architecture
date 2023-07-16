import 'package:flut_demo/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:flut_demo/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flut_demo/features/daily_news/domain/usecases/save_article.dart';
import 'package:flut_demo/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flut_demo/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticlesLoading()) {
    on<GetSavedArticles>(onGetSavedArticles);
    on<SaveArticle>(onSaveArticle);
    on<RemoveArticle>(onRemoveArticle);
  }

  void onGetSavedArticles(
      GetSavedArticles event, Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(
      SaveArticle saveArticle, Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(
      RemoveArticle removeArticle, Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  // void onGetArticles(
  //     GetArticles event, Emitter<RemoteArticleState> emit) async {
  //   final dataState = await _getArticleUseCase();
  //   if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
  //     print("data success");
  //     emit(RemoteArticlesDone(dataState.data!));
  //   }

  //   if (dataState is DataFailed) {
  //     print("data failed");
  //     emit(RemoteArticlesError(dataState.error!));
  //   }
  // }
}
