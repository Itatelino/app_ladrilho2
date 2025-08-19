import 'package:flutter/material.dart';

// Classe que representa um desenho ou "célula tracejante" dentro de um ladrilho.
class Drawing {
  final String id; // ID único para este desenho (usado para gerenciar a cor)
  final String
  name; // Nome descritivo do desenho (ex: "Contorno", "Círculo Central")
  final Color defaultColor; // Cor padrão para este desenho
  final String
  type; // Tipo de desenho (ex: 'border', 'cross_lines', 'center_circle')
  // Usado pelo CustomPainter para saber como desenhar.

  Drawing({
    required this.id,
    required this.name,
    required this.defaultColor,
    required this.type,
  });
}
