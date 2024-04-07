part of '../location_pick_screen.dart';

class CountryStatesField extends StatefulWidget {
  const CountryStatesField({
    required this.blocFactory,
    required this.country,
    required this.onChanged,
    this.isEnabled = true,
    this.errorText,
    super.key,
  });

  final CountryStatePickBloc Function() blocFactory;
  final Country? country;
  final bool isEnabled;
  final String? errorText;
  final ValueChanged<CountryState?> onChanged;

  @override
  State<CountryStatesField> createState() => _CountryStatesFieldState();
}

class _CountryStatesFieldState extends State<CountryStatesField> {
  static const double _menuHeight = 250;

  final controller = TextEditingController();
  late final CountryStatePickBloc _bloc;

  @override
  void initState() {
    _bloc = widget.blocFactory();

    if (widget.country != null) {
      _bloc.add(CountryStatePickCountryChangedEvent(widget.country!));
    }

    super.initState();
  }

  @override
  void didUpdateWidget(covariant CountryStatesField oldWidget) {
    if (oldWidget.country != widget.country) {
      _bloc.add(CountryStatePickCountryChangedEvent(widget.country!));
    }

    super.didUpdateWidget(oldWidget);
  }

  void _blocListener(BuildContext context, CountryStatePickState state) {
    switch (state) {
      case CountryStatePickInitialState() || CountryStatePickLoadingState():
        widget.onChanged(null);
        controller.clear();
        break;
      case CountryStatePickLoadedState(:final pickedCountryState):
        if (pickedCountryState != null) {
          widget.onChanged(pickedCountryState);
        }
        break;
      default:
        break;
    }
  }

  _CountryStatesFieldViewModel _getViewModel(
    BuildContext context,
    CountryStatePickState state,
  ) {
    return switch (state) {
      CountryStatePickInitialState() => const _CountryStatesFieldViewModel(
          isEnabled: false,
          errorText: null,
          countryStates: [],
          trailingIcon: null,
        ),
      CountryStatePickLoadingState() => const _CountryStatesFieldViewModel(
          isEnabled: false,
          errorText: null,
          countryStates: [],
          trailingIcon: AppLoader(),
        ),
      CountryStatePickErrorState() => _CountryStatesFieldViewModel(
          isEnabled: true,
          errorText: 'Could not load country states. Please try refreshing',
          countryStates: [],
          trailingIcon: FieldRefreshButton(
            onPressed: () => _bloc.add(CountryStatePickRefreshRequestedEvent()),
          ),
        ),
      CountryStatePickLoadedState() => _CountryStatesFieldViewModel(
          isEnabled: widget.isEnabled,
          errorText: widget.errorText,
          countryStates: state.countryStates,
          trailingIcon: null,
        ),
    };
  }

  @override
  void dispose() {
    _bloc.close();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return BlocConsumer<CountryStatePickBloc, CountryStatePickState>(
          bloc: _bloc,
          listener: _blocListener,
          builder: (context, state) {
            final viewModel = _getViewModel(context, state);

            return DropdownMenu<CountryState>(
              controller: controller,
              label: const Text('Country state'),
              width: constraints.maxWidth,
              menuHeight: _menuHeight,
              enabled: viewModel.isEnabled,
              errorText: viewModel.errorText,
              trailingIcon: viewModel.trailingIcon,
              onSelected: (newValue) {
                if (newValue == null) return;
                _bloc.add(CountryStatePickCountryStatePickedEvent(newValue));
              },
              dropdownMenuEntries: viewModel.countryStates
                  .map(
                    (countryState) => DropdownMenuEntry(
                      value: countryState,
                      label: countryState.name,
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

final class _CountryStatesFieldViewModel {
  const _CountryStatesFieldViewModel({
    required this.isEnabled,
    required this.errorText,
    required this.countryStates,
    required this.trailingIcon,
  });

  final bool isEnabled;
  final String? errorText;
  final List<CountryState> countryStates;
  final Widget? trailingIcon;
}
