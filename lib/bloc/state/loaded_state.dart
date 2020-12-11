/// State holding loaded value. [LoadedState.loadedValue] getter
/// has to return the loaded value, but since this is getter
/// additional operations can be done
abstract class LoadedState<T> {
  T get loadedValue;
}
