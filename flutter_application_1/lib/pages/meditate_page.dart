import 'package:flutter/material.dart';
import 'session_detail_page.dart';
import 'podcast_page.dart';
import 'tasks_dashboard_page.dart';

class MeditatePage extends StatelessWidget {
  const MeditatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _MeditationAppBar.create(),
      body: _MeditationBody(
        onSessionTap: () => _openSessionDetail(context),
        onPodcastTap: () => _openPodcast(context),
        onTasksTap: () => _openTasks(context),
      ),
    );
  }

  void _openSessionDetail(BuildContext context) {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SessionDetailPage()),
    );
  }

  void _openPodcast(BuildContext context) {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PodcastPage()),
    );
  }

  void _openTasks(BuildContext context) {
    if (!context.mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const TasksDashboardPage()),
    );
  }
}

class _MeditationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MeditationAppBar();

  factory _MeditationAppBar.create() => const _MeditationAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Meditate',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }
}

class _MeditationBody extends StatelessWidget {
  final VoidCallback onSessionTap;
  final VoidCallback onPodcastTap;
  final VoidCallback onTasksTap;

  const _MeditationBody({
    required this.onSessionTap,
    required this.onPodcastTap,
    required this.onTasksTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _MeditationContent(
          onSessionTap: onSessionTap,
          onPodcastTap: onPodcastTap,
          onTasksTap: onTasksTap,
        ),
      ),
    );
  }
}

class _MeditationContent extends StatelessWidget {
  final VoidCallback onSessionTap;
  final VoidCallback onPodcastTap;
  final VoidCallback onTasksTap;

  const _MeditationContent({
    required this.onSessionTap,
    required this.onPodcastTap,
    required this.onTasksTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _CategorySelector(),
        const SizedBox(height: 24),
        _FeaturedMeditationCard(onTap: onSessionTap),
        const SizedBox(height: 24),
        _MeditationGrid(onTap: onSessionTap),
        const SizedBox(height: 24),
        _QuickAccessCard(
          icon: Icons.podcasts,
          title: 'Podcasts',
          description: 'Listen to our meditation podcasts',
          color: Colors.grey.shade100,
          onTap: onPodcastTap,
        ),
        const SizedBox(height: 24),
        _QuickAccessCard(
          icon: Icons.task_alt,
          title: 'Tasks Dashboard',
          description: 'Manage your tasks and projects',
          color: Colors.blue.shade50,
          onTap: onTasksTap,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector();

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Bible In a Year', 'Dailies', 'Minutes', 'Nover'];
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          return Padding(
            padding: EdgeInsets.only(right: index < categories.length - 1 ? 12 : 0),
            child: _CategoryBadge(
              label: category,
              selected: index == 0,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final String label;
  final bool selected;

  const _CategoryBadge({required this.label, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF2DD4BF) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _FeaturedMeditationCard extends StatelessWidget {
  final VoidCallback onTap;

  const _FeaturedMeditationCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.yellow.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _FeaturedImage(),
              _FeaturedContent(),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Colors.yellow.shade200,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _CircleIcon(Colors.orange.shade300, Icons.wb_sunny),
          const SizedBox(width: 20),
          _CircleIcon(Colors.blue.shade800, Icons.nightlight_round),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final Color color;
  final IconData icon;

  const _CircleIcon(this.color, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Icon(icon, size: 50, color: Colors.white),
    );
  }
}

class _FeaturedContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'A Song of Moon',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Start with the basics.',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _InfoRow(Icons.favorite_border, '9 Sessions'),
              _InfoRow(Icons.arrow_forward, 'Start', showIcon: false),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool showIcon;

  const _InfoRow(this.icon, this.text, {this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showIcon) ...[
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 4),
        ],
        Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

class _MeditationGrid extends StatelessWidget {
  final VoidCallback onTap;

  const _MeditationGrid({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final sessions = [
      _SessionData('The Sleep Hour', 'Ashna Mukherjee', '3 Sessions', Colors.orange.shade200),
      _SessionData('Easy on the Mission', 'Peter Mach', '5 minutes', Colors.yellow.shade200),
      _SessionData('Relax with Me', 'Amanda James', '3 Sessions', Colors.blue.shade200),
      _SessionData('Sun and Energy', 'Micheal Hiu', '5 minutes', const Color(0xFF2DD4BF).withValues(alpha: 0.3)),
    ];

    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _SessionTile(sessions[0], onTap)),
            const SizedBox(width: 12),
            Expanded(child: _SessionTile(sessions[1], onTap)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _SessionTile(sessions[2], onTap)),
            const SizedBox(width: 12),
            Expanded(child: _SessionTile(sessions[3], onTap)),
          ],
        ),
      ],
    );
  }
}

class _SessionData {
  final String title;
  final String author;
  final String duration;
  final Color color;

  _SessionData(this.title, this.author, this.duration, this.color);
}

class _SessionTile extends StatelessWidget {
  final _SessionData data;
  final VoidCallback onTap;

  const _SessionTile(this.data, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: data.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: data.color,
                ),
                child: Center(
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 40,
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.author,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              data.duration,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const Row(
                          children: [
                            Text('Start', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            SizedBox(width: 4),
                            Icon(Icons.arrow_forward, size: 14, color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _QuickAccessCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(icon, size: 40, color: const Color(0xFF2DD4BF)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
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
                    Text(
                      description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
