import '../../error/failure.dart';

/// State holding passed failure. By implementing this state,
/// we have to implement getter for the failure, which will be
/// most likely just return statement for the single failure,
/// but there can be done more then just simple return
abstract class ErrorState {
  Failure get passedFailure;
}
