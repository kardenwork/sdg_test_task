enum CountryStateFieldError {
  fieldIsRequired;

  String get asText => switch (this) {
        fieldIsRequired => 'Field is required',
      };
}
