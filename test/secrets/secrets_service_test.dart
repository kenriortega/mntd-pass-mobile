import 'package:mntd_mobile/models/secret_model.dart';
import 'package:mntd_mobile/services/secrets_service.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

main() {
  group("GetSecrets by username ", () {
    test(
      "returns a list of secrets if the http call mock is completes successfully",
      () async {
        final client = MockClient();
        final SecretsService secretsService = SecretsService();

        // Usa Mockito para devolver una respuesta exitosa cuando llama al
        // http.Client proporcionado.
        when(client.get('http://192.168.43.119:8080/secrets/kalix'))
            .thenAnswer((_) async => http.Response("""
          {
            "count": 1,
            "data": [
              {
                "username": "kalix",
                "name": "my-secret-38",
                "category": "payments",
                "createdAt": "2020-05-30T18:58:39.840Z"
              },
            ]
          }
          """, 200));

        expect(await secretsService.getSecrets('kalix'), isA<List<Secret>>());
      },
    );
    test(
      "returns a list of secrets if the http call online is completes successfully",
      () async {
        final SecretsService secretsService = SecretsService();
        expect(await secretsService.getSecrets('kalix'), isA<List<Secret>>());
      },
    );
  });
}
