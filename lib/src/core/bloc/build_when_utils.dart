import 'package:equatable/equatable.dart';

typedef WhenChangedCallback<T> = bool Function(T previous, T current);
typedef WhenParamsWrapper<T> = List<Object?> Function(T state);
typedef WhenParamWrapper<T> = Object? Function(T state);

class EquatableArray extends Equatable {
  const EquatableArray(this.elements);

  const EquatableArray.empty() : elements = const [];

  final List<Object?> elements;

  @override
  List<Object?> get props => elements;
}

/// Сравнивает несколько параметров между двумя state
WhenChangedCallback<T> whenParamsChanged<T>(WhenParamsWrapper<T> wrapper) {
  return (T previous, T current) =>
      EquatableArray(wrapper(previous)) != EquatableArray(wrapper(current));
}

/// Сравнивает один параметр между двумя state
WhenChangedCallback<T> whenParamChanged<T>(WhenParamWrapper<T> wrapper) {
  return (T previous, T current) => wrapper(previous) != wrapper(current);
}
