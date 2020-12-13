# Atoms

This package is just a personal collection of useful Widgets, Hooks, Helper functions and other modular code which can be used in other projects. Thus this will not be publicized on [pub.dev](https://pub.dev/)


Because of this, it is not recommended to put this package as dependency
in your project since this is not actively maintained package, more just dumpster for storing code. If you want to use some of it, just copy and paste it.

Of course feel free to modify your copy of the code as you wish.

## Examples

### [Bloc states](https://github.com/JiriKopr/atoms/tree/master/lib/bloc/state)

#### Base state

```
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
```

### [State Builder](https://github.com/JiriKopr/atoms/blob/master/lib/bloc/builder/state_builder.dart)
```
/// Builder using the power of abstracted Bloc states
/// Now there is no need to use long builder method
/// with if statements checking the type of state
class StatesBuilder<C extends Cubit<S, S extends BaseState<V, V
    extends BlocBuilderBase<C, S {
  final LoadedBuilder<V loadedBuilder;
  final LoadingBuilder loadingBuilder;
  final ErrorBuilder errorBuilder;
  final ProcessingBuilder processingBuilder;

  const StatesBuilder({
    Key key,
    C cubit,
    BlocBuilderCondition<S buildWhen,
    @required this.loadedBuilder,
    @required this.loadingBuilder,
    @required this.errorBuilder,
    this.processingBuilder,
  }) : super(key: key, cubit: cubit, buildWhen: buildWhen);

  @override
  Widget build(BuildContext context, S state) {
    Function builder;
    if (state is LoadedState) {
      builder = loadedBuilder;
    } else if (state is LoadingState) {
      builder = loadingBuilder;
    } else if (state is ErrorState) {
      builder = errorBuilder;
    } else if (state is ProcessingState) {
      builder = processingBuilder;
    }

    assert(builder != null,
        'BUILDER ERROR: $state state does not have any builder');

    return builder(context, state);
  }
}
```