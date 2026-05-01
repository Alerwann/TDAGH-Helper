// Onboarding d'accueil qui explique l'application
// il ne s'affiche qu'une fois à la première ouverture

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdahelpe/l10n/app_localizations.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<OnboardingStep> steps = [
      OnboardingStep(
        title: AppLocalizations.of(context)!.bienvenuOnboarding,
        description: AppLocalizations.of(context)!.explainApp,
        icon: Icons.home,
      ),
      OnboardingStep(
        title: AppLocalizations.of(context)!.persoAvatar,
        description:
            AppLocalizations.of(context)!.explainPersoAvatar,
        icon: Icons.settings,
      ),
      OnboardingStep(
        title: AppLocalizations.of(context)!.persoProfil,
        description: AppLocalizations.of(context)!.explainPersoProfil,
        icon: Icons.settings,
      ),
      OnboardingStep(
        title: AppLocalizations.of(context)!.bingoQuot,
        description: AppLocalizations.of(context)!.explainBingoQuot,
        icon: Icons.check_circle,
      ),
      OnboardingStep(
        title: AppLocalizations.of(context)!.tacheQuot,
        description:
            AppLocalizations.of(context)!.explainTacheQuot,
        icon: Icons.shuffle_on_rounded,
      ),
      OnboardingStep(
        title: AppLocalizations.of(context)!.notificationTitre,
        description: AppLocalizations.of(context)!.explainNotificationTitre,
        icon: Icons.notifications,
      ),
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: steps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(steps[index]);
                },
              ),
            ),
            _buildIndicator(steps.length),
            _buildButtons(steps.length),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingStep step) {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(step.icon, size: 120, color: Theme.of(context).primaryColor),
          SizedBox(height: 40),
          Text(
            step.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Text(
            step.description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(int sizeStep) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        sizeStep,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).primaryColor
                : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons(int sizeSteps) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(AppLocalizations.of(context)!.retour),
            )
          else
            SizedBox(width: 80),
          ElevatedButton(
            onPressed: () async {
              if (_currentPage == sizeSteps - 1) {
                // Marquer l'onboarding comme vu
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('onboarding_completed', true);

                if (mounted) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              } else {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Text(
              _currentPage == sizeSteps - 1
                  ? AppLocalizations.of(context)!.commencer
                  : AppLocalizations.of(context)!.suivant,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingStep {
  final String title;
  final String description;
  final IconData icon;

  OnboardingStep({
    required this.title,
    required this.description,
    required this.icon,
  });
}
