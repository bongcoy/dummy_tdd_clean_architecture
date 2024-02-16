import 'package:dartz/dartz.dart';
import 'package:dummy_tdd_clean/core/errors/failure.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;