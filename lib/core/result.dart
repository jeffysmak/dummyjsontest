import 'package:dummyjsonexample/core/errors/app_failures.dart';

sealed class Result<T> {
  const Result();

  R when<R>({required R Function(AppFailure failure) failure, required R Function(T data) success}) {
    return switch (this) {
      Success(:final value) => success(value),
      Failure(:final error) => failure(error),
    };
  }

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
    Success(:final value) => value,
    Failure() => null,
  };

  AppFailure? get failureOrNull => switch (this) {
    Success() => null,
    Failure(:final error) => error,
  };
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.error);

  final AppFailure error;
}
