final class ApiConfig {
  const ApiConfig._();

  static final Uri baseUrl = Uri(
    scheme: 'https',
    host: const String.fromEnvironment('API_HOST'),
    pathSegments: ['api', 'v1'],
  );

  static final Map<String, String> headers = {
    'X-API-Key': const String.fromEnvironment('API_KEY'),
    'User-Agent': const String.fromEnvironment('USER_AGENT'),
  };

  static const String countriesPath = '/countries';
  static String countryStatesPath(int countryId) =>
      '/countries/$countryId/states';
}
