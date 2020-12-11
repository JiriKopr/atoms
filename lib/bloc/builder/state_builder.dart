import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

typedef LoadedBuilder = Widget Function(
    BuildContext context, LoadedState state);

typedef LoadingBuilder = Widget Function(
    BuildContext context, LoadingState state);

typedef ErrorBuilder = Widget Function(BuildContext context, ErrorState state);

typedef ProcessingBuilder = Widget Function(
    BuildContext context, ProcessingState state);

/// Builder using the power of abstracted Bloc states
/// Now there is no need to use long builder method
/// with if statements checking the type of state
class StatesBuilder<C extends Cubit<S>, S extends BaseState>
    extends BlocBuilderBase<C, S> {
  final LoadedBuilder loadedBuilder;
  final LoadingBuilder loadingBuilder;
  final ErrorBuilder errorBuilder;
  final ProcessingBuilder processingBuilder;

  const StatesBuilder({
    Key key,
    C cubit,
    BlocBuilderCondition<S> buildWhen,
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
