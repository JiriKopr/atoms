import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'error.dart';

typedef FailureFactory = Failure Function();

/// Class representing error during some action,
/// this replaces need to use exceptions in layers closer to UI
/// so we don't need try catch blocs in build methods
abstract class Failure extends Equatable {
  /// This filed is required for every implementation of failure
  final String message;

  /// [List] of all implemented [Failure]s, this will help us
  /// generate error codes which can be handy for error tracing
  final List<Type> _failures = const [];

  const Failure(this.message) : assert(message != null);

  /// Code is dependent on the position of the ocurred [Failure] in
  /// the list of all failures
  int get code {
    return _failures
        .indexWhere((failureType) => this.runtimeType == failureType);
  }

  /// Practically every failure has it's own [Exception] counterpart
  /// this factory abstracts the transition from [Exception] to [Failure]
  factory Failure.fromException(Exception exception) {
    final String message = exception is BaseException
        ? exception.message
        : 'Unexpected Error (${exception.runtimeType})';

    // Map holding factories transforming Exception into Failures
    // and passing their messages
    final Map<Type, FailureFactory> mappedErrors = {
      // Example:
      // UnexpectedException: () => UnexpectedFailure(message: message),
    };

    final FailureFactory failureFactory = mappedErrors[exception.runtimeType] ??
        () => UnexpectedFailure(message: message);

    return failureFactory();
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({@required String message}) : super(message);
}
