import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_manager.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashScreen({super.key, required this.onInitializationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _progressController;
  late AnimationController _textController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _progressValue;
  late Animation<double> _textOpacity;

  String _currentLoadingText = 'Inicializando...';
  final List<String> _loadingSteps = [
    'Inicializando...',
    'Carregando configurações...',
    'Preparando interface...',
    'Conectando serviços...',
    'Finalizando...',
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startInitialization();
  }

  void _initializeAnimations() {
    // Animação da logo
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Animação do progresso
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _progressValue = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // Animação do texto
    _textController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
  }

  Future<void> _startInitialization() async {
    // Inicia animação da logo
    _logoController.forward();

    await Future.delayed(const Duration(milliseconds: 800));

    // Inicia animação do texto
    _textController.forward();

    await Future.delayed(const Duration(milliseconds: 500));

    // Inicia progresso e simula carregamento
    _progressController.forward();

    // Simula etapas de carregamento
    for (int i = 0; i < _loadingSteps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) {
        setState(() {
          _currentLoadingText = _loadingSteps[i];
        });
      }
    }

    // Aguarda conclusão das animações
    await _progressController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // Chama callback de conclusão
    if (mounted) {
      widget.onInitializationComplete();
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _progressController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: isDarkMode
          ? const Color(0xFF1A1A1A)
          : const Color(0xFFF8FAFC),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [const Color(0xFF1A1A1A), const Color(0xFF2D3748)]
                : [const Color(0xFFF8FAFC), const Color(0xFFE2E8F0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Espaço superior
              const Spacer(flex: 2),

              // Logo animada
              AnimatedBuilder(
                animation: _logoController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _logoScale.value,
                    child: Opacity(
                      opacity: _logoOpacity.value,
                      child: _buildLogo(isDarkMode, screenSize),
                    ),
                  );
                },
              ),

              const SizedBox(height: 60),

              // Nome da empresa
              AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _textOpacity.value,
                    child: Column(
                      children: [
                        // Text(
                        //   'Domani Fiscal',
                        //   style: Theme.of(context).textTheme.headlineLarge
                        //       ?.copyWith(
                        //         fontWeight: FontWeight.w800,
                        //         color: isDarkMode
                        //             ? Colors.white
                        //             : const Color(0xFF1A202C),
                        //         letterSpacing: -0.5,
                        //       ),
                        // ),
                        // const SizedBox(height: 8),
                        Text(
                          'Sistema de Gestão Contábil',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: isDarkMode
                                    ? const Color(0xFFA0AEC0)
                                    : const Color(0xFF4A5568),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const Spacer(flex: 1),

              // Indicador de progresso
              AnimatedBuilder(
                animation: _progressController,
                builder: (context, child) {
                  return Column(
                    children: [
                      // Barra de progresso
                      Container(
                        width: screenSize.width * 0.6,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF2D3748)
                              : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressValue.value,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Texto de carregamento
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          _currentLoadingText,
                          key: ValueKey(_currentLoadingText),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isDarkMode
                                    ? const Color(0xFF9CA3AF)
                                    : const Color(0xFF6B7280),
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              const Spacer(flex: 2),

              // Rodapé
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Column(
                  children: [
                    Text(
                      'Versão 1.0.0',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDarkMode
                            ? const Color(0xFF718096)
                            : const Color(0xFF9CA3AF),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '© 2025 Domani Fiscal. Todos os direitos reservados.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: isDarkMode
                            ? const Color(0xFF4A5568)
                            : const Color(0xFFA0AEC0),
                        fontSize: 11,
                      ),
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

  Widget _buildLogo(bool isDarkMode, Size screenSize) {
    // Usa a mesma lógica da sidebar para determinar qual logo usar
    final themeManager = Provider.of<ThemeManager>(context, listen: false);
    final logoPath = themeManager.currentTheme == ThemeModeType.dark
        ? 'assets/logo_dark.png'
        : 'assets/logo_light.png';

    return Container(
      width: screenSize.width * 0.7,
      height: screenSize.width * 0.45,
      constraints: const BoxConstraints(
        minWidth: 280,
        minHeight: 180,
        maxWidth: 500,
        maxHeight: 320,
      ),
      child: Image.asset(
        logoPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback elegante caso a logo não seja encontrada
          return Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2D3748) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.account_balance,
                    size: screenSize.width * 0.1,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'DOMANI',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.055,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'FISCAL',
                  style: TextStyle(
                    fontSize: screenSize.width * 0.032,
                    fontWeight: FontWeight.w600,
                    color: isDarkMode
                        ? const Color(0xFFA0AEC0)
                        : const Color(0xFF4A5568),
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
