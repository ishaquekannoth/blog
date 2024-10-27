import 'package:blog/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<T, R> {
  Future<Either<Failure, T>> call(R param);
}
