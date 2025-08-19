import 'package:app_ladrilho2/models/drawing.dart';
import 'package:flutter/material.dart';
// Importa o novo modelo de desenho

// Classe que representa um tipo de ladrilho
class Tile {
  final String id; // ID único do ladrilho
  final String name; // Nome do ladrilho
  final Color defaultBaseColor; // Cor padrão da base do ladrilho (renomeado)
  final String imageUrl; // URL da imagem do ladrilho (usada como placeholder)
  final List<Drawing>
  drawings; // Lista de desenhos/células tracejantes no ladrilho

  Tile({
    required this.id,
    required this.name,
    required this.defaultBaseColor,
    required this.imageUrl,
    this.drawings = const [], // Lista de desenhos, padrão para vazio
  });
}
