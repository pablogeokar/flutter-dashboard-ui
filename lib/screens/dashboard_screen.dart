import 'package:flutter/material.dart';
import 'package:dashboard_ui/widgets/form.dart';
import '../theme/theme.dart';
import 'package:dashboard_ui/widgets/cards.dart';

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
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header do dashboard
          _buildDashboardHeader(context, isDarkMode, screenWidth),

          const SizedBox(height: AppTheme.spacingXL),

          // Cards de estatísticas
          InfoCardGrid(
            children: [
              InfoCard(
                title: 'Receita Mensal',
                value: 'R\$ 125.430,00',
                details: '+12%',
                detailsPositive: true,
                icon: Icons.trending_up_rounded,
                color: isDarkMode
                    ? AppTheme.successDark
                    : AppTheme.successLight,
              ),
              InfoCard(
                title: 'ICMS a Recolher',
                value: 'R\$ 8.750,00',
                details: 'Vence 15/12',
                detailsPositive: null,
                icon: Icons.gavel_rounded,
                color: isDarkMode
                    ? AppTheme.warningDark
                    : AppTheme.warningLight,
              ),
              InfoCard(
                title: 'Documentos Pendentes',
                value: '23',
                details: '-5 hoje',
                detailsPositive: false,
                icon: Icons.assignment_late_rounded,
                color: isDarkMode ? AppTheme.errorDark : AppTheme.errorLight,
              ),
              InfoCard(
                title: 'Compliance Score',
                value: '94%',
                details: '+2% mês',
                detailsPositive: true,
                icon: Icons.verified_rounded,
                color: isDarkMode ? AppTheme.infoDark : AppTheme.infoLight,
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingXL),

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
}
