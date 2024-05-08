import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/infrastructure/datasources/remote_datasources/user_account_remote_data_source.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:smart_assistant_app/infrastructure/models/auth/auth_tokens.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IUserAccountRepository {
  Future<Either<Failure, List<UserProfile>>> getAccountProfiles();
}

@Singleton(as: IUserAccountRepository)
class UserProfileRepositoryImpl implements IUserAccountRepository {
  final UserAccountRemoteDataSource remoteDataSource;

  const UserProfileRepositoryImpl(this.remoteDataSource);

  /// [Account Profiles]
  @override
  Future<Either<Failure, List<UserProfile>>> getAccountProfiles() {
    return remoteDataSource.getAccountProfiles();
  }
}
