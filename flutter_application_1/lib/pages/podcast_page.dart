import 'package:flutter/material.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({super.key});

  @override
  State<PodcastPage> createState() => PodcastPageState();
}

class PodcastPageState extends State<PodcastPage> {
  static const _backgroundAsset = 'assets/image 1.png';
  static const _backgroundHeightRatio = 0.5;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _PodcastBackground(assetPath: _backgroundAsset),
          Column(
            children: [
              _NavigationHeader(),
              SizedBox(height: screenHeight * _backgroundHeightRatio - 120),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _PodcastContentCard(),
                    _FloatingPlayButton(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PodcastBackground extends StatelessWidget {
  final String assetPath;

  const _PodcastBackground({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.5;
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.purple.shade200, Colors.blue.shade300],
        ),
      ),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple.shade200, Colors.blue.shade300],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _BackButton(),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      onPressed: () => Navigator.pop(context),
    );
  }
}

class _PodcastContentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(100),
      ),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              _PodcastTitle(),
              const SizedBox(height: 16),
              _FollowActionButton(),
              const SizedBox(height: 24),
              _PodcastDetailsCard(),
              const SizedBox(height: 16),
              _InvitationCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PodcastTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Secrets of Atlantis',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _FollowActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Text(
          'Follow',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.orange,
          ),
        ),
      ),
    );
  }
}

class _PodcastDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.purple.shade900,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HostProfile(),
          const SizedBox(height: 16),
          _DescriptionText(),
          const SizedBox(height: 16),
          _RatingInfo(),
          const SizedBox(height: 16),
          _ListenersInfo(),
        ],
      ),
    );
  }
}

class _HostProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.pink.shade300,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.person, color: Colors.white),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Codin',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.purple.shade800,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Host',
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DescriptionText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'The Secrets of Atlantis podcast is designed for all fantasy enthusiasts, everything from debunking underwat...',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'see more',
          style: TextStyle(fontSize: 14, color: Colors.blue),
        ),
      ],
    );
  }
}

class _RatingInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        const Text('4.8', style: TextStyle(fontSize: 14, color: Colors.white)),
        const Text(' (10)', style: TextStyle(fontSize: 14, color: Colors.white70)),
        const SizedBox(width: 8),
        Container(
          width: 4,
          height: 4,
          decoration: const BoxDecoration(color: Colors.white70, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        const Text('Fantasy', style: TextStyle(fontSize: 14, color: Colors.white)),
        const Spacer(),
        const Icon(Icons.notifications_none, color: Colors.white, size: 24),
      ],
    );
  }
}

class _ListenersInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _AvatarStack(),
        const SizedBox(width: 8),
        const Text('+10', style: TextStyle(fontSize: 14, color: Colors.white)),
        const Spacer(),
        _LiveIndicator(),
      ],
    );
  }
}

class _AvatarStack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final borderColor = Colors.purple.shade900;
    return SizedBox(
      width: 72,
      height: 32,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _Avatar(Colors.blue.shade300, borderColor, 0),
          _Avatar(Colors.green.shade300, borderColor, 20),
          _Avatar(Colors.orange.shade300, borderColor, 40),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final double left;

  const _Avatar(this.color, this.borderColor, this.left);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 2),
        ),
      ),
    );
  }
}

class _LiveIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        const Text(
          'Live',
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _InvitationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.yellow.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Row(
            children: [
              _IconBox(Colors.orange.shade200, Icons.cloud, Colors.orange),
              const SizedBox(width: 8),
              _IconBox(Colors.blue.shade200, Icons.face, Colors.blue),
            ],
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Invite your friends to join',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          const Icon(Icons.share, color: Colors.black),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  const _IconBox(this.backgroundColor, this.icon, this.iconColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}

class _FloatingPlayButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -40,
      left: 0,
      right: 0,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
