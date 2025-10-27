// Onboarding d'accueil qui explique l'application
// il ne s'affiche qu'une fois à la première ouverture 


import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      title: 'Bienvenue sur TDAH\'elpe ! 👋',
      description: 'Une application pour t\'aider à organiser ta journée',
      icon: Icons.home,
    ),
    OnboardingStep(
      title: 'Bingo quotidien 🎯',
      description: 'Valide toutes le bingo au fil de la journée',
      icon: Icons.check_circle,
    ),
    OnboardingStep(
      title: 'Notifications 🔔',
      description: 'Reçois des rappels pour ne rien oublier',
      icon: Icons.notifications,
    ),
    OnboardingStep(
      title: 'Personnalise ton profil ⚙️',
      description: 'Configure tes heures préférées dans les paramètres',
      icon: Icons.settings,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _steps.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildPage(_steps[index]);
                },
              ),
            ),
            _buildIndicator(),
            _buildButtons(),
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

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _steps.length,
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

  Widget _buildButtons() {
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
              child: Text('Retour'),
            )
          else
            SizedBox(width: 80),
          ElevatedButton(
            onPressed: () async {
              if (_currentPage == _steps.length - 1) {
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
              _currentPage == _steps.length - 1 ? 'Commencer' : 'Suivant',
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
