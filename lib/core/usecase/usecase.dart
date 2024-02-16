import 'package:dummy_tdd_clean/core/utilities/typedef.dart';

abstract class UseCaseWithParams<Type, Params> {
  ResultFuture<Type> call(Params params);
}

abstract class UseCaseWithoutParams<Type> {
  ResultFuture<Type> call();
}