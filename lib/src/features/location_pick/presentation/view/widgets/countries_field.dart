part of '../location_pick_screen.dart';

class CountriesField extends StatefulWidget {
  const CountriesField({
    required this.blocFactory,
    required this.onChanged,
    this.isEnabled = true,
    this.errorText,
    super.key,
  });

  final CountryPickBloc Function() blocFactory;
  final bool isEnabled;
  final String? errorText;
  final ValueChanged<Country?> onChanged;

  @override
  State<CountriesField> createState() => _CountriesFieldState();
}

class _CountriesFieldState extends State<CountriesField> {
  static const double _menuHeight = 300;
  static const String _label = 'Country';

  final controller = TextEditingController();
  late final CountryPickBloc _bloc;

  @override
  void initState() {
    _bloc = widget.blocFactory()..add(CountryPickLoadRequestedEvent());
    super.initState();
  }

  void _blocListener(BuildContext context, CountryPickState state) {
    switch (state) {
      case CountryPickLoadingState():
        controller.clear();
        widget.onChanged(null);
        break;
      case CountryPickLoadedState(:final pickedCountry):
        widget.onChanged(pickedCountry);
        break;
      default:
        break;
    }
  }

  _CountriesFieldViewModel _getViewModel(
    BuildContext context,
    CountryPickState state,
  ) {
    return switch (state) {
      CountryPickLoadingState() => const _CountriesFieldViewModel(
          isEnabled: false,
          errorText: null,
          countries: [],
          trailingIcon: AppLoader(),
        ),
      CountryPickLoadedState(:final countries) => _CountriesFieldViewModel(
          isEnabled: widget.isEnabled,
          errorText: widget.errorText,
          countries: countries,
          trailingIcon: null,
        ),
      CountryPickErrorState() => _CountriesFieldViewModel(
          isEnabled: true,
          errorText: 'Could not load countries. Please try refreshing',
          countries: [],
          trailingIcon: FieldRefreshButton(
            onPressed: () => _bloc.add(CountryPickLoadRequestedEvent()),
          ),
        ),
    };
  }

  @override
  void dispose() {
    controller.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocConsumer<CountryPickBloc, CountryPickState>(
          bloc: _bloc,
          listener: _blocListener,
          builder: (context, state) {
            final viewModel = _getViewModel(context, state);

            return DropdownMenu<Country>(
              controller: controller,
              label: const Text(_label),
              width: constraints.maxWidth,
              menuHeight: _menuHeight,
              enabled: viewModel.isEnabled,
              errorText: viewModel.errorText,
              trailingIcon: viewModel.trailingIcon,
              onSelected: (newValue) {
                _bloc.add(CountryPickCountryPickedEvent(newValue));
              },
              dropdownMenuEntries: viewModel.countries
                  .map(
                    (country) => DropdownMenuEntry(
                      value: country,
                      label: country.name,
                    ),
                  )
                  .toList(),
            );
          },
        );
      },
    );
  }
}

final class _CountriesFieldViewModel {
  const _CountriesFieldViewModel({
    required this.isEnabled,
    required this.errorText,
    required this.countries,
    required this.trailingIcon,
  });

  final bool isEnabled;
  final String? errorText;
  final List<Country> countries;
  final Widget? trailingIcon;
}
