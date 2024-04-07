enum CountryFieldError {
  fieldIsRequired,
  countryHasNoStates;

  String get asText => switch (this) {
        fieldIsRequired => 'Field is required',
        countryHasNoStates =>
          'Picked country has not states :(\nPlease choose another country',
      };
}
