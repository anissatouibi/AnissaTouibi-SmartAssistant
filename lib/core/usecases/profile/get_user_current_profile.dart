import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/core/usecases/usecase.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:smart_assistant_app/infrastructure/repositories/user_profile_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@singleton
class GetUserCurrentProfile implements Usecase<UserProfile, NoParams> {
  final IUserProfileRepository repository;

  GetUserCurrentProfile(this.repository);

  @override
  Future<Either<Failure, UserProfile>> call(NoParams params) async {
    return await repository.getCurrentProfile();
  }
}
