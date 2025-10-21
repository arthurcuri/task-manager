import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/task_list_screen.dart';

void main() {
  // Inicializa o sqflite para plataformas desktop (Linux, Windows, macOS)
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager Pro',
      debugShowCheckedModeBanner: false,

      // Localizações necessárias para DatePicker
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'), // Português Brasil
        Locale('en', 'US'), // Inglês
      ],
      locale: const Locale('pt', 'BR'), // Idioma padrão

      // Tema Claro - MELHORADO COM CONTRASTE
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEC407A), // Rosa mais legível
          brightness: Brightness.light,
          primary: const Color(0xFFEC407A), // Rosa vibrante
          secondary: const Color(0xFFF48FB1), // Rosa claro
          error: const Color(0xFFD32F2F), // Vermelho erro
        ),
        useMaterial3: true,
        
        // Padronização de Cards
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        
        // Padronização de Inputs
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFFEC407A), width: 2),
          ),
          filled: true,
          fillColor: Colors.grey.shade50,
          contentPadding: const EdgeInsets.all(16),
        ),
        
        // Padronização de Botões
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(48, 48), // Tamanho mínimo de toque
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        // Padronização de TextButtons
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 48), // Tamanho mínimo de toque
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        
        // Tipografia padronizada
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ),

      // Tema Escuro - MELHORADO COM CONTRASTE
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF48FB1), // Rosa claro para dark
          brightness: Brightness.dark,
          primary: const Color(0xFFF48FB1), // Rosa claro
          secondary: const Color(0xFFEC407A), // Rosa escuro
          surface: const Color(0xFF1E1E1E),
          error: const Color(0xFFEF5350),
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF121212),
        
        // Cards no dark mode
        cardTheme: const CardThemeData(
          elevation: 4,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Color(0xFF1E1E1E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
        ),
        
        // Inputs no dark mode
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFF424242)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFF424242)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFFF48FB1), width: 2),
          ),
          filled: true,
          fillColor: Color(0xFF2C2C2C),
          contentPadding: EdgeInsets.all(16),
        ),
        
        // Botões no dark mode
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
        ),
        
        // Tipografia dark mode
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          displaySmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),

      // Tema controlado pelo toggle
      themeMode: _themeMode,

      home: TaskListScreen(onThemeChanged: _toggleTheme, currentThemeMode: _themeMode),
    );
  }
}
