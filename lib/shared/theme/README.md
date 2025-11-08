# Guia de Uso - Sistema de Temas com ScreenUtil

## 📱 Responsividade com ScreenUtil

### Inicialização

O ScreenUtil já está configurado no `app_widget.dart` com:

- **Design base:** 375x812 (baseado em iPhone X/11/12/13/14)
- **minTextAdapt:** true (textos sempre legíveis)
- **splitScreenMode:** true (suporte a tablets e split-screen)

### Extensões Disponíveis

```dart
// ===== TAMANHOS =====
.w    // Largura responsiva (width)
.h    // Altura responsiva (height)
.r    // Border radius responsivo (radius)
.sp   // Tamanho de fonte responsivo (scale pixel)

// ===== EXEMPLOS =====
SizedBox(width: 16.w, height: 24.h)
BorderRadius.circular(12.r)
Text('Olá', style: TextStyle(fontSize: 16.sp))
Padding(padding: EdgeInsets.all(16.w))
```

---

## 🎨 Como Usar os Estilos

### 1️⃣ Cores

```dart
import 'package:todo_list_app/shared/theme/app_colors.dart';

// Cores do tema atual (adapta automaticamente ao light/dark)
Container(
  color: Theme.of(context).colorScheme.primary,
  child: Text(
    'Texto',
    style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
  ),
)

// Cores estáticas (específicas para light ou dark)
Container(color: AppColors.primaryLight)  // Light mode
Container(color: AppColors.primaryDark)   // Dark mode

// Cores semânticas (mesmas em ambos os temas)
Container(color: AppColors.success)   // Verde
Container(color: AppColors.error)     // Vermelho
Container(color: AppColors.warning)   // Laranja
Container(color: AppColors.info)      // Azul
```

### 2️⃣ Textos

```dart
import 'package:todo_list_app/shared/theme/app_text_styles.dart';

// Hierarquia de textos
Text('Título Principal', style: AppTextStyles.headlineLarge)      // H1
Text('Subtítulo', style: AppTextStyles.headlineMedium)            // H2
Text('Título de Seção', style: AppTextStyles.headlineSmall)      // H3

Text('Título de Lista', style: AppTextStyles.titleLarge)         // H4
Text('Título de Item', style: AppTextStyles.titleMedium)         // H5
Text('Título Pequeno', style: AppTextStyles.titleSmall)          // H6

Text('Parágrafo grande', style: AppTextStyles.bodyLarge)
Text('Parágrafo médio', style: AppTextStyles.bodyMedium)
Text('Parágrafo pequeno', style: AppTextStyles.bodySmall)

Text('Label grande', style: AppTextStyles.labelLarge)
Text('Label médio', style: AppTextStyles.labelMedium)
Text('Label pequeno', style: AppTextStyles.labelSmall)

// Estilos customizados para To-Do App
Text('Tarefa', style: AppTextStyles.taskTitle)
Text('Descrição', style: AppTextStyles.taskDescription)
Text('15/11/2025', style: AppTextStyles.taskDateTime)
Text('PENDENTE', style: AppTextStyles.statusBadge)
```

### 3️⃣ Modificando Estilos

```dart
// Copiar e modificar um estilo
Text(
  'Texto vermelho',
  style: AppTextStyles.bodyMedium.copyWith(
    color: AppColors.error,
    fontWeight: FontWeight.bold,
  ),
)

// Usar estilo do tema atual
Text(
  'Texto do tema',
  style: Theme.of(context).textTheme.bodyMedium,
)
```

### 4️⃣ Componentes (usam o tema automaticamente)

```dart
// Botões
ElevatedButton(
  onPressed: () {},
  child: Text('Salvar'),  // Já usa AppTextStyles.buttonMedium
)

OutlinedButton(
  onPressed: () {},
  child: Text('Cancelar'),
)

TextButton(
  onPressed: () {},
  child: Text('Mais informações'),
)

// Cards
Card(
  child: Padding(
    padding: EdgeInsets.all(16.w),
    child: Text('Conteúdo do card'),
  ),
)

// Inputs
TextField(
  decoration: InputDecoration(
    labelText: 'Nome',
    hintText: 'Digite seu nome...',
    prefixIcon: Icon(Icons.person),
  ),
)

// Chips
Chip(
  label: Text('Categoria'),
  avatar: Icon(Icons.folder),
)

// Dialogs
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    title: Text('Confirmar'),  // Usa AppTextStyles.headlineSmall
    content: Text('Deseja continuar?'),  // Usa AppTextStyles.bodyMedium
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Cancelar'),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text('Confirmar'),
      ),
    ],
  ),
)

// SnackBars
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Tarefa salva com sucesso!'),
    action: SnackBarAction(
      label: 'Desfazer',
      onPressed: () {},
    ),
  ),
)
```

---

## 🌙 Dark Mode

### O tema atual segue o sistema operacional automaticamente!

Para detectar qual tema está ativo:

```dart
bool isDark = Theme.of(context).brightness == Brightness.dark;

if (isDark) {
  // Código específico para dark mode
} else {
  // Código específico para light mode
}
```

Para alterar o comportamento, edite `app_widget.dart`:

```dart
MaterialApp(
  themeMode: ThemeMode.system,  // Segue o sistema (padrão)
  // themeMode: ThemeMode.light, // Sempre light
  // themeMode: ThemeMode.dark,  // Sempre dark
)
```

---

## 🎯 Exemplos Práticos

### Card de Tarefa Completo

```dart
Card(
  child: Padding(
    padding: EdgeInsets.all(16.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho
        Row(
          children: [
            Icon(Icons.circle, color: AppColors.pending, size: 12.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Título da tarefa',
                style: AppTextStyles.taskTitle,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Descrição
        Text(
          'Descrição detalhada da tarefa a ser realizada.',
          style: AppTextStyles.taskDescription,
        ),
        SizedBox(height: 12.h),

        // Rodapé
        Row(
          children: [
            Icon(Icons.calendar_today, size: 14.sp, color: AppColors.info),
            SizedBox(width: 4.w),
            Text(
              '15/11/2025 - 14:30',
              style: AppTextStyles.taskDateTime.copyWith(color: AppColors.info),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColors.pending.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'PENDENTE',
                style: AppTextStyles.statusBadge.copyWith(
                  color: AppColors.pending,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
)
```

### Badge de Status

```dart
Widget _buildStatusBadge(String status) {
  Color color;
  switch (status) {
    case 'completa':
      color = AppColors.success;
      break;
    case 'atrasada':
      color = AppColors.error;
      break;
    default:
      color = AppColors.pending;
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(4.r),
    ),
    child: Text(
      status.toUpperCase(),
      style: AppTextStyles.statusBadge.copyWith(color: color),
    ),
  );
}
```

---

## 📐 Valores de Responsividade Recomendados

```dart
// Espaçamentos
SizedBox(height: 4.h)   // Extra small
SizedBox(height: 8.h)   // Small
SizedBox(height: 16.h)  // Medium
SizedBox(height: 24.h)  // Large
SizedBox(height: 32.h)  // Extra large
SizedBox(height: 48.h)  // Extra extra large

// Padding
EdgeInsets.all(8.w)     // Small
EdgeInsets.all(16.w)    // Medium (padrão)
EdgeInsets.all(24.w)    // Large

// Border Radius
BorderRadius.circular(4.r)   // Pequeno
BorderRadius.circular(8.r)   // Médio
BorderRadius.circular(12.r)  // Grande (padrão)
BorderRadius.circular(16.r)  // Extra grande
BorderRadius.circular(24.r)  // Muito grande

// Ícones
Icon(Icons.add, size: 16.sp)  // Pequeno
Icon(Icons.add, size: 20.sp)  // Médio
Icon(Icons.add, size: 24.sp)  // Grande (padrão)
Icon(Icons.add, size: 32.sp)  // Extra grande
```

---

## 🚀 Dicas Finais

1. **Sempre use .w, .h, .r, .sp** para garantir responsividade
2. **Prefira usar Theme.of(context)** para cores que devem adaptar ao tema
3. **Use AppColors** diretamente para cores semânticas (success, error, etc.)
4. **Use AppTextStyles** para manter consistência de tipografia
5. **Todos os componentes padrão já usam o tema** automaticamente
6. **Para testar dark mode:** mude as configurações do sistema operacional

---

## 📦 Estrutura de Arquivos

```
lib/
  shared/
    theme/
      app_colors.dart              # Todas as cores (light/dark)
      app_text_styles.dart         # Todos os estilos de texto
      app_theme.dart               # Orquestrador dos temas
      widgets/                     # Temas modulares por componente
        app_bar_theme.dart         # AppBar
        button_themes.dart         # Elevated, Outlined, Text, FAB
        card_theme.dart            # Card
        checkbox_switch_theme.dart # Checkbox e Switch
        chip_theme.dart            # Chip
        dialog_theme.dart          # Dialog e BottomSheet
        input_theme.dart           # TextField, TextFormField
        other_themes.dart          # Divider, SnackBar, Icon
        typography_theme.dart      # TextTheme (Typography)
```

### 🎯 Arquitetura Modular

O sistema de temas foi organizado de forma modular para facilitar a manutenção:

- **`app_theme.dart`**: Arquivo principal que importa e orquestra todos os temas
- **`widgets/`**: Cada componente tem seu próprio arquivo de tema
- **Benefícios**:
  - Fácil localização e edição
  - Código mais limpo e organizado
  - Menor chance de conflitos em equipe
  - Melhor performance de IDE

---

## 🎨 Paleta de Cores

### Light Mode

- **Primary:** #6366F1 (Índigo)
- **Secondary:** #8B5CF6 (Roxo)
- **Background:** #F9FAFB (Cinza claro)
- **Surface:** #FFFFFF (Branco)

### Dark Mode

- **Primary:** #818CF8 (Índigo claro)
- **Secondary:** #A78BFA (Roxo claro)
- **Background:** #111827 (Cinza escuro)
- **Surface:** #1F2937 (Cinza médio)

### Semânticas

- **Success:** #10B981 (Verde)
- **Warning:** #F59E0B (Laranja)
- **Error:** #EF4444 (Vermelho)
- **Info:** #3B82F6 (Azul)
