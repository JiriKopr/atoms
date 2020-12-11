import 'package:atoms/helper/helper.dart';
import 'package:equatable/equatable.dart';

import '../../error/error.dart';
import 'state.dart';

/// Most Blocs can be divided into 3-4 abstract states
/// Loading (same as Initial), Loaded, Error, and optional but useful Processing
/// 
/// Every main abstract state will extends BaseState, and other states
/// will implement one of the four states. This will give us more
/// functionality, because now there is no need to check for specific states
/// just what state of the found they implement this us used in [StateBuilder]
abstract class BaseState<T> extends Equatable {
  Failure get failure {
    return cast<ErrorState>(this)?.passedFailure;
  }

  String get failureMessage {
    return this.failure?.message;
  }

  T get value {
    return cast<LoadedState>(this)?.loadedValue;
  }

  bool get isError {
    return this is ErrorState;
  }

  bool get isLoaded {
    return this is LoadedState;
  }

  bool get isLoading {
    return this is LoadingState;
  }

  bool get isProcessing {
    return this is ProcessingState;
  }
}
