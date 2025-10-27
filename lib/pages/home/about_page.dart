import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('À propos')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo ou icône optionnel (tu peux ajouter ton logo ici si tu veux)
            // Ex: Center(child: Image.asset('assets/logo.png', width: 80)),
            const SizedBox(height: 16),

            const Text(
              'TDaH’elpe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Une application conçue pour accompagner les personnes atteintes de TDAH dans leurs routines quotidiennes.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            _InfoRow(label: 'Développé par', value: 'Alerwann'),
            _InfoRow(
              label: 'Contact',
              value: 'Alerwann411@gmail.com',
              isEmail: true,
            ),
            _InfoRow(
              label: 'Politique de confidentialité',
              value: 'Voir sur GitHub',
              isLink: true,
              onTap: () {
                // 🔗 Remplace ce lien par ton vrai lien GitHub quand prêt
                _launchUrl('https://github.com/tonpseudo/tdahelpe-privacy');
              },
            ),

            const Spacer(),

            Center(
              child: Text(
                'Version ${_getAppVersion()}',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _getAppVersion() {
    // Tu peux remplacer par une constante ou lire depuis pubspec.yaml si tu veux
    return '1.0.0';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isEmail;
  final bool isLink;
  final VoidCallback? onTap;

  const _InfoRow({
    required this.label,
    required this.value,
    this.isEmail = false,
    this.isLink = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap:
              onTap ??
              (isEmail
                  ? () => _launchUrl('mailto:Alerwann411@gmail.com')
                  : null),
          child: Text(
            value,
            style: TextStyle(
              color: isEmail || isLink
                  ? Theme.of(context).colorScheme.primary
                  : null,
              decoration: (isEmail || isLink) ? TextDecoration.underline : null,
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

Future<void> _launchUrl(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    // En cas d'erreur, tu peux afficher une SnackBar si tu veux
    throw 'Impossible d’ouvrir $url';
  }
}
