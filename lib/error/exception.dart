import 'package:flutter/material.dart';

/// Abstraction for more detailed error handling
abstract class BaseException implements Exception {
  final String message;

  const BaseException({
    @required this.message,
  });
}
