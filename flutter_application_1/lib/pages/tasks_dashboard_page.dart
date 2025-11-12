import 'package:flutter/material.dart';

class TasksDashboardPage extends StatelessWidget {
  const TasksDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: _DashboardContent(),
      ),
      bottomNavigationBar: _BottomNavigation.create(),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _UserProfileHeader(),
          _WeeklyTasksSection(),
          _TodayTasksSection(),
        ],
      ),
    );
  }
}

class _UserProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _Avatar.circle(Colors.blue.shade200),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good Evening!',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Text(
                  'Dan Smith',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          _IconButton(Icons.search),
          const SizedBox(width: 12),
          _IconButton(Icons.notifications_none),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final Color color;

  const _Avatar.circle(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.person, color: Colors.white),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;

  const _IconButton(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.black),
    );
  }
}

class _WeeklyTasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('My Weekly Tasks', '18 Tasks Pending'),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _WeeklyTaskCard(
                  title: 'Create a Landing Page',
                  tags: [
                    _TaskLabel('UI/UX Design', Colors.purple.shade100, Colors.purple),
                    _TaskLabel('High', Colors.pink.shade100, Colors.red),
                  ],
                  dueDate: 'Mon, 12 July 2022',
                  participantCount: 3,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _WeeklyTaskCard(
                  title: 'Develop a Website',
                  tags: [
                    _TaskLabel('Development', Colors.orange.shade100, Colors.orange),
                    _TaskLabel('Low', Colors.green.shade100, Colors.green),
                  ],
                  dueDate: 'Mon, 30 July 2022',
                  participantCount: 2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.filter_list, color: Colors.grey.shade600),
            const SizedBox(width: 12),
            Icon(Icons.add_circle_outline, color: Colors.grey.shade600),
          ],
        ),
      ],
    );
  }
}

class _TaskLabel {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const _TaskLabel(this.text, this.backgroundColor, this.textColor);
}

class _WeeklyTaskCard extends StatelessWidget {
  final String title;
  final List<_TaskLabel> tags;
  final String dueDate;
  final int participantCount;

  const _WeeklyTaskCard({
    required this.title,
    required this.tags,
    required this.dueDate,
    required this.participantCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TagsRow(tags),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ParticipantsIndicator(count: participantCount),
              const SizedBox(width: 8),
              _DateIndicator(date: dueDate),
            ],
          ),
        ],
      ),
    );
  }
}

class _TagsRow extends StatelessWidget {
  final List<_TaskLabel> tags;

  const _TagsRow(this.tags);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: tag.backgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            tag.text,
            style: TextStyle(
              fontSize: 12,
              color: tag.textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ParticipantsIndicator extends StatelessWidget {
  final int count;

  const _ParticipantsIndicator({required this.count});

  @override
  Widget build(BuildContext context) {
    final visibleCount = count.clamp(0, 3);
    final width = visibleCount > 3 ? 88.0 : (visibleCount * 28.0 - (visibleCount - 1) * 12.0);
    return SizedBox(
      width: width,
      height: 28,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ...List.generate(visibleCount, (index) {
            return Positioned(
              left: index * 16.0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.blue.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.person, size: 16, color: Colors.white),
              ),
            );
          }),
          if (count > 3)
            Positioned(
              left: 48.0,
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.orange.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    '${count - 3}+',
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DateIndicator extends StatelessWidget {
  final String date;

  const _DateIndicator({required this.date});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              date,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayTasksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader('Today\'s Tasks', '18 Tasks Pending'),
          const SizedBox(height: 16),
          _TodayTaskRow(
            title: 'Design 2 App Screens',
            subtitle: 'Crypto Wallet App',
            date: 'Mon, 10 July 2022',
            isComplete: true,
            memberCount: 3,
          ),
          const SizedBox(height: 12),
          _TodayTaskRow(
            title: 'Design Homepage',
            subtitle: 'Water Company Website',
            date: 'Mon, 10 July 2022',
            isComplete: false,
            memberCount: 1,
          ),
        ],
      ),
    );
  }
}

class _TodayTaskRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final bool isComplete;
  final int memberCount;

  const _TodayTaskRow({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.isComplete,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    decoration: isComplete ? TextDecoration.lineThrough : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _CompletionCheckbox(completed: isComplete),
          const SizedBox(width: 12),
          _ParticipantsIndicator(count: memberCount),
        ],
      ),
    );
  }
}

class _CompletionCheckbox extends StatelessWidget {
  final bool completed;

  const _CompletionCheckbox({required this.completed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: completed ? Colors.blue : Colors.transparent,
        shape: BoxShape.circle,
        border: Border.all(
          color: completed ? Colors.blue : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: completed ? const Icon(Icons.check, color: Colors.white, size: 24) : null,
    );
  }
}

class _BottomNavigation extends StatelessWidget {
  const _BottomNavigation();

  factory _BottomNavigation.create() => const _BottomNavigation();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                Icons.home,
                'Home',
                active: true,
                onTap: () {
                  if (context.mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
              ),
              _NavItem(Icons.folder, 'Projects', active: false, onTap: () {}),
              _NavItem(Icons.calendar_today, 'Calendar', active: false, onTap: () {}),
              _NavItem(Icons.message, 'Messages', active: false, onTap: () {}),
              _NavItem(Icons.people, 'Members', active: false, onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem(this.icon, this.label, {this.active = false, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = active ? Colors.blue : Colors.grey;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
