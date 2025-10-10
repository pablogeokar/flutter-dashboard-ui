import 'package:flutter/material.dart';
import '../screens/em_construcao_screen.dart';
import '../screens/dashboard_screen.dart';
import '../widgets/app_layout.dart';
import '../widgets/dialog.dart';

/// Configuração dos itens da barra de navegação lateral
class SidebarConfig {
  /// Cria a lista de itens principais do menu (reorganizada para contexto fiscal)
  static List<DrawerItem> getMainItems(BuildContext context) => [
    // Dashboard principal
    DrawerItem(
      title: 'Dashboard',
      icon: Icons.dashboard_rounded,
      screen: const DashboardScreen(),
    ),

    // Cadastros básicos
    DrawerItem(
      title: 'Cadastros',
      icon: Icons.edit_document,
      subItems: [
        DrawerItem(
          title: 'Clientes',
          icon: Icons.people_rounded,
          onDialogTap: DialogCallbacks.cadastroCliente(context),
        ),
        DrawerItem(
          title: 'Fornecedores',
          icon: Icons.business_rounded,
          onDialogTap: DialogCallbacks.cadastroFornecedor(context),
        ),
        DrawerItem(
          title: 'Produtos/Serviços',
          icon: Icons.inventory_2_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Cadastro de Produtos e Serviços',
            descricao:
                'Gestão completa do catálogo de produtos e serviços com informações fiscais.',
            funcionalidades: [
              'Cadastro com classificação fiscal (NCM/CEST)',
              'Configuração de tributação por produto',
              'Controle de estoque integrado',
              'Histórico de preços e custos',
              'Relatórios de movimentação',
            ],
          ),
        ),
        DrawerItem(
          title: 'Plano de Contas',
          icon: Icons.account_tree_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Plano de Contas',
            descricao:
                'Estrutura contábil organizada para classificação adequada das operações.',
            funcionalidades: [
              'Estrutura hierárquica de contas',
              'Classificação contábil automática',
              'Integração com DRE e Balanço',
              'Configuração de centros de custo',
              'Relatórios gerenciais personalizados',
            ],
          ),
        ),
      ],
    ),

    // Área fiscal específica
    DrawerItem(
      title: 'Fiscal',
      icon: Icons.gavel_rounded,
      subItems: [
        DrawerItem(
          title: 'Apuração ICMS',
          icon: Icons.calculate_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Apuração de ICMS',
            descricao:
                'Apuração automática do ICMS com base nas operações registradas.',
            funcionalidades: [
              'Cálculo automático de débitos e créditos',
              'Livro de apuração digital',
              'Controle de substituição tributária',
              'Relatórios de apuração detalhados',
              'Integração com SPED Fiscal',
            ],
          ),
        ),
        DrawerItem(
          title: 'SPED Fiscal',
          icon: Icons.description_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'SPED Fiscal',
            descricao:
                'Geração e validação dos arquivos do Sistema Público de Escrituração Digital.',
            funcionalidades: [
              'Geração automática do arquivo SPED',
              'Validação de consistência dos dados',
              'Controle de versões e reenvios',
              'Relatórios de divergências',
              'Integração com Receita Federal',
            ],
          ),
        ),
        DrawerItem(
          title: 'Declarações',
          icon: Icons.assignment_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Declarações Fiscais',
            descricao: 'Gestão de todas as declarações fiscais obrigatórias.',
            funcionalidades: [
              'Calendário de obrigações fiscais',
              'Geração automática de declarações',
              'Controle de protocolos e recibos',
              'Alertas de vencimentos',
              'Histórico de entregas',
            ],
          ),
        ),
        DrawerItem(
          title: 'Calendário Fiscal',
          icon: Icons.event_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Calendário Fiscal',
            descricao:
                'Acompanhamento de todas as obrigações fiscais com alertas automáticos.',
            funcionalidades: [
              'Calendário personalizado por regime',
              'Alertas automáticos de vencimentos',
              'Controle de cumprimento de obrigações',
              'Integração com agenda do sistema',
              'Relatórios de compliance',
            ],
          ),
        ),
      ],
    ),

    // Relatórios gerenciais
    DrawerItem(
      title: 'Relatórios',
      icon: Icons.analytics_rounded,
      subItems: [
        DrawerItem(
          title: 'Balancetes',
          icon: Icons.balance_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Balancetes',
            descricao:
                'Relatórios contábeis para acompanhamento da situação patrimonial.',
            funcionalidades: [
              'Balancete de verificação mensal',
              'Comparativos entre períodos',
              'Filtros por centro de custo',
              'Exportação para Excel/PDF',
              'Gráficos de evolução patrimonial',
            ],
          ),
        ),
        DrawerItem(
          title: 'DRE',
          icon: Icons.trending_up_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Demonstração do Resultado',
            descricao: 'Análise detalhada do resultado operacional da empresa.',
            funcionalidades: [
              'DRE gerencial e fiscal',
              'Comparativos mensais e anuais',
              'Análise de margem e rentabilidade',
              'Projeções e orçamentos',
              'Indicadores de performance',
            ],
          ),
        ),
        DrawerItem(
          title: 'Fluxo de Caixa',
          icon: Icons.account_balance_wallet_rounded,
          screen: const EmConstrucaoPlaceholder(
            titulo: 'Fluxo de Caixa',
            descricao:
                'Controle e projeção do fluxo de caixa para gestão financeira.',
            funcionalidades: [
              'Fluxo realizado vs projetado',
              'Categorização de entradas e saídas',
              'Projeções automáticas',
              'Alertas de liquidez',
              'Relatórios de movimentação',
            ],
          ),
        ),
      ],
    ),
  ];

  /// Cria a lista de itens inferiores (rodapé) do menu
  static List<DrawerItem> getFooterItems(BuildContext context) => [
    DrawerItem(
      title: 'Configurações',
      icon: Icons.settings_rounded,
      onDialogTap: DialogCallbacks.configuracoes(context),
    ),
    DrawerItem(
      title: 'Suporte',
      icon: Icons.help_outline_rounded,
      screen: const EmConstrucaoPlaceholder(
        titulo: 'Central de Suporte',
        descricao: 'Acesso rápido à documentação, tutoriais e suporte técnico.',
        funcionalidades: [
          'Base de conhecimento integrada',
          'Tutoriais em vídeo',
          'Chat de suporte em tempo real',
          'Tickets de atendimento',
          'FAQ sobre legislação fiscal',
          'Atualizações do sistema',
        ],
      ),
    ),
  ];
}
