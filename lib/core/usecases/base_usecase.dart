import 'package:equatable/equatable.dart';

/// Base UseCase لجميع حالات الاستخدام
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

/// NoParams للاستخدام عندما لا نحتاج معاملات
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Result wrapper للتعامل مع النجاح والفشل
class Result<T> {
  final T? data;
  final Failure? failure;
  
  Result.success(this.data) : failure = null;
  Result.failure(this.failure) : data = null;
  
  bool get isSuccess => failure == null;
  bool get isFailure => failure != null;
}

/// Base Failure class
abstract class Failure extends Equatable {
  final String message;
  
  const Failure(this.message);
  
  @override
  List<Object?> get props => [message];
}

/// خطأ في التخزين المحلي
class CacheFailure extends Failure {
  const CacheFailure([String message = 'حدث خطأ في التخزين المحلي']) : super(message);
}
