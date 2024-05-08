import 'package:smart_assistant_app/core/erros/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Usecase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UnawaitedUsecase<Type, Params> {
  Either<Failure, Type> call(Params params);
}

abstract class UsecaseStream<Type, Params> {
  Stream<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
