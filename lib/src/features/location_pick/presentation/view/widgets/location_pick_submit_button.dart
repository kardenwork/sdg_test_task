part of '../location_pick_screen.dart';

class LocationPickSubmitButton extends StatelessWidget {
  const LocationPickSubmitButton({super.key});

  static const _text = 'Submit';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationPickBloc, LocationPickState>(
      buildWhen: whenParamsChanged(
        (state) => [state.canSubmit, state.isSubmitting],
      ),
      builder: (context, state) {
        final bloc = context.read<LocationPickBloc>();

        return ElevatedButton(
          onPressed: state.canSubmit
              ? () => bloc.add(LocationPickSubmitRequestedEvent())
              : null,
          child: state.isSubmitting ? const AppLoader() : const Text(_text),
        );
      },
    );
  }
}
