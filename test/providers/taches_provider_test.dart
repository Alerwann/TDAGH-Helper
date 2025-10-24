import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/providers/taches_provider.dart';
import 'package:tdahelpe/data/schema/taches_shema.dart';

void main() {
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('TachesProvider Tests', () {
    test('Les tâches par défaut se chargent correctement', () async {
      // ARRANGE & ACT
      final provider = TachesProvider();
      await Future.delayed(Duration(milliseconds: 100));

      // ASSERT
      expect(provider.taches, isNotEmpty);
      expect(provider.nombreT, equals(3));
    });

    test('Ajouter une tâche fonctionne', () async {
      // ARRANGE
      final provider = TachesProvider();
      await Future.delayed(Duration(milliseconds: 100));
      final initialCount = provider.taches.length;

      final nouvelleTache = TachesSchema(
        tacheName: 'Tâche de test',
        tacheDuration: TacheDuration.court,
      );

      // ACT
      final success = await provider.ajouterTache(nouvelleTache);

      // ASSERT
      expect(success, isTrue);
      expect(provider.taches.length, equals(initialCount + 1));
      expect(provider.taches.first.tacheName, equals('Tâche de test'));
    });

    test('Supprimer une tâche existante fonctionne', () async {
      // ARRANGE
      final provider = TachesProvider();
      await Future.delayed(Duration(milliseconds: 100));

      final nouvelleTache = TachesSchema(
        tacheName: 'Tâche à supprimer',
        tacheDuration: TacheDuration.moyen,
      );
      await provider.ajouterTache(nouvelleTache);

      final countAvant = provider.taches.length;

      // ACT
      final success = await provider.supprimerTache('Tâche à supprimer');

      // ASSERT
      expect(success, isTrue);
      expect(provider.taches.length, equals(countAvant - 1));
      expect(
        provider.taches.any((t) => t.tacheName == 'Tâche à supprimer'),
        isFalse,
      );
    });

    test('Supprimer une tâche inexistante retourne false', () async {
      // ARRANGE
      final provider = TachesProvider();
      await Future.delayed(Duration(milliseconds: 100));

      // ACT
      final success = await provider.supprimerTache('Tâche inexistante');

      // ASSERT
      expect(success, isFalse);
    });

    test('Modifier une tâche fonctionne', () async {
      // ARRANGE
      final provider = TachesProvider();
      await Future.delayed(Duration(milliseconds: 100));

      final tacheOriginale = TachesSchema(
        tacheName: 'Tâche originale',
        tacheDuration: TacheDuration.court,
      );
      await provider.ajouterTache(tacheOriginale);

      final tacheModifiee = TachesSchema(
        tacheName: 'Tâche modifiée',
        tacheDuration: TacheDuration.long,
      );

      // ACT
      final success = await provider.modifierTache(
        'Tâche originale',
        tacheModifiee,
      );

      // ASSERT
      expect(success, isTrue);
      expect(
        provider.taches.any((t) => t.tacheName == 'Tâche modifiée'),
        isTrue,
      );
      expect(
        provider.taches.any((t) => t.tacheName == 'Tâche originale'),
        isFalse,
      );
    });
  });
}
