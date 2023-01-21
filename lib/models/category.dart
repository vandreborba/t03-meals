import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category(
      // const -> As propriedades da classe não podem ser alterados depois de criado.
      {required this.id,
      required this.title,
      this.color = Colors.orange}); // "{" é para argumentos nominais.
}
