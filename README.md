# Task Manager

<div align="center">
  <img src="https://www.pucminas.br/institucional/PublishingImages/Paginas/brasao/brasao-pucminas-versao-2025.png" height="60" />
  <img src="https://sbbd.org.br/2023/wp-content/uploads/sites/16/2023/08/assinatura_icei_COR_2023-edited.jpg" height="60" />
</div>

**Laboratório de Desenvolvimento de Aplicações Móveis e Distribuídas**  
**Instituto de Ciências Exatas e Informática (ICEI) - PUC Minas**

---

## Demonstração em Vídeo

<div align="center">
  <img src="entregaveis/demo.gif" alt="Demonstração do Aplicativo" width="300" />
  <p><em>Coloque aqui o GIF de demonstração do aplicativo</em></p>
</div>

---

## Descrição

Aplicativo de gerenciamento de tarefas desenvolvido em Flutter com interface moderna seguindo Material Design 3, banco de dados SQLite local, sistema de categorias, datas de vencimento, filtros avançados e tema claro/escuro. Projeto desenvolvido como atividade prática para o Laboratório de Desenvolvimento de Aplicações Móveis e Distribuídas na PUC Minas.

---

## Arquitetura

O sistema é estruturado em camadas:

- **Models** (`lib/models/`): Camada de dados - Task, Category
- **Services** (`lib/services/`): Lógica de negócio e persistência - DatabaseService (SQLite)
- **Screens** (`lib/screens/`): Camada de apresentação - TaskListScreen, TaskFormScreen
- **Widgets** (`lib/widgets/`): Componentes reutilizáveis - TaskCard

---

## Tecnologias Utilizadas

- **Flutter SDK** 3.35.5
- **Material Design 3** - Interface moderna e adaptativa
- **SQLite** (sqflite_common_ffi) - Persistência local
- **Intl** - Formatação de datas
- **flutter_slidable** - Gestos de deslizar
- **flutter_staggered_animations** - Animações avançadas
- **animations** - Transições suaves

---

## Estrutura de Diretórios

```
lib/
├── main.dart
├── models/
│   ├── task.dart
│   └── category.dart
├── services/
│   └── database_service.dart
├── screens/
│   ├── task_list_screen.dart
│   └── task_form_screen.dart
└── widgets/
    └── task_card.dart
```

---

## Como Executar

### Pré-requisitos

```bash
# Verificar instalação do Flutter
flutter doctor

# Sistema Linux requer:
sudo apt-get update
sudo apt-get install libsqlite3-dev
```

### Instalação

```bash
# Navegar para o diretório do projeto
cd task_manager

# Instalar dependências
flutter pub get

# Executar no Linux
flutter run -d linux

# Executar em outros dispositivos
flutter devices  # Ver dispositivos disponíveis
flutter run -d <device-id>
```

### Verificações

```bash
# Análise estática do código
dart analyze

# Verificar formatação
dart format lib/

# Build para produção
flutter build linux --release
```

---

## Funcionalidades Principais

### Gerenciamento de Tarefas
- Criar, editar, deletar e marcar como completa
- Validação de formulários com feedback
- Persistência em banco SQLite local
- Checkbox para conclusão rápida

### Categorias
- 8 categorias predefinidas com cores e ícones:
  - Trabalho (azul)
  - Pessoal (verde)
  - Compras (laranja)
  - Saúde (vermelho)
  - Estudos (roxo)
  - Casa (castanho)
  - Finanças (verde escuro)
  - Outros (cinza)
- Filtro por categoria
- Badge colorido nos cards

### Prioridades
- 4 níveis: Baixa (verde), Média (laranja), Alta (vermelho), Urgente (roxo)
- Ícones distintos e bordas coloridas
- Ordenação por prioridade

### Datas de Vencimento
- DatePicker integrado ao formulário
- Alerta visual "VENCIDA" em vermelho
- Filtro de tarefas vencidas
- Ordenação por data de vencimento
- Badge com ícone de aviso

### Busca e Filtros
- Busca em tempo real (título e descrição)
- Filtros: Todas, Pendentes, Concluídas, Vencidas
- Filtro por categoria com ícones
- Indicador visual de filtros ativos

### Estatísticas
- Card gradiente no topo
- Métricas: Total, Pendentes, Concluídas
- Atualização em tempo real
- Ícones ilustrativos

### Tema Claro/Escuro
- Toggle no AppBar
- Paleta rosa (#EC407A / #F48FB1)
- Adaptação automática de todos componentes
- Ícone dinâmico (sol/lua)

### Animações e Gestos
- Entrada sequencial dos cards (staggered)
- Transições suaves entre telas
- Pull-to-refresh
- Gestos de deslizar (slidable)
- Loading states

---

## Telas Principais

### TaskListScreen (Tela Principal)
- AppBar com título "Minhas Tarefas"
- Menus: Filtros, Ordenação, Categorias, Tema
- Barra de busca
- Card de estatísticas gradiente
- Lista animada de tarefas
- FAB "Nova Tarefa"
- Estados vazios personalizados

### TaskFormScreen (Formulário)
- Modo criação: "Nova Tarefa"
- Modo edição: "Editar Tarefa"
- Campos: Título*, Descrição, Prioridade, Status, Data, Categoria
- Validação em tempo real
- Botões: Salvar (rosa), Cancelar

### TaskCard (Widget Reutilizável)
- Checkbox de conclusão
- Título e descrição
- Badges: Categoria, Prioridade, Data de Vencimento, Data de Criação
- Borda colorida (prioridade/categoria)
- Alerta visual para tarefas vencidas
- Botão deletar com confirmação
- Gestos de deslizar

---

## Banco de Dados

### Implementação SQLite

**Tabela: tasks**
```sql
CREATE TABLE tasks (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT,
  completed INTEGER DEFAULT 0,
  priority TEXT DEFAULT 'medium',
  createdAt TEXT NOT NULL,
  dueDate TEXT,
  category TEXT
)
```

**Migrações:**
- Versão 1: Estrutura básica (id, title, description, completed, priority, createdAt)
- Versão 2: Adição de dueDate e category

**Operações:**
- `create()` — Inserir tarefa
- `readAll()` — Listar todas
- `update()` — Atualizar tarefa
- `delete()` — Remover tarefa
- Singleton pattern para instância única

---

## Relatório Técnico - Laboratório 2: Interface Profissional

### 1. Implementações Realizadas

**Funcionalidades Obrigatórias (100%):**
- Tela de formulário separada com navegação
- CRUD completo de tarefas
- Validação de campos (título obrigatório, mín. 3 caracteres)
- Dropdown de prioridade com 4 níveis e ícones coloridos
- Switch de status completo com feedback visual
- Cards customizados seguindo Material Design 3
- Filtros (todas/pendentes/concluídas)
- Card de estatísticas com gradiente rosa
- Estados vazios contextuais por filtro
- Pull-to-refresh funcional
- SnackBars de feedback (criar/atualizar/deletar/erro)
- Dialog de confirmação para exclusão

**Componentes Material Design 3:**
- `Scaffold` com AppBar customizado
- `FloatingActionButton.extended` com ícone e texto
- `Card` com elevation e bordas arredondadas
- `TextFormField` com outline border e validação
- `DropdownButtonFormField` com menu items customizados
- `SwitchListTile` com ícone e subtitle dinâmico
- `PopupMenuButton` para filtros e menus contextuais
- `RefreshIndicator` para pull-to-refresh
- `AlertDialog` para confirmações
- `SnackBar` para feedback temporário
- `CircularProgressIndicator` para loading states
- `InkWell` para efeitos de ripple

**Funcionalidades EXTRAS (Exercícios 1 e 2):**
- **Sistema de Categorias Completo:**
  - 8 categorias com cores, ícones e nomes únicos
  - Dropdown no formulário com preview visual
  - Filtro por categoria no AppBar
  - Badge colorido nos cards
  - Borda do card na cor da categoria

- **Sistema de Datas de Vencimento:**
  - DatePicker integrado (até 1 ano à frente)
  - Badge de data com formatação dd/MM/yyyy
  - Detecção automática de tarefas vencidas
  - Alerta "VENCIDA" em vermelho com ícone de aviso
  - Filtro especial para tarefas vencidas
  - Ordenação por data de vencimento
  - Destaque visual (borda vermelha grossa, elevation 6)

**Melhorias Adicionais (Customizações):**
- **Busca em Tempo Real:** Barra de busca no topo, case-insensitive, busca em título e descrição
- **Ordenação Múltipla:** 4 opções (data, prioridade, título, data de vencimento)
- **Tema Claro/Escuro:** Toggle no AppBar, paleta rosa consistente, adaptação completa
- **Animações Avançadas:** Flutter Staggered Animations com entrada sequencial (375ms)
- **Gestos de Deslizar:** Flutter Slidable para editar/deletar com swipe

---

### 2. Desafios Encontrados

**Desafio 1: Migração de Banco de Dados**
- **Problema:** Adicionar colunas `dueDate` e `category` em banco existente sem perder dados
- **Solução:** Implementação do método `_onUpgrade()` no DatabaseService para migração incremental:
  ```dart
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE tasks ADD COLUMN dueDate TEXT');
      await db.execute('ALTER TABLE tasks ADD COLUMN category TEXT');
    }
  }
  ```

**Desafio 2: Detecção de Tarefas Vencidas**
- **Problema:** Comparar data de vencimento com data atual considerando tarefas completas
- **Solução:** Método `_isOverdue()` no TaskCard:
  ```dart
  bool _isOverdue() {
    if (task.completed) return false;
    if (task.dueDate == null) return false;
    return task.dueDate!.isBefore(DateTime.now());
  }
  ```

**Desafio 3: Filtros Múltiplos Simultâneos**
- **Problema:** Combinar filtro de status + categoria + busca + ordenação
- **Solução:** Getter `_filteredTasks` com pipeline de filtros:
  1. Filtro por status (completed/pending/overdue/all)
  2. Filtro por categoria (se selecionada)
  3. Filtro por busca (se não vazio)
  4. Ordenação (date/priority/title/dueDate)

**Desafio 4: Parâmetro Deprecated**
- **Problema:** `DropdownButtonFormField` usava `value` (deprecated no Flutter 3.33+)
- **Solução:** Substituição por `initialValue` conforme nova API:
  ```dart
  DropdownButtonFormField<String>(
    initialValue: _category, // Antes: value: _category
    // ...
  )
  ```

**Desafio 5: Cores no Tema Escuro**
- **Problema:** Cores de prioridade/categoria ficavam sem contraste no tema escuro
- **Solução:** Uso de `withValues(alpha: 0.15)` para backgrounds e `withValues(alpha: 0.5)` para bordas, criando contraste adequado em ambos os temas

---

### 3. Melhorias Implementadas

**Além do Roteiro Básico:**

1. **Sistema de Categorias (Exercício 2 Completo):**
   - Modelo `Category` com classe dedicada
   - `AppCategories.all` com lista estática de 8 categorias
   - Helpers `getById()` e `getByIdOrDefault()`
   - Integração completa com formulário, cards e filtros

2. **Sistema de Datas de Vencimento (Exercício 1 Completo):**
   - Campo opcional `DateTime? dueDate` no modelo
   - DatePicker com restrições (DateTime.now até +365 dias)
   - Badge de data com formatação `dd/MM/yyyy`
   - Alerta "VENCIDA" com ícone de warning
   - Filtro especial no menu (ícone de aviso vermelho)

3. **Busca Inteligente (Customização 2):**
   - Campo de busca sempre visível
   - Busca simultânea em título e descrição
   - Ignora maiúsculas/minúsculas
   - Botão de limpar busca quando ativo
   - Atualização em tempo real (`onChanged`)

4. **Ordenação Avançada (Customização 3):**
   - Menu dedicado no AppBar (ícone sort)
   - 4 critérios de ordenação:
     * Data de criação (mais recente primeiro)
     * Prioridade (urgente → baixa)
     * Título (ordem alfabética)
     * Data de vencimento (próximas primeiro, nulls no final)

5. **Tema Claro/Escuro (Customização 1):**
   - `ThemeMode` gerenciado via StatefulWidget no main
   - Toggle no AppBar com ícone dinâmico
   - Paleta rosa consistente em ambos os temas
   - `ColorScheme.fromSeed` para cores harmônicas

6. **Animações Profissionais:**
   - `flutter_staggered_animations` para entrada dos cards
   - `SlideAnimation` (50px vertical) + `FadeInAnimation`
   - Duração de 375ms com `Curves.easeOut`
   - Efeito cascata baseado em `position` do item

7. **Gestos Avançados:**
   - `flutter_slidable` nos cards
   - Ação de editar (azul) ao deslizar para direita
   - Ação de deletar (vermelho) ao deslizar para esquerda
   - Feedback tátil e visual

**Customizações de UX:**
- Estados vazios específicos por filtro (4 mensagens diferentes)
- Ícone de filtro muda de cor quando ativo
- Card de estatísticas só aparece quando há tarefas
- Borda do card mais grossa (3px) em tarefas vencidas
- Elevation aumentada (6) para destacar tarefas vencidas
- Contador de caracteres nos campos (100 para título, 500 para descrição)

---

### 4. Aprendizados

**Principais Conceitos:**

1. **Arquitetura em Camadas:**
   - Separação clara: Models → Services → Screens → Widgets
   - Singleton pattern no DatabaseService
   - Injeção de dependências via construtores

2. **Gerenciamento de Estado:**
   - `StatefulWidget` para state local
   - Callback functions para comunicação pai-filho
   - `setState()` com verificação de `mounted`
   - Passagem de dados entre telas via `Navigator`

3. **Persistência de Dados:**
   - SQLite com `sqflite_common_ffi`
   - Migrações de schema (`onUpgrade`)
   - CRUD completo com async/await
   - Serialização JSON (toMap/fromMap)

4. **Validação de Formulários:**
   - `GlobalKey<FormState>` para controlar Form
   - `validator` em TextFormField
   - Mensagens de erro contextuais
   - `trim()` para remover espaços

5. **Material Design 3:**
   - `useMaterial3: true`
   - `ColorScheme.fromSeed` para paleta harmônica
   - Componentes adaptativos ao tema
   - Elevation, shapes e bordas arredondadas

6. **Navegação:**
   - `Navigator.push()` com `MaterialPageRoute`
   - `Navigator.pop()` com valor de retorno
   - Atualização da lista ao retornar

7. **Tratamento de Erros:**
   - Try-catch em operações assíncronas
   - SnackBar para feedback de erro
   - Verificação `mounted` antes de setState
   - Finally para limpar loading states

---

### 5. Próximos Passos

**Funcionalidades Planejadas:**

1. **Notificações Locais:**
   - Integrar `flutter_local_notifications`
   - Agendar notificação na data/hora de vencimento
   - Cancelar ao completar tarefa
   - Configurações de lembrete (15min, 1h, 1 dia antes)

2. **Compartilhamento:**
   - Adicionar `share_plus`
   - Botão de compartilhar no TaskCard
   - Formatar texto com detalhes da tarefa
   - Compartilhar via WhatsApp, Email, etc.

3. **Backup/Restore:**
   - Exportar todas as tarefas para JSON
   - Salvar em Downloads via `path_provider`
   - Botão de importar JSON
   - Validação de schema e merge com dados existentes

4. **Melhorias de Performance:**
   - Lazy loading na lista (virtual scrolling)
   - Debounce na busca (300ms)
   - Cache de queries frequentes
   - Otimização de rebuilds com `const`

5. **Recursos Avançados:**
   - Subtarefas (checklist dentro da tarefa)
   - Anexos (fotos, links)
   - Tags personalizadas pelo usuário
   - Sincronização em nuvem (Firebase)
   - Modo offline-first
   - Gráficos de produtividade

6. **Acessibilidade:**
   - Screen reader support (Semantics)
   - Tamanho de fonte ajustável
   - Alto contraste
   - Navegação por teclado

---

## Screenshots

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-45-17.png" alt="Tela Principal - Lista de Tarefas" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-45-22.png" alt="Seleção de Categoria" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-45-34.png" alt="Formulário de Nova Tarefa" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-45-46.png" alt="DatePicker - Seleção de Data" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-45-51.png" alt="Tarefa com Data de Vencimento" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-49-29.png" alt="Menu de Filtros" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-49-52.png" alt="Filtro de Tarefas Vencidas" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-50-11.png" alt="Menu de Ordenação" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-50-16.png" alt="Lista Ordenada" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-50-56.png" alt="Diálogo de Exclusão" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-51-22.png" alt="Modo Escuro" width="300" />
</div>

<div align="center">
  <img src="entregaveis/screenshots/Captura de tela de 2025-10-21 00-51-37.png" alt="Lista Vazia" width="300" />
</div>

---

## Créditos

Desenvolvido por **Arthur Kramberger** para PUC Minas — ICEI  
Disciplina: Laboratório de Desenvolvimento de Aplicações Móveis e Distribuídas  
Professor: [Nome do Professor]

---

## Referências

- [Roteiro da Aula](Aula.md)
- [Flutter Documentation](https://docs.flutter.dev/)
- [Material Design 3](https://m3.material.io/)
- [SQLite in Flutter](https://docs.flutter.dev/cookbook/persistence/sqlite)
- [Navigation Cookbook](https://docs.flutter.dev/cookbook/navigation)
- [Form Validation](https://docs.flutter.dev/cookbook/forms/validation)

---

## Licença

Este projeto foi desenvolvido para fins educacionais como parte do curso de Engenharia de Software da PUC Minas.
