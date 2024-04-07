import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

Future<void> testExecutable(Future<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(skipGoldenAssertion: () => false),
  );
}
