// main.dart - Premium Ultra Portfolio v1 with Full Animations, Sounds & Interactions
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PremiumPortfolioV1());
}

class PremiumPortfolioV1 extends StatefulWidget {
  const PremiumPortfolioV1({super.key});

  @override
  State<PremiumPortfolioV1> createState() => _PremiumPortfolioV1State();
}

class _PremiumPortfolioV1State extends State<PremiumPortfolioV1> {
  bool _isDark = true;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isSoundEnabled = true;
  bool _showCursorEffect = true;

  @override
  void initState() {
    super.initState();
    _initializeAudio();
  }

  void _initializeAudio() async {
    // Initialize audio player
    await _audioPlayer.setSourceUrl('assets/sounds/click.mp3');
  }

  void _playClickSound() {
    if (_isSoundEnabled) {
      _audioPlayer.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      data: _isDark ? _darkTheme() : _lightTheme(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: MaterialApp(
        title: 'Moe Kyaw Aung - Senior Android Developer',
        debugShowCheckedModeBanner: false,
        home: PortfolioHomePage(
          isDark: _isDark,
          toggleTheme: () {
            _playClickSound();
            setState(() {
              _isDark = !_isDark;
            });
          },
          playSound: _playClickSound,
        ),
      ),
    );
  }

  ThemeData _darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF),
        brightness: Brightness.dark,
      ),
      fontFamily: 'Inter',
      backgroundColor: const Color(0xFF0A0E1A),
      scaffoldBackgroundColor: const Color(0xFF0A0E1A),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6C63FF),
        brightness: Brightness.light,
      ),
      fontFamily: 'Inter',
      backgroundColor: const Color(0xFFF8F9FF),
      scaffoldBackgroundColor: const Color(0xFFF8F9FF),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;
  final VoidCallback playSound;

  const PortfolioHomePage({
    super.key,
    required this.isDark,
    required this.toggleTheme,
    required this.playSound,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  int _selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {};
  final List<String> _sectionIds = [
    'hero', 'stats', 'quick', 'focus', 'tech', 
    'featured', 'projects', 'certs', 'contact'
  ];
  bool _isResuming = false;
  bool _isDownloading = false;
  bool _showFloatingActions = false;
  final List<Offset> _clickPositions = [];
  final Map<String, bool> _isHovered = {};
  bool _showCursorTrail = true;
  final List<Offset> _trailPositions = [];

  @override
  void initState() {
    super.initState();
    _initializeSections();
    _setupHapticFeedback();
    
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showFloatingActions = true;
        });
      }
    });
  }

  void _initializeSections() {
    for (final id in _sectionIds) {
      _sectionKeys[id] = GlobalKey();
    }
  }

  void _setupHapticFeedback() {
    // Enable haptic feedback
    HapticFeedback.lightImpact();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Stack(
      children: [
        // Animated Gradient Background
        if (widget.isDark) _buildAnimatedGradientBackground(colorScheme),
        
        // Particle Network Effect
        if (widget.isDark) _buildParticleNetwork(colorScheme),
        
        // Main Content
        AnimatedBuilder(
          animation: _scrollController,
          builder: (context, _) {
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Floating Controls
                _buildFloatingControls(colorScheme),
                
                // Cursor Trail Effect
                if (_showCursorTrail) _buildCursorTrail(),
                
                // Hero Section
                _buildAnimatedSlideInSection(
                  context,
                  key: _sectionKeys['hero']!,
                  delay: 0.0,
                  child: _buildHeroSection(context),
                ),
                
                // Stats Section
                _buildAnimatedScaleInSection(
                  context,
                  key: _sectionKeys['stats']!,
                  delay: 0.15,
                  child: _buildStatsSection(context),
                ),
                
                // Quick Actions
                _buildAnimatedStaggerSection(
                  context,
                  key: _sectionKeys['quick']!,
                  delay: 0.3,
                  child: _buildQuickActions(context),
                ),
                
                _buildGradientDivider(colorScheme),
                
                // Focus Areas
                _buildAnimatedFlipInSection(
                  context,
                  key: _sectionKeys['focus']!,
                  delay: 0.45,
                  child: _buildFocusAreas(context),
                ),
                
                _buildGradientDivider(colorScheme),
                
                // Tech Stack
                _buildAnimatedWrapInSection(
                  context,
                  key: _sectionKeys['tech']!,
                  delay: 0.6,
                  child: _buildTechStack(context),
                ),
                
                _buildGradientDivider(colorScheme),
                
                // Featured Project
                _buildAnimatedFloatInSection(
                  context,
                  key: _sectionKeys['featured']!,
                  delay: 0.75,
                  child: _buildFeaturedProject(context),
                ),
                
                _buildGradientDivider(colorScheme),
                
                // All Projects
                _buildAnimatedGridInSection(
                  context,
                  key: _sectionKeys['projects']!,
                  delay: 0.9,
                  child: _buildAllProjects(context),
                ),
                
                _buildGradientDivider(colorScheme),
                
                // Certifications
                _buildAnimatedRotateInSection(
                  context,
                  key: _sectionKeys['certs']!,
                  delay: 1.05,
                  child: _buildCertifications(context),
                ),
                
                _buildGradientDivider(colorScheme),
                
                // Contact
                _buildAnimatedPulseInSection(
                  context,
                  key: _sectionKeys['contact']!,
                  delay: 1.2,
                  child: _buildContact(context),
                ),
                
                // Footer
                _buildFooter(context),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildAnimatedGradientBackground(ColorScheme colorScheme) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        return IgnorePointer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.background,
                  colorScheme.primary.withOpacity(0.1),
                  colorScheme.background,
                ],
                stops: [
                  0.0,
                  (_scrollController.offset * 0.001).clamp(0.0, 1.0),
                  1.0,
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildParticleNetwork(ColorScheme colorScheme) {
    return IgnorePointer(
      child: CustomPaint(
        painter: ParticleNetworkPainter(
          color: colorScheme.primary.withOpacity(0.08),
          scrollOffset: _scrollController.offset,
        ),
      ),
    );
  }

  Widget _buildCursorTrail() {
    return IgnorePointer(
      child: CustomPaint(
        painter: CursorTrailPainter(
          positions: _trailPositions,
          color: const Color(0xFF6C63FF),
        ),
      ),
    );
  }

  Widget _buildAnimatedSlideInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (600 * (1 + delay)).round()),
          child: SlideTransition(
            position: TweenVector2(
              begin: const Vector2(-0.15, 0.1),
              end: const Vector2(0, 0),
            ).animate(
              CurvedAnimation(
                parent: AlwaysStoppedAnimation(isVisible ? 1.0 : 0.0),
                curve: Curves.easeOutCubic,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedScaleInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: AlwaysStoppedAnimation(isVisible ? 1.0 : 0.0),
              curve: Curves.easeOutBack,
            ),
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedStaggerSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: isVisible ? 1.0 : 0.0),
            duration: Duration(milliseconds: (600 * (1 + delay)).round()),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: child,
              );
            },
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedFlipInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: isVisible ? 1.0 : 0.0),
            duration: Duration(milliseconds: (700 * (1 + delay)).round()),
            builder: (context, value, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  .setEntry(3, 2, 0.001)
                  .rotateX(value * math.pi),
                child: child,
              );
            },
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedWrapInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: child,
        );
      },
    );
  }

  Widget _buildAnimatedFloatInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: isVisible ? 1.0 : 0.0),
            duration: Duration(milliseconds: (800 * (1 + delay)).round()),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, -20 * value),
                child: child,
              );
            },
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedGridInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: child,
        );
      },
    );
  }

  Widget _buildAnimatedRotateInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0.0, end: isVisible ? 1.0 : 0.0),
            duration: Duration(milliseconds: (900 * (1 + delay)).round()),
            builder: (context, value, child) {
              return Transform.rotate(
                angle: value * 0.2,
                child: child,
              );
            },
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildAnimatedPulseInSection(
    BuildContext context, {
    required GlobalKey key,
    double delay = 0.0,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: _scrollController,
      builder: (context, _) {
        final sectionContext = key.currentContext;
        if (sectionContext == null) return child;

        final renderBox = sectionContext.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        final isVisible = position.dy < MediaQuery.of(context).size.height - 100;

        return AnimatedOpacity(
          opacity: isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: (500 * (1 + delay)).round()),
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 1.0, end: isVisible ? 1.02 : 1.0),
            duration: Duration(milliseconds: (1000 * (1 + delay)).round()),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildGradientDivider(ColorScheme colorScheme) {
    return Container(
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              Colors.transparent,
              colorScheme.primary,
              colorScheme.secondary,
              colorScheme.primary,
              Colors.transparent,
            ],
            stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
          ).createShader(bounds);
        },
        child: Container(
          height: 2,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildFloatingControls(ColorScheme colorScheme) {
    return Positioned(
      top: 20,
      right: 20,
      child: AnimatedOpacity(
        opacity: _showFloatingActions ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 400),
        child: Column(
          children: [
            // Sound Toggle
            GestureDetector(
              onTap: () {
                widget.playSound();
                setState(() {
                  widget.isDark = !widget.isDark;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: widget._isSoundEnabled 
                      ? const Color(0xFF3DDC97) 
                      : Colors.grey,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: widget._isSoundEnabled
                          ? const Color(0xFF3DDC97).withOpacity(0.4)
                          : Colors.grey.withOpacity(0.3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Icon(
                  widget._isSoundEnabled ? Icons.volume_up : Icons.volume_off,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
            
            // Theme Toggle
            GestureDetector(
              onTap: () {
                widget.playSound();
                widget.toggleTheme();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: widget.isDark 
                      ? const Color(0xFF6C63FF) 
                      : const Color(0xFFF8F9FF),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isDark
                          ? const Color(0xFF6C63FF).withOpacity(0.4)
                          : Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Icon(
                  widget.isDark ? Icons.light_mode : Icons.dark_mode,
                  size: 24,
                  color: widget.isDark ? Colors.white : const Color(0xFF6C63FF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ... (Continue with all other sections using haptic feedback and animations)

  // Enhanced Action Methods with Haptic Feedback
  void _scrollToSection(String sectionId) {
    widget.playSound();
    HapticFeedback.mediumImpact();
    
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      final renderBox = key!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      _scrollController.animateTo(
        _scrollController.offset + position.dy - 100,
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _downloadResume() async {
    if (_isResuming) return;
    widget.playSound();
    HapticFeedback.lightImpact();
    setState(() => _isResuming = true);

    try {
      final Uri url = Uri.parse('https://moekyawaung.github.io/resume.pdf');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      HapticFeedback.heavyImpact();
    }

    setState(() => _isResuming = false);
  }

  void _openLinkedIn() async {
    widget.playSound();
    HapticFeedback.mediumImpact();
    
    final Uri url = Uri.parse('https://linkedin.com/in/moe-kyaw-aung-2653093a1');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  void _openGitHub(String project) async {
    widget.playSound();
    HapticFeedback.mediumImpact();
    
    final Uri url = Uri.parse('https://github.com/Dev-moe-kyawaung');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}

// Particle Network Painter
class ParticleNetworkPainter extends CustomPainter {
  final Color color;
  final double scrollOffset;

  ParticleNetworkPainter({required this.color, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      .color = color
      .strokeWidth = 1.0
      .strokeCap = StrokeCap.round;

    // Draw particles and connections
    for (int i = 0; i < 30; i++) {
      final x1 = ((i * 80 + scrollOffset * 0.05) % size.width);
      final y1 = ((i * 60) % size.height);
      
      canvas.drawCircle(Offset(x1, y1), 2, paint);
      
      // Connect to nearby particles
      for (int j = i + 1; j < 30 && j < i + 4; j++) {
        final x2 = ((j * 80 + scrollOffset * 0.05) % size.width);
        final y2 = ((j * 60) % size.height);
        
        final distance = math.sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        if (distance < 150) {
          paint.color = color.withOpacity((1 - distance / 150) * 0.5);
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Cursor Trail Painter
class CursorTrailPainter extends CustomPainter {
  final List<Offset> positions;
  final Color color;

  CursorTrailPainter({required this.positions, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < positions.length; i++) {
      final paint = Paint()
        .color = color.withOpacity((i + 1) / positions.length * 0.5)
        .strokeWidth = (i + 1) / positions.length * 3
        .strokeCap = StrokeCap.round;
      
      canvas.drawCircle(positions[i], (i + 1) / positions.length * 10, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
