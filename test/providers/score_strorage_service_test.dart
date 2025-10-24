import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/services/score_storage_service.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('ScoreStorageService Tests', () {
    test('Sauvegarder et récupérer un score fonctionne', () async {
      // ARRANGE
      const testScore = 5;
      const moment = 'matin';

      // ACT
      final saveSuccess = await ScoreStorageService.saveScore(
        moment,
        testScore,
      );
      final retrievedScore = await ScoreStorageService.getScore(moment);

      // ASSERT
      expect(saveSuccess, isTrue);
      expect(retrievedScore, equals(testScore));
    });

    test('Récupérer un score non existant retourne 0', () async {
      // ARRANGE
      const moment = 'inexistant';

      // ACT
      final score = await ScoreStorageService.getScore(moment);

      // ASSERT
      expect(score, equals(0));
    });

    test('Tous les moments de la journée peuvent être sauvegardés', () async {
      // ARRANGE
      final moments = {'matin': 2, 'midi': 3, 'soir': 1, 'coucher': 4};

      // ACT & ASSERT
      for (var entry in moments.entries) {
        final success = await ScoreStorageService.saveScore(
          entry.key,
          entry.value,
        );
        expect(success, isTrue);

        final retrieved = await ScoreStorageService.getScore(entry.key);
        expect(retrieved, equals(entry.value));
      }
    });
  });
}
