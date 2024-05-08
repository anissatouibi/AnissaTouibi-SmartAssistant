import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:smart_assistant_app/infrastructure/repositories/user_account_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetAccountProfiles implements Usecase<List<UserProfile>, NoParams> {
  final IUserAccountRepository repository;

  GetAccountProfiles(this.repository);

  @override
  Future<Either<Failure, List<UserProfile>>> call(NoParams params) async {
    return await repository.getAccountProfiles();
  }
}
