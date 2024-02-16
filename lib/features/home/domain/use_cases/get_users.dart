import 'package:dummy_tdd_clean/core/usecase/usecase.dart';
import 'package:dummy_tdd_clean/core/utilities/typedef.dart';
import 'package:dummy_tdd_clean/features/home/domain/entities/user.dart';
import 'package:dummy_tdd_clean/features/home/domain/repositories/auth_repo.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  GetUsers(this._repo);

  final AuthRepo _repo;

  @override
  ResultFuture<List<User>> call() async => _repo.getUsers();
}