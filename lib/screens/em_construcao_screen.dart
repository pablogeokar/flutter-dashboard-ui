import 'package:flutter/material.dart';
import '../theme/theme.dart';

class EmConstrucaoPlaceholder extends StatelessWidget {
  final String? titulo;
  final String? descricao;
  final List<String>? funcionalidades;

  const EmConstrucaoPlaceholder({
    super.key,
    this.titulo,
    this.descricao,
    this.funcionalidades,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: SingleChildScrollView(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          margin: EdgeInsets.all(AppTheme.spacingXL),
          padding: EdgeInsets.all(AppTheme.spacingXXL),
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppTheme.neutral800.withValues(
                    alpha: 0.4,
                  ) // Mais sutil no dark
                : AppTheme.neutral50.withValues(
                    alpha: 0.8,
                  ), // Mais sutil no light
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
            border: Border.all(
              color: isDarkMode
                  ? AppTheme.neutral600.withValues(alpha: 0.3)
                  : AppTheme.neutral300.withValues(alpha: 0.4),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode
                    ? Colors.black.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone profissional
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
                ),
                child: Icon(
                  Icons.engineering_rounded,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              SizedBox(height: AppTheme.spacingL),

              // Título principal
              Text(
                titulo ?? 'Funcionalidade em Desenvolvimento',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppTheme.spacingM),

              // Descrição
              Text(
                descricao ??
                    'Esta seção estará disponível em breve com funcionalidades avançadas para gestão fiscal.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Lista de funcionalidades futuras
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppTheme.spacingL),
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? AppTheme.neutral800.withValues(alpha: 0.3)
                      : AppTheme.neutral50,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
                  border: Border.all(
                    color: isDarkMode
                        ? AppTheme.neutral700
                        : AppTheme.neutral200,
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.upcoming_rounded,
                          size: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(width: AppTheme.spacingS),
                        Text(
                          'Funcionalidades Planejadas:',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppTheme.spacingM),

                    // Lista de funcionalidades
                    ...(funcionalidades ?? _getFuncionalidadesPadrao()).map(
                      (funcionalidade) => Padding(
                        padding: EdgeInsets.only(bottom: AppTheme.spacingS),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: AppTheme.successLight,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                            SizedBox(width: AppTheme.spacingM),
                            Expanded(
                              child: Text(
                                funcionalidade,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withValues(alpha: 0.8),
                                      height: 1.4,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: AppTheme.spacingXL),

              // Botão de notificação
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Você será notificado quando esta funcionalidade estiver disponível!',
                        ),
                        backgroundColor: AppTheme.successLight,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadiusM,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.notifications_outlined, size: 18),
                  label: Text(
                    'Notificar quando disponível',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingL,
                      vertical: AppTheme.spacingM,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusM,
                      ),
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: AppTheme.spacingL),

              // Informação adicional
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 16,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  SizedBox(width: AppTheme.spacingS),
                  Text(
                    'Previsão: Próximas atualizações',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getFuncionalidadesPadrao() {
    return [
      'Dashboard com métricas fiscais em tempo real',
      'Apuração automática de impostos (ICMS, IPI, PIS/COFINS)',
      'Geração de relatórios fiscais personalizados',
      'Integração com Receita Federal e SEFAZ',
      'Calendário fiscal com alertas automáticos',
      'Análise de compliance e indicadores de risco',
    ];
  }
}
