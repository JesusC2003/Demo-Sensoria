// lib/UI/onboarding/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/responsive_utils.dart';
import '../home/home_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.touch_app,
      title: '¡Bienvenido!',
      description:
          'Descubre cómo funciona la tecnología táctil de tu dispositivo',
      color: AppTheme.primaryBlue,
      gradient: [Color(0xFF42A5F5), Color(0xFF1E88E5)],
    ),
    OnboardingPage(
      icon: Icons.screen_search_desktop,
      title: '¿Qué es un Sensor Capacitivo?',
      description:
          'Las pantallas táctiles modernas utilizan tecnología capacitiva que detecta la conductividad eléctrica de tu cuerpo',
      color: AppTheme.secondaryPurple,
      gradient: [Color(0xFFAB47BC), Color(0xFF8E24AA)],
    ),
    OnboardingPage(
      icon: Icons.electrical_services,
      title: '¿Cómo Funciona?',
      description:
          'La pantalla genera un campo eléctrico constante. Cuando tocas la pantalla con tu dedo, tu cuerpo actúa como conductor y altera la capacitancia en ese punto específico',
      color: AppTheme.accentAmber,
      gradient: [Color(0xFFFFA726), Color(0xFFFB8C00)],
    ),
    OnboardingPage(
      icon: Icons.location_searching,
      title: 'Detección Precisa',
      description:
          'El sistema detecta la posición exacta del contacto midiendo los cambios en la carga eléctrica en múltiples puntos de la pantalla',
      color: AppTheme.successGreen,
      gradient: [Color(0xFF66BB6A), Color(0xFF43A047)],
    ),
    OnboardingPage(
      icon: Icons.games,
      title: '¡Experimenta!',
      description:
          'Ahora puedes explorar tres modos interactivos para ver el sensor capacitivo en acción',
      color: AppTheme.errorRed,
      gradient: [Color(0xFFEF5350), Color(0xFFE53935)],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _skipOnboarding() {
    _completeOnboarding();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _pages[_currentPage].gradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildSkipButton(),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPageContent(_pages[index]);
                  },
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    if (_currentPage == _pages.length - 1) return const SizedBox.shrink();

    final padding = ResponsiveUtils.getResponsivePadding(context);
    final textSize = ResponsiveUtils.sp(context, 16);

    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: TextButton(
          onPressed: _skipOnboarding,
          child: Text(
            'Omitir',
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingPage page) {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 120);
    final titleSize = ResponsiveUtils.sp(context, 28);
    final descriptionSize = ResponsiveUtils.sp(context, 16);
    final spacing = ResponsiveUtils.getVerticalSpacing(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icono animado
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  padding: EdgeInsets.all(padding * 2),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    page.icon,
                    size: iconSize,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: spacing * 3),
          
          // Título
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          SizedBox(height: spacing * 2),
          
          // Descripción
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: descriptionSize,
              color: Colors.white,
              height: 1.6,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection() {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final spacing = ResponsiveUtils.getVerticalSpacing(context);

    return Padding(
      padding: EdgeInsets.all(padding * 2),
      child: Column(
        children: [
          _buildPageIndicator(),
          SizedBox(height: spacing * 2),
          _buildNavigationButton(),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _pages.length,
        (index) => _buildDot(index),
      ),
    );
  }

  Widget _buildDot(int index) {
    final isActive = index == _currentPage;
    final dotSize = ResponsiveUtils.scaleWidth(context, isActive ? 12 : 8);
    final spacing = ResponsiveUtils.getVerticalSpacing(context, multiplier: 0.5);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: spacing),
      width: isActive ? dotSize * 2.5 : dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(dotSize / 2),
      ),
    );
  }

  Widget _buildNavigationButton() {
    final padding = ResponsiveUtils.getResponsivePadding(context);
    final textSize = ResponsiveUtils.sp(context, 18);
    final iconSize = ResponsiveUtils.getIconSize(context, baseSize: 24);
    final isLastPage = _currentPage == _pages.length - 1;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _nextPage,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: _pages[_currentPage].color,
          padding: EdgeInsets.symmetric(
            vertical: padding,
            horizontal: padding * 2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.getBorderRadius(context),
            ),
          ),
          elevation: 8,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              isLastPage ? '¡Comenzar!' : 'Siguiente',
              style: TextStyle(
                fontSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: ResponsiveUtils.getVerticalSpacing(context)),
            Icon(
              isLastPage ? Icons.check_circle : Icons.arrow_forward,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<Color> gradient;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.gradient,
  });
}