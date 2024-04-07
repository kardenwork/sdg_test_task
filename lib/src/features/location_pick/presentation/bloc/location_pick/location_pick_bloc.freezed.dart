// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_pick_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationPickState {
  Country? get pickedCountry => throw _privateConstructorUsedError;
  CountryState? get pickedCountryState => throw _privateConstructorUsedError;
  CountryFieldError? get countryFieldError =>
      throw _privateConstructorUsedError;
  CountryStateFieldError? get countryStateFieldError =>
      throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LocationPickStateCopyWith<LocationPickState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationPickStateCopyWith<$Res> {
  factory $LocationPickStateCopyWith(
          LocationPickState value, $Res Function(LocationPickState) then) =
      _$LocationPickStateCopyWithImpl<$Res, LocationPickState>;
  @useResult
  $Res call(
      {Country? pickedCountry,
      CountryState? pickedCountryState,
      CountryFieldError? countryFieldError,
      CountryStateFieldError? countryStateFieldError,
      bool isSubmitting});
}

/// @nodoc
class _$LocationPickStateCopyWithImpl<$Res, $Val extends LocationPickState>
    implements $LocationPickStateCopyWith<$Res> {
  _$LocationPickStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pickedCountry = freezed,
    Object? pickedCountryState = freezed,
    Object? countryFieldError = freezed,
    Object? countryStateFieldError = freezed,
    Object? isSubmitting = null,
  }) {
    return _then(_value.copyWith(
      pickedCountry: freezed == pickedCountry
          ? _value.pickedCountry
          : pickedCountry // ignore: cast_nullable_to_non_nullable
              as Country?,
      pickedCountryState: freezed == pickedCountryState
          ? _value.pickedCountryState
          : pickedCountryState // ignore: cast_nullable_to_non_nullable
              as CountryState?,
      countryFieldError: freezed == countryFieldError
          ? _value.countryFieldError
          : countryFieldError // ignore: cast_nullable_to_non_nullable
              as CountryFieldError?,
      countryStateFieldError: freezed == countryStateFieldError
          ? _value.countryStateFieldError
          : countryStateFieldError // ignore: cast_nullable_to_non_nullable
              as CountryStateFieldError?,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationPickStateImplCopyWith<$Res>
    implements $LocationPickStateCopyWith<$Res> {
  factory _$$LocationPickStateImplCopyWith(_$LocationPickStateImpl value,
          $Res Function(_$LocationPickStateImpl) then) =
      __$$LocationPickStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Country? pickedCountry,
      CountryState? pickedCountryState,
      CountryFieldError? countryFieldError,
      CountryStateFieldError? countryStateFieldError,
      bool isSubmitting});
}

/// @nodoc
class __$$LocationPickStateImplCopyWithImpl<$Res>
    extends _$LocationPickStateCopyWithImpl<$Res, _$LocationPickStateImpl>
    implements _$$LocationPickStateImplCopyWith<$Res> {
  __$$LocationPickStateImplCopyWithImpl(_$LocationPickStateImpl _value,
      $Res Function(_$LocationPickStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pickedCountry = freezed,
    Object? pickedCountryState = freezed,
    Object? countryFieldError = freezed,
    Object? countryStateFieldError = freezed,
    Object? isSubmitting = null,
  }) {
    return _then(_$LocationPickStateImpl(
      pickedCountry: freezed == pickedCountry
          ? _value.pickedCountry
          : pickedCountry // ignore: cast_nullable_to_non_nullable
              as Country?,
      pickedCountryState: freezed == pickedCountryState
          ? _value.pickedCountryState
          : pickedCountryState // ignore: cast_nullable_to_non_nullable
              as CountryState?,
      countryFieldError: freezed == countryFieldError
          ? _value.countryFieldError
          : countryFieldError // ignore: cast_nullable_to_non_nullable
              as CountryFieldError?,
      countryStateFieldError: freezed == countryStateFieldError
          ? _value.countryStateFieldError
          : countryStateFieldError // ignore: cast_nullable_to_non_nullable
              as CountryStateFieldError?,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LocationPickStateImpl extends _LocationPickState {
  const _$LocationPickStateImpl(
      {required this.pickedCountry,
      required this.pickedCountryState,
      required this.countryFieldError,
      required this.countryStateFieldError,
      required this.isSubmitting})
      : super._();

  @override
  final Country? pickedCountry;
  @override
  final CountryState? pickedCountryState;
  @override
  final CountryFieldError? countryFieldError;
  @override
  final CountryStateFieldError? countryStateFieldError;
  @override
  final bool isSubmitting;

  @override
  String toString() {
    return 'LocationPickState(pickedCountry: $pickedCountry, pickedCountryState: $pickedCountryState, countryFieldError: $countryFieldError, countryStateFieldError: $countryStateFieldError, isSubmitting: $isSubmitting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationPickStateImpl &&
            (identical(other.pickedCountry, pickedCountry) ||
                other.pickedCountry == pickedCountry) &&
            (identical(other.pickedCountryState, pickedCountryState) ||
                other.pickedCountryState == pickedCountryState) &&
            (identical(other.countryFieldError, countryFieldError) ||
                other.countryFieldError == countryFieldError) &&
            (identical(other.countryStateFieldError, countryStateFieldError) ||
                other.countryStateFieldError == countryStateFieldError) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      pickedCountry,
      pickedCountryState,
      countryFieldError,
      countryStateFieldError,
      isSubmitting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationPickStateImplCopyWith<_$LocationPickStateImpl> get copyWith =>
      __$$LocationPickStateImplCopyWithImpl<_$LocationPickStateImpl>(
          this, _$identity);
}

abstract class _LocationPickState extends LocationPickState {
  const factory _LocationPickState(
      {required final Country? pickedCountry,
      required final CountryState? pickedCountryState,
      required final CountryFieldError? countryFieldError,
      required final CountryStateFieldError? countryStateFieldError,
      required final bool isSubmitting}) = _$LocationPickStateImpl;
  const _LocationPickState._() : super._();

  @override
  Country? get pickedCountry;
  @override
  CountryState? get pickedCountryState;
  @override
  CountryFieldError? get countryFieldError;
  @override
  CountryStateFieldError? get countryStateFieldError;
  @override
  bool get isSubmitting;
  @override
  @JsonKey(ignore: true)
  _$$LocationPickStateImplCopyWith<_$LocationPickStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
