import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:smart_assistant_app/infrastructure/datasources/remote_datasources/user_profile_remote_data_source.dart';
import 'package:smart_assistant_app/infrastructure/models/account/user_profile.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class IUserProfileRepository {
  Future<Either<Failure, UserProfile>> getCurrentProfile();
}

@Singleton(as: IUserProfileRepository)
class UserProfileRepositoryImpl implements IUserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  const UserProfileRepositoryImpl(this.remoteDataSource);

  /// [Current Profile]
  @override
  Future<Either<Failure, UserProfile>> getCurrentProfile() {
    return remoteDataSource.getCurrentProfile();
  }
}
