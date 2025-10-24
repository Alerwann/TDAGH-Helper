import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/providers/score_provider.dart';

void main() {
  // Cette fonction s'exécute avant chaque test
  setUp(() async {
    // On initialise SharedPreferences avec des valeurs vides
    SharedPreferences.setMockInitialValues({});
  });

  // Groupe de tests pour ScoreProvider
  group('ScoreProvider Tests', () {
    // Test 1 : Vérifier que les valeurs initiales sont correctes
    test('Les scores initiaux sont à zéro', () async {
      // ARRANGE (Préparer)
      final provider = ScoreProvider();

      // ACT (Agir)
      // On attend que le provider charge ses données
      await Future.delayed(Duration(milliseconds: 100));

      // ASSERT (Vérifier)
      expect(provider.morningScore, equals(0));
      expect(provider.midiScore, equals(0));
      expect(provider.afternoonScore, equals(0));
      expect(provider.eveningScore, equals(0));
    });

    // Test 2 : Vérifier qu'on peut incrémenter un score
    test('Incrémenter le score du matin fonctionne', () async {
      // ARRANGE
      final provider = ScoreProvider();
      await Future.delayed(Duration(milliseconds: 100));

      // ACT
      final success = await provider.incrementglobal('matin');

      // ASSERT
      expect(success, isTrue);
      expect(provider.morningScore, equals(1));
    });

    // Test 3 : Vérifier qu'on peut décrémenter un score
    test('Décrémenter le score fonctionne et ne va pas en négatif', () async {
      // ARRANGE
      final provider = ScoreProvider();
      await Future.delayed(Duration(milliseconds: 100));

      // ACT - On décrémente alors que le score est à 0
      final success = await provider.decrementglobal('matin');

      // ASSERT
      expect(success, isTrue);
      expect(provider.morningScore, equals(0)); // Ne devrait pas être négatif
    });

    // Test 4 : Vérifier le calcul du score global
    test('Le score global du bingo se calcule correctement', () async {
      // ARRANGE
      final provider = ScoreProvider();
      await Future.delayed(Duration(milliseconds: 100));

      // ACT - On met des scores pour chaque moment
      await provider.incrementglobal('matin');
      await provider.incrementglobal('matin');
      await provider.incrementglobal('midi');
      await provider.incrementglobal('soir');
      await provider.incrementglobal('coucher');

      // ASSERT
      // 2 (matin) + 1 (midi) + 1 (soir) + 1 (coucher) = 5
      expect(provider.globalBingoScore, equals(5));
    });
  });
}
