import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdg_test_task/src/core/bloc/build_when_utils.dart';
import 'package:sdg_test_task/src/core/widgets/field_refresh_button.dart';
import 'package:sdg_test_task/src/core/widgets/ui_commands_listener.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country.dart';
import 'package:sdg_test_task/src/features/location_pick/domain/models/country_state.dart';
import 'package:sdg_test_task/src/core/widgets/app_loader.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_pick/country_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/country_state_pick/country_state_pick_bloc.dart';
import 'package:sdg_test_task/src/features/location_pick/presentation/bloc/location_pick/location_pick_bloc.dart';

part 'widgets/countries_field.dart';
part 'widgets/country_states_field.dart';
part 'widgets/location_pick_submit_button.dart';

class LocationPickScreen extends StatelessWidget {
  const LocationPickScreen({
    required this.formBlocFactory,
    required this.countryPickBlocFactory,
    required this.countryStatePickBlocFactory,
    super.key,
  });

  final LocationPickBloc Function() formBlocFactory;
  final CountryPickBloc Function() countryPickBlocFactory;
  final CountryStatePickBloc Function() countryStatePickBlocFactory;

  static const _scrollPadding =
      EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 20);
  static const double _gapBetweenFields = 16;
  static const _appBarTitle = 'Choose location';
  static const _submitButtonPadding =
      EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 8);

  void _uiCommandsListener(
    BuildContext context,
    LocationPickUiCommand command,
  ) {
    final snackBar = switch (command) {
      LocationPickSuccessUiCommand() => SnackBar(
          content: Text(
            'You\'ve successfully picked a location!\n'
            'Country: ${command.country.name}\n'
            'Country state: ${command.countryState.name}',
          ),
        ),
      LocationPickErrorUiCommand() => const SnackBar(
          content: Text('Something went wrong. Please try again'),
        ),
    };

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationPickBloc>(
      create: (_) => formBlocFactory(),
      child: Builder(builder: (context) {
        final bloc = context.read<LocationPickBloc>();

        return UiCommandsListener<LocationPickUiCommand>(
          emitter: bloc,
          listener: _uiCommandsListener,
          child: Scaffold(
            appBar: AppBar(title: const Text(_appBarTitle)),
            bottomNavigationBar: const Padding(
              padding: _submitButtonPadding,
              child: LocationPickSubmitButton(),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: _scrollPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BlocBuilder<LocationPickBloc, LocationPickState>(
                      buildWhen: whenParamsChanged(
                        (state) => [
                          state.countryFieldError,
                          state.isSubmitting,
                        ],
                      ),
                      builder: (context, state) {
                        final bloc = context.read<LocationPickBloc>();

                        return CountriesField(
                          blocFactory: countryPickBlocFactory,
                          isEnabled: state.countryFieldError == null &&
                              !state.isSubmitting,
                          errorText: state.countryFieldError?.asText,
                          onChanged: (country) => bloc.add(
                            LocationPickCountryPickedEvent(country),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: _gapBetweenFields),
                      child: BlocBuilder<LocationPickBloc, LocationPickState>(
                        buildWhen: whenParamsChanged(
                          (state) => [
                            state.countryStateFieldError,
                            state.isSubmitting,
                            state.pickedCountry,
                          ],
                        ),
                        builder: (context, state) {
                          final bloc = context.read<LocationPickBloc>();

                          return CountryStatesField(
                            blocFactory: countryStatePickBlocFactory,
                            country: state.pickedCountry,
                            isEnabled: state.countryStateFieldError == null &&
                                !state.isSubmitting,
                            errorText: state.countryStateFieldError?.asText,
                            onChanged: (countryState) => bloc.add(
                              LocationPickCountryStatePickedEvent(countryState),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
