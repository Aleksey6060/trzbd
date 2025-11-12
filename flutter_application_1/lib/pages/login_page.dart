import 'package:flutter/material.dart';
import 'meditate_page.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  static const _primaryColor = Color(0xFF2DD4BF);
  static const _imageAsset = 'assets/image 3.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _primaryColor,
      body: SafeArea(
        child: _ContentLayout(
          backgroundImage: _BackgroundDecoration(assetPath: _imageAsset),
          header: _BrandingSection(),
          actions: _AuthActionsSection(
            onNavigate: () => _handleNavigation(context),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context) {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const MeditatePage()),
    );
  }
}

class _ContentLayout extends StatelessWidget {
  final Widget backgroundImage;
  final Widget header;
  final Widget actions;

  const _ContentLayout({
    required this.backgroundImage,
    required this.header,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        backgroundImage,
        Column(
          children: [header, actions],
        ),
      ],
    );
  }
}

class _BackgroundDecoration extends StatelessWidget {
  final String assetPath;

  const _BackgroundDecoration({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.45;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: height,
        child: Image.asset(
          assetPath,
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
          errorBuilder: (_, __, ___) => const _ImagePlaceholder(),
        ),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.transparent,
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          color: Colors.white54,
          size: 50,
        ),
      ),
    );
  }
}

class _BrandingSection extends StatelessWidget {
  const _BrandingSection();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 60),
        _AppTitle(),
        SizedBox(height: 8),
        _AppSubtitle(),
        SizedBox(height: 60),
      ],
    );
  }
}

class _AppTitle extends StatelessWidget {
  const _AppTitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'medinow',
      style: TextStyle(
        fontSize: 42,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _AppSubtitle extends StatelessWidget {
  const _AppSubtitle();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Meditate With Us!',
      style: TextStyle(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _AuthActionsSection extends StatelessWidget {
  final VoidCallback onNavigate;

  const _AuthActionsSection({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _AuthButton.primary(
            label: 'Sign in with Apple',
            backgroundColor: Colors.white,
            textColor: Colors.black,
            onPressed: onNavigate,
          ),
          const SizedBox(height: 16),
          _AuthButton.primary(
            label: 'Continue with Email or Phone',
            backgroundColor: const Color(0xFFCDFDFE),
            textColor: Colors.black,
            onPressed: onNavigate,
          ),
          const SizedBox(height: 16),
          _AuthButton.secondary(
            label: 'Continue With Google',
            onPressed: onNavigate,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isPrimary;

  const _AuthButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isPrimary = true,
  });

  factory _AuthButton.primary({
    required String label,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return _AuthButton(
      label: label,
      backgroundColor: backgroundColor,
      textColor: textColor,
      onPressed: onPressed,
      isPrimary: true,
    );
  }

  factory _AuthButton.secondary({
    required String label,
    required VoidCallback onPressed,
  }) {
    return _AuthButton(
      label: label,
      onPressed: onPressed,
      isPrimary: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: textColor,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 0,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    } else {
      return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Colors.black,
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
  }
}
