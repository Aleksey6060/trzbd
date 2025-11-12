import 'package:flutter/material.dart';

class SessionDetailPage extends StatelessWidget {
  const SessionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () {
            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SessionHeroImage(),
            _SessionInfoPanel(),
          ],
        ),
      ),
    );
  }
}

class _SessionHeroImage extends StatelessWidget {
  static const _assetPath = 'assets/Component 1.png';
  static const _height = 350.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: _height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.yellow.shade200, Colors.blue.shade100],
        ),
      ),
      child: Center(
        child: Image.asset(
          _assetPath,
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.95,
          height: 320,
          errorBuilder: (_, __, ___) => _ImageFallback(),
        ),
      ),
    );
  }
}

class _ImageFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.blue.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
      ),
    );
  }
}

class _SessionInfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AuthorName(),
          const SizedBox(height: 8),
          _SessionTitle(),
          const SizedBox(height: 16),
          _SessionDescription(),
          const SizedBox(height: 32),
          _PlayActionButton(),
          const SizedBox(height: 32),
          _SessionList(),
        ],
      ),
    );
  }
}

class _AuthorName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Peter Mach',
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }
}

class _SessionTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Mind Deep Relax',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }
}

class _SessionDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Join the Community as we prepare over 33 days to relax and feel joy with the mind and happnies session across the World.',
      style: TextStyle(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }
}

class _PlayActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2DD4BF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, size: 24),
            SizedBox(width: 8),
            Text(
              'Play Next Session',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sessions = [
      _SessionEntry('Sweet Memories', 'December 29 Pre-Launch', Colors.blue),
      _SessionEntry('A Day Dream', 'December 29 Pre-Launch', const Color(0xFF2DD4BF)),
      _SessionEntry('Mind Explore', 'December 29 Pre-Launch', Colors.orange),
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sessions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        ...sessions.asMap().entries.map((entry) {
          final index = entry.key;
          final session = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: index < sessions.length - 1 ? 12 : 0),
            child: _SessionListItem(
              title: session.title,
              date: session.date,
              color: session.color,
            ),
          );
        }),
      ],
    );
  }
}

class _SessionEntry {
  final String title;
  final String date;
  final Color color;

  _SessionEntry(this.title, this.date, this.color);
}

class _SessionListItem extends StatelessWidget {
  final String title;
  final String date;
  final Color color;

  const _SessionListItem({
    required this.title,
    required this.date,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.more_vert, color: Colors.grey),
        ],
      ),
    );
  }
}
