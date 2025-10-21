import 'package:flutter/material.dart';

class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

// Categorias pré-definidas
class AppCategories {
  static const List<Category> all = [
    Category(
      id: 'work',
      name: 'Trabalho',
      icon: Icons.work,
      color: Color(0xFF2196F3), // Azul
    ),
    Category(
      id: 'personal',
      name: 'Pessoal',
      icon: Icons.person,
      color: Color(0xFF4CAF50), // Verde
    ),
    Category(
      id: 'shopping',
      name: 'Compras',
      icon: Icons.shopping_cart,
      color: Color(0xFFFF9800), // Laranja
    ),
    Category(
      id: 'health',
      name: 'Saúde',
      icon: Icons.favorite,
      color: Color(0xFFE91E63), // Rosa
    ),
    Category(
      id: 'study',
      name: 'Estudos',
      icon: Icons.school,
      color: Color(0xFF9C27B0), // Roxo
    ),
    Category(
      id: 'home',
      name: 'Casa',
      icon: Icons.home,
      color: Color(0xFF795548), // Marrom
    ),
    Category(
      id: 'finance',
      name: 'Finanças',
      icon: Icons.attach_money,
      color: Color(0xFF4CAF50), // Verde
    ),
    Category(
      id: 'other',
      name: 'Outros',
      icon: Icons.more_horiz,
      color: Color(0xFF9E9E9E), // Cinza
    ),
  ];

  static Category? getById(String? id) {
    if (id == null) return null;
    try {
      return all.firstWhere((cat) => cat.id == id);
    } catch (e) {
      return null;
    }
  }

  static Category getByIdOrDefault(String? id) {
    return getById(id) ?? all.last; // Retorna "Outros" como padrão
  }
}
