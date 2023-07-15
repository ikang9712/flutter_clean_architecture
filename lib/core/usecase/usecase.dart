abstract class UsecCase<Type, Params> {
  Future<Type> call({Params params});
}
