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