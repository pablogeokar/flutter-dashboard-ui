import 'package:flutter/material.dart';
import '../theme/theme.dart';
import '../widgets/src/forms/form_components.dart';

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
                ? AppTheme.neutral800.withValues(alpha: 0.3)
                : AppTheme.neutral100,
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusM),
            border: Border.all(
              color: isDarkMode
                  ? AppTheme.neutral600.withValues(alpha: 0.3)
                  : AppTheme.neutral300,
              width: 1,
            ),
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
      childAspectRatio: isLargeScreen ? 1.2 : 1.1,
      children: [
        _buildMetricCard(
          context,
          isDarkMode,
          title: 'Receita Mensal',
          value: 'R\$ 125.430,00',
          change: '+12%',
          changePositive: true,
          icon: Icons.trending_up_rounded,
          color: AppTheme.successLight,
        ),
        _buildMetricCard(
          context,
          isDarkMode,
          title: 'ICMS a Recolher',
          value: 'R\$ 8.750,00',
          change: 'Vence 15/12',
          changePositive: null,
          icon: Icons.gavel_rounded,
          color: AppTheme.warningLight,
        ),
        _buildMetricCard(
          context,
          isDarkMode,
          title: 'Documentos Pendentes',
          value: '23',
          change: '-5 hoje',
          changePositive: true,
          icon: Icons.assignment_late_rounded,
          color: AppTheme.errorLight,
        ),
        _buildMetricCard(
          context,
          isDarkMode,
          title: 'Compliance Score',
          value: '94%',
          change: '+2% mês',
          changePositive: true,
          icon: Icons.verified_rounded,
          color: AppTheme.successLight,
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
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.neutral800.withValues(alpha: 0.4)
            : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.neutral700.withValues(alpha: 0.3)
              : AppTheme.neutral200.withValues(alpha: 0.5),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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

          SizedBox(height: AppTheme.spacingM),

          Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: AppTheme.spacingS),

          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),

          SizedBox(height: AppTheme.spacingS),

          Text(
            change,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: changePositive == null
                  ? Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.6)
                  : changePositive
                  ? AppTheme.successLight
                  : AppTheme.errorLight,
              fontWeight: FontWeight.w600,
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
            ? AppTheme.neutral800.withValues(alpha: 0.4)
            : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.neutral700.withValues(alpha: 0.3)
              : AppTheme.neutral200.withValues(alpha: 0.5),
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
            ? AppTheme.neutral800.withValues(alpha: 0.4)
            : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.neutral700.withValues(alpha: 0.3)
              : AppTheme.neutral200.withValues(alpha: 0.5),
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

          ...activities
              .map(
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
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              activity['subtitle'] as String,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withValues(alpha: 0.6),
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
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildQuickActions(
    BuildContext context,
    bool isDarkMode,
    double screenWidth,
  ) {
    final isLargeScreen = screenWidth >= AppTheme.breakpointLarge;

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingL),
      decoration: BoxDecoration(
        color: isDarkMode
            ? AppTheme.neutral800.withValues(alpha: 0.4)
            : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusL),
        border: Border.all(
          color: isDarkMode
              ? AppTheme.neutral700.withValues(alpha: 0.3)
              : AppTheme.neutral200.withValues(alpha: 0.5),
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
              DomaniButton(
                text: 'Lançar Nota Fiscal',
                icon: Icons.receipt_rounded,
                type: DomaniButtonType.primary,
                onPressed: () {},
              ),
              DomaniButton(
                text: 'Gerar Relatório DRE',
                icon: Icons.trending_up_rounded,
                type: DomaniButtonType.secondary,
                onPressed: () {},
              ),
              DomaniButton(
                text: 'Consultar SPED',
                icon: Icons.description_rounded,
                type: DomaniButtonType.outline,
                onPressed: () {},
              ),
              DomaniButton(
                text: 'Agendar Backup',
                icon: Icons.backup_rounded,
                type: DomaniButtonType.outline,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
