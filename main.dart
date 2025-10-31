import 'package:flutter/material.dart';

void main() {
  runApp(const PerfitlyLifeApp());
}

class PerfitlyLifeApp extends StatefulWidget {
  const PerfitlyLifeApp({super.key});

  @override
  State<PerfitlyLifeApp> createState() => _PerfitlyLifeAppState();
}

class _PerfitlyLifeAppState extends State<PerfitlyLifeApp> {
  bool isDarkMode = true;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PerfitlyLife',
      debugShowCheckedModeBanner: false,
      theme: isDarkMode
          ? ThemeData(
        primaryColor: const Color(0xFF8B0000), // Maroon
        scaffoldBackgroundColor: const Color(0xFF1A1A1A),
        brightness: Brightness.dark,
        fontFamily: 'Montserrat',
      )
          : ThemeData(
        primaryColor: const Color(0xFF8B0000), // Maroon
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        brightness: Brightness.light,
        fontFamily: 'Montserrat',
      ),
      home: WorkoutCategoryScreen(
        isDarkMode: isDarkMode,
        onThemeToggle: toggleTheme,
      ),
    );
  }
}

class WorkoutCategoryScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const WorkoutCategoryScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  State<WorkoutCategoryScreen> createState() => _WorkoutCategoryScreenState();
}

class _WorkoutCategoryScreenState extends State<WorkoutCategoryScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> categories = const [
    {'name': 'All', 'icon': Icons.dashboard, 'color': Color(0xFFFFD700)},
    {'name': 'Boxing', 'icon': Icons.sports_kabaddi, 'color': Color(0xFF8B0000)},
    {'name': 'Home Workout', 'icon': Icons.home, 'color': Color(0xFFFFD700)},
    {'name': 'Calisthenics', 'icon': Icons.self_improvement, 'color': Color(0xFF8B0000)},
    {'name': 'Yoga', 'icon': Icons.spa, 'color': Color(0xFFFFD700)},
  ];

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5);
    final textColor = widget.isDarkMode ? Colors.white : const Color(0xFF1A1A1A);
    final cardColor = widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.fitness_center, color: Color(0xFFFFD700), size: 28),
            const SizedBox(width: 8),
            Text(
              'PerfitlyLife',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 26,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Color(0xFF8B0000), Color(0xFFFFD700)],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: textColor.withOpacity(0.8)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(
                    isDarkMode: widget.isDarkMode,
                    onThemeToggle: widget.onThemeToggle,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Choose Your Grind',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20),

            // Category Filter Chips
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index]['name'] as String;
                  final isSelected = selectedCategory == category;

                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FilterChipWidget(
                      label: category,
                      icon: categories[index]['icon'] as IconData,
                      isSelected: isSelected,
                      isDarkMode: widget.isDarkMode,
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // Workout Categories Grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.85,
              ),
              itemCount: categories.length - 1, // Exclude 'All'
              itemBuilder: (context, index) {
                final category = categories[index + 1];
                return CategoryCard(
                  title: category['name'] as String,
                  icon: category['icon'] as IconData,
                  color: category['color'] as Color,
                  isDarkMode: widget.isDarkMode,
                );
              },
            ),

            const SizedBox(height: 30),

            // Featured Today Section
            Text(
              'Featured Today',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 15),

            Container(
              height: 200,
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF8B0000).withOpacity(0.8),
                    const Color(0xFFFFD700).withOpacity(0.6),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B0000).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_circle_fill,
                    size: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Upload Your Workout Video',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Upload Section
            Text(
              'Share Your Journey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: UploadButton(
                    icon: Icons.video_library,
                    label: 'Upload Video',
                    isDarkMode: widget.isDarkMode,
                    onTap: () {
                      // Add video upload functionality
                    },
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: UploadButton(
                    icon: Icons.photo_library,
                    label: 'Upload Photo',
                    isDarkMode: widget.isDarkMode,
                    onTap: () {
                      // Add photo upload functionality
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FilterChipWidget extends StatefulWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isDarkMode;
  final VoidCallback onTap;

  const FilterChipWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: widget.isSelected || isHovered
                ? const LinearGradient(
              colors: [Color(0xFF8B0000), Color(0xFFFFD700)],
            )
                : null,
            color: widget.isSelected || isHovered
                ? null
                : (widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.white),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: widget.isSelected || isHovered
                  ? Colors.transparent
                  : const Color(0xFFFFD700).withOpacity(0.5),
              width: 2,
            ),
            boxShadow: widget.isSelected || isHovered
                ? [
              BoxShadow(
                color: const Color(0xFFFFD700).withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 18,
                color: widget.isSelected || isHovered
                    ? Colors.white
                    : const Color(0xFFFFD700),
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  color: widget.isSelected || isHovered
                      ? Colors.white
                      : (widget.isDarkMode ? Colors.white : const Color(0xFF1A1A1A)),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isDarkMode;

  const CategoryCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.isDarkMode,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardColor = widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(isHovered ? 1.05 : 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20),
            gradient: isHovered
                ? LinearGradient(
              colors: [
                const Color(0xFF8B0000).withOpacity(0.9),
                const Color(0xFFFFD700).withOpacity(0.7),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? const Color(0xFFFFD700).withOpacity(0.5)
                    : Colors.black.withOpacity(0.2),
                blurRadius: isHovered ? 20 : 10,
                offset: Offset(0, isHovered ? 10 : 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // Navigate to category details
              },
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      size: 60,
                      color: isHovered ? Colors.white : widget.color,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isHovered
                            ? Colors.white
                            : (widget.isDarkMode ? Colors.white : const Color(0xFF1A1A1A)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UploadButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isDarkMode;
  final VoidCallback onTap;

  const UploadButton({
    super.key,
    required this.icon,
    required this.label,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  State<UploadButton> createState() => _UploadButtonState();
}

class _UploadButtonState extends State<UploadButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardColor = widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isHovered ? null : cardColor,
            gradient: isHovered
                ? const LinearGradient(
              colors: [Color(0xFF8B0000), Color(0xFFFFD700)],
            )
                : null,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: const Color(0xFFFFD700).withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? const Color(0xFFFFD700).withOpacity(0.4)
                    : Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                widget.icon,
                size: 40,
                color: isHovered ? Colors.white : const Color(0xFFFFD700),
              ),
              const SizedBox(height: 10),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isHovered
                      ? Colors.white
                      : (widget.isDarkMode ? Colors.white : const Color(0xFF1A1A1A)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5);
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1A1A1A);
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dark Mode Toggle
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: const Color(0xFFFFD700),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                  Switch(
                    value: isDarkMode,
                    onChanged: (value) => onThemeToggle(),
                    activeColor: const Color(0xFFFFD700),
                    activeTrackColor: const Color(0xFF8B0000),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Contact Info Section
            Text(
              'Contact Developer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 15),

            SocialMediaButton(
              icon: Icons.work,
              label: 'LinkedIn',
              color: const Color(0xFF0077B5),
              isDarkMode: isDarkMode,
              onTap: () {
                // Open LinkedIn profile
              },
            ),
            const SizedBox(height: 15),

            SocialMediaButton(
              icon: Icons.camera_alt,
              label: 'Instagram',
              color: const Color(0xFFE4405F),
              isDarkMode: isDarkMode,
              onTap: () {
                // Open Instagram profile
              },
            ),
            const SizedBox(height: 15),

            SocialMediaButton(
              icon: Icons.chat,
              label: 'WhatsApp',
              color: const Color(0xFF25D366),
              isDarkMode: isDarkMode,
              onTap: () {
                // Open WhatsApp chat
              },
            ),

            const SizedBox(height: 30),

            Center(
              child: Text(
                '© 2025 PerfitlyLife. All rights reserved.',
                style: TextStyle(
                  color: textColor.withOpacity(0.5),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDarkMode;
  final VoidCallback onTap;

  const SocialMediaButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isDarkMode,
    required this.onTap,
  });

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final cardColor = widget.isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isHovered ? widget.color : cardColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.color.withOpacity(0.5),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isHovered ? widget.color.withOpacity(0.4) : Colors.black.withOpacity(0.1),
                blurRadius: isHovered ? 15 : 10,
                offset: Offset(0, isHovered ? 8 : 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                widget.icon,
                color: isHovered ? Colors.white : widget.color,
                size: 28,
              ),
              const SizedBox(width: 20),
              Text(
                'Follow on ${widget.label}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isHovered
                      ? Colors.white
                      : (widget.isDarkMode ? Colors.white : const Color(0xFF1A1A1A)),
                ),
              ),
              const Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: isHovered ? Colors.white : widget.color,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}