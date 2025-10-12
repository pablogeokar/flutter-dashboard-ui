import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/src/forms/button.dart';

/// Tela principal do dashboard com métricas fiscais
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      padding: EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header do dashboard
          _buildDashboardHeader(context, isDarkMode, screenWidth),

          SizedBox(height: AppTheme.spacingXL),

          // Cards de estatísticas
          _buildContainerCards(context, isDarkMode, screenWidth),

          // Cards de métricas principais
          _buildMetricsCards(context, isDarkMode, screenWidth),

          SizedBox(height: AppTheme.spacingXL),

          // Seção de gráficos e atividades
          _buildChartsAndActivities(context, isDarkMode, screenWidth),

          SizedBox(height: AppTheme.spacingXL),

          // Quick actions
          _buildQuickActions(context, isDarkMode, screenWidth),
        ],
      ),
    );
  }

  Widget _buildDashboardHeader(
    BuildContext context,
    bool isDarkMode,
    double screenWidth,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dashboard Fiscal',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: AppTheme.spacingS),
            Text(
              'Visão geral da situação fiscal da empresa',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
        // Filtro de período
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spacingM,
            vertical: AppTheme.spacingS,
          ),
          decoration: BoxDecoration(
            color: isDarkMode
                ? AppTheme.cardBackgroundDark
                : AppTheme.cardBackgroundLight,
            borderRadius: BorderRadius.circular(8),
            border: isDarkMode
                ? Border.all(color: AppTheme.cardBorderDark, width: 1)
                : Border.all(color: AppTheme.neutral300, width: 1),
            boxShadow: isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: AppTheme.cardShadowLight,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: AppTheme.spacingS),
              Text(
                'Dezembro 2024',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              SizedBox(width: AppTheme.spacingS),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsCards(
    BuildContext context,

    bool isDarkMode,

    double screenWidth,
  ) {
    final isLargeScreen = screenWidth >= AppTheme.breakpointLarge;

    return GridView.count(
      shrinkWrap: true,

      physics: const NeverScrollableScrollPhysics(),

      crossAxisCount: isLargeScreen ? 4 : 2,

      crossAxisSpacing: AppTheme.spacingL,

      mainAxisSpacing: AppTheme.spacingL,

      childAspectRatio: isLargeScreen ? 1.5 : 1.2, // Mais largos e menos altos

      children: [
        _buildMetricCard(
          context,

          isDarkMode,

          title: 'Receita Mensal',

          value: 'R\$ 125.430,00',

          change: '+12%',

          changePositive: true,

          icon: Icons.trending_up_rounded,

          type: 'success',
        ),

        _buildMetricCard(
          context,

          isDarkMode,

          title: 'ICMS a Recolher',

          value: 'R\$ 8.750,00',

          change: 'Vence 15/12',

          changePositive: null,

          icon: Icons.gavel_rounded,

          type: 'warning',
        ),

        _buildMetricCard(
          context,

          isDarkMode,

          title: 'Documentos Pendentes',

          value: '23',

          change: '-5 hoje',

          changePositive: true,

          icon: Icons.assignment_late_rounded,

          type: 'error',
        ),

        _buildMetricCard(
          context,

          isDarkMode,

          title: 'Compliance Score',

          value: '94%',

          change: '+2% mês',

          changePositive: true,

          icon: Icons.verified_rounded,

          type: 'success',
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,

    bool isDarkMode, {

    required String title,

    required String value,

    required String change,

    required bool? changePositive,

    required IconData icon,

    required String type,
  }) {
    final Color color;

    switch (type) {
      case 'success':
        color = isDarkMode ? AppTheme.successDark : AppTheme.successLight;

        break;

      case 'warning':
        color = isDarkMode ? AppTheme.warningDark : AppTheme.warningLight;

        break;

      case 'error':
        color = isDarkMode ? AppTheme.errorDark : AppTheme.errorLight;

        break;

      default:
        color = isDarkMode ? AppTheme.infoDark : AppTheme.infoLight;
    }

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),

      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardBackgroundDark
            : AppTheme.cardBackgroundLight,

        borderRadius: BorderRadius.circular(
          AppTheme.borderRadiusM,
        ), // Bordas mais suaves

        border: Border.all(
          color: isDarkMode
              ? AppTheme.cardBorderDark
              : AppTheme.neutral200, // Borda para ambos os temas

          width: 1,
        ),

        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: AppTheme.cardShadowLight,

                  blurRadius: 4,

                  offset: const Offset(0, 2),
                ),
              ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Distribui o conteúdo

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Container(
                padding: EdgeInsets.all(AppTheme.spacingS),

                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),

                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusS),
                ),

                child: Icon(icon, size: 20, color: color),
              ),

              if (changePositive != null)
                Icon(
                  changePositive
                      ? Icons.trending_up_rounded
                      : Icons.trending_down_rounded,

                  size: 16,

                  color: changePositive
                      ? AppTheme.successLight
                      : AppTheme.errorLight,
                ),
            ],
          ),

          // Título do card com hierarquia tipográfica
          Text(
            title,

            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: isDarkMode
                  ? AppTheme
                        .textSecondaryDark // #B0B0B0
                  : AppTheme.textSecondaryLight, // #666666

              fontWeight: FontWeight.w500,
            ),
          ),

          // Valor principal com destaque
          Text(
            value,

            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold, // font-weight: bold

              color: color,
            ),
          ),

          // Detalhes com tamanho menor
          Text(
            change,

            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: changePositive == null
                  ? (isDarkMode
                        ? AppTheme.textSecondaryDark
                        : AppTheme.textSecondaryLight)
                  : changePositive
                  ? AppTheme.successLight
                  : AppTheme.errorLight,

              fontWeight: FontWeight.w600,

              fontSize: 12, // font-size: smaller
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartsAndActivities(
    BuildContext context,
    bool isDarkMode,
    double screenWidth,
  ) {
    final isLargeScreen = screenWidth >= AppTheme.breakpointLarge;

    if (isLargeScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: _buildRevenueChart(context, isDarkMode)),
          SizedBox(width: AppTheme.spacingL),
          Expanded(child: _buildRecentActivities(context, isDarkMode)),
        ],
      );
    } else {
      return Column(
        children: [
          _buildRevenueChart(context, isDarkMode),
          SizedBox(height: AppTheme.spacingL),
          _buildRecentActivities(context, isDarkMode),
        ],
      );
    }
  }

  Widget _buildRevenueChart(BuildContext context, bool isDarkMode) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardBackgroundDark
            : AppTheme.cardBackgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: isDarkMode
            ? Border.all(color: AppTheme.cardBorderDark, width: 1)
            : null,
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: AppTheme.cardShadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Receitas vs Despesas',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Icon(
                Icons.more_horiz_rounded,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ],
          ),

          SizedBox(height: AppTheme.spacingL),

          // Placeholder para gráfico
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppTheme.neutral700.withValues(alpha: 0.3)
                  : AppTheme.neutral100.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bar_chart_rounded,
                    size: 48,
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: AppTheme.spacingM),
                  Text(
                    'Gráfico de Receitas vs Despesas',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingS),
                  Text(
                    'Implementação em desenvolvimento',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities(BuildContext context, bool isDarkMode) {
    final activities = [
      {
        'title': 'Nota Fiscal #1234 emitida',
        'subtitle': 'Cliente: João Silva',
        'time': '2 horas atrás',
        'icon': Icons.receipt_rounded,
        'color': AppTheme.successLight,
      },
      {
        'title': 'ICMS apurado - Dezembro',
        'subtitle': 'Valor: R\$ 8.750,00',
        'time': '4 horas atrás',
        'icon': Icons.calculate_rounded,
        'color': AppTheme.warningLight,
      },
      {
        'title': 'Backup automático realizado',
        'subtitle': 'Dados seguros',
        'time': '6 horas atrás',
        'icon': Icons.backup_rounded,
        'color': AppTheme.infoLight,
      },
      {
        'title': 'Relatório DRE gerado',
        'subtitle': 'Período: Nov/2024',
        'time': '1 dia atrás',
        'icon': Icons.trending_up_rounded,
        'color': AppTheme.successLight,
      },
    ];

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardBackgroundDark
            : AppTheme.cardBackgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: isDarkMode
            ? Border.all(color: AppTheme.cardBorderDark, width: 1)
            : null,
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: AppTheme.cardShadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Atividades Recentes',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              TextButton(onPressed: () {}, child: Text('Ver todas')),
            ],
          ),

          SizedBox(height: AppTheme.spacingL),

          ...activities.map(
            (activity) => Padding(
              padding: EdgeInsets.only(bottom: AppTheme.spacingM),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppTheme.spacingS),
                    decoration: BoxDecoration(
                      color: (activity['color'] as Color).withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusS,
                      ),
                    ),
                    child: Icon(
                      activity['icon'] as IconData,
                      size: 16,
                      color: activity['color'] as Color,
                    ),
                  ),

                  SizedBox(width: AppTheme.spacingM),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity['title'] as String,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          activity['subtitle'] as String,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                        ),
                      ],
                    ),
                  ),

                  Text(
                    activity['time'] as String,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    bool isDarkMode,
    double screenWidth,
  ) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.cardBackgroundDark
            : AppTheme.cardBackgroundLight,
        borderRadius: BorderRadius.circular(8),
        border: isDarkMode
            ? Border.all(color: AppTheme.cardBorderDark, width: 1)
            : null,
        boxShadow: isDarkMode
            ? null
            : [
                BoxShadow(
                  color: AppTheme.cardShadowLight,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ações Rápidas',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          SizedBox(height: AppTheme.spacingL),

          Wrap(
            spacing: AppTheme.spacingM,
            runSpacing: AppTheme.spacingM,
            children: [
              FormButton(
                text: 'Lançar Nota Fiscal',
                icon: Icons.receipt_rounded,
                variant: ButtonVariant.primary,
                onPressed: () {},
              ),
              FormButton(
                text: 'Gerar Relatório DRE',
                icon: Icons.trending_up_rounded,
                variant: ButtonVariant.secondary,
                onPressed: () {},
              ),
              FormButton(
                text: 'Consultar SPED',
                icon: Icons.description_rounded,
                variant: ButtonVariant.outline,
                onPressed: () {},
              ),
              FormButton(
                text: 'Agendar Backup',
                icon: Icons.backup_rounded,
                variant: ButtonVariant.outline,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainerCards(
    BuildContext context,
    bool isDarkMode,
    double screenWidth,
  ) {
    final isLargeScreen = screenWidth >= AppTheme.breakpointLarge;

    final List<Widget> cards = [
      _buildCard(
        context,
        title: 'Receita Mensal',
        value: 'R\$ 125.430,00',
        details: '+12%',
        detailsPositive: true,
        icon: Icons.trending_up_rounded,
        color: isDarkMode ? AppTheme.successDark : AppTheme.successLight,
      ),
      _buildCard(
        context,
        title: 'ICMS a Recolher',
        value: 'R\$ 8.750,00',
        details: 'Vence 15/12',
        detailsPositive: null,
        icon: Icons.gavel_rounded,
        color: isDarkMode ? AppTheme.warningDark : AppTheme.warningLight,
      ),
      _buildCard(
        context,
        title: 'Documentos Pendentes',
        value: '23',
        details: '-5 hoje',
        detailsPositive: false,
        icon: Icons.assignment_late_rounded,
        color: isDarkMode ? AppTheme.errorDark : AppTheme.errorLight,
      ),
      _buildCard(
        context,
        title: 'Compliance Score',
        value: '94%',
        details: '+2% mês',
        detailsPositive: true,
        icon: Icons.verified_rounded,
        color: isDarkMode ? AppTheme.infoDark : AppTheme.infoLight,
      ),
    ];

    if (isLargeScreen) {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: AppTheme.spacingL,
        mainAxisSpacing: AppTheme.spacingL,
        childAspectRatio: 2.2,
        children: cards,
      );
    } else {
      return Wrap(
        spacing: AppTheme.spacingM,
        runSpacing: AppTheme.spacingM,
        children: cards.map((card) {
          return Container(
            width: 280,
            height: 160,
            child: card,
          );
        }).toList(),
      );
    }
  }

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String value,
    required String details,
    required bool? detailsPositive,
    required IconData icon,
    required Color color,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color, color.withOpacity(0.7)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -20,
              child: Opacity(
                opacity: 0.2,
                child: Icon(icon, size: 100, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppTheme.spacingM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(icon, color: Colors.white, size: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      SizedBox(height: AppTheme.spacingXS),
                      Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppTheme.getResponsiveFontSize(
                                  screenWidth, 22),
                            ),
                      ),
                      SizedBox(height: AppTheme.spacingS),
                      Row(
                        children: [
                          if (detailsPositive != null)
                            Icon(
                              detailsPositive
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              size: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          if (detailsPositive != null)
                            SizedBox(width: AppTheme.spacingXS),
                          Text(
                            details,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
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
    );
  }
}