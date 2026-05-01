import 'package:flutter/material.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.aPropos)),
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

            Text(
              AppLocalizations.of(context)!.descriptionApp,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 32),

            _InfoRow(
              label: AppLocalizations.of(context)!.developBy,
              value: 'Alerwann',
            ),
            _InfoRow(
              label: 'Contact',
              value: 'alerwann411@gmail.com',
              isEmail: true,
            ),
            _InfoRow(
              label: AppLocalizations.of(context)!.politiqueConf,
              value: AppLocalizations.of(context)!.redirectSite,
              isLink: true,
              onTap: () {
                _launchUrl(
                  'https://alerwanndev.vercel.app/legalinformation',
                  context,
                );
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
                  ? () => _launchUrl('mailto:Alerwann411@gmail.com', context)
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

Future<void> _launchUrl(String url, BuildContext context) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    // En cas d'erreur, tu peux afficher une SnackBar si tu veux
    throw AppLocalizations.of(context)!.errorRedirect(url);
  }
}
