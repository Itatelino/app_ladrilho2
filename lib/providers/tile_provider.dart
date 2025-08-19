import 'package:app_ladrilho2/models/tile.dart';
import 'package:flutter/material.dart';
// Importa o modelo de desenho

// Provider para gerenciar o estado do pedido de ladrilhos
class TileOrderProvider extends ChangeNotifier {
  Tile? _selectedTile; // O ladrilho atualmente selecionado
  Color _baseTileColor =
      Colors.grey; // A cor atual da base do ladrilho (inicialmente cinza)
  Map<String, Color> _drawingColors =
      {}; // Mapeia o ID do desenho para sua cor personalizada
  double _tileWidth = 0.30; // Largura do ladrilho em metros (padrão 30cm)
  double _tileHeight = 0.30; // Altura do ladrilho em metros (padrão 30cm)
  double _totalAreaSqMeters =
      0.0; // Área total em metros quadrados que o usuário deseja cobrir
  int _calculatedQuantity = 0; // Quantidade de ladrilhos calculada

  // Getters para acessar as propriedades do estado
  Tile? get selectedTile => _selectedTile;
  Color get baseTileColor => _baseTileColor;
  Map<String, Color> get drawingColors => _drawingColors;
  double get tileWidth => _tileWidth;
  double get tileHeight => _tileHeight;
  double get totalAreaSqMeters => _totalAreaSqMeters;
  int get calculatedQuantity => _calculatedQuantity;

  // Seleciona um novo ladrilho e inicializa suas cores
  void selectTile(Tile tile) {
    _selectedTile = tile;
    _baseTileColor = tile
        .defaultBaseColor; // Define a cor base para a cor padrão do ladrilho selecionado
    _drawingColors = {}; // Limpa as cores de desenhos anteriores
    // Inicializa as cores de cada desenho com suas cores padrão
    for (var drawing in tile.drawings) {
      _drawingColors[drawing.id] = drawing.defaultColor;
    }
    notifyListeners(); // Notifica os ouvintes sobre a mudança de estado
  }

  // Atualiza a cor da base do ladrilho
  void updateBaseTileColor(Color newColor) {
    _baseTileColor = newColor;
    notifyListeners(); // Notifica os ouvintes
  }

  // Atualiza a cor de um desenho específico
  void updateDrawingColor(String drawingId, Color newColor) {
    if (_drawingColors.containsKey(drawingId)) {
      _drawingColors[drawingId] = newColor;
      notifyListeners(); // Notifica os ouvintes
    }
  }

  // Atualiza as dimensões do ladrilho e recalcula a quantidade
  void updateDimensions(double width, double height) {
    _tileWidth = width;
    _tileHeight = height;
    _calculateQuantity(); // Recalcula a quantidade
    notifyListeners(); // Notifica os ouvintes
  }

  // Atualiza a área total em metros quadrados e recalcula a quantidade
  void updateTotalArea(double area) {
    _totalAreaSqMeters = area;
    _calculateQuantity(); // Recalcula a quantidade
    notifyListeners(); // Notifica os ouvintes
  }

  // Método privado para calcular a quantidade de ladrilhos necessária
  void _calculateQuantity() {
    if (_tileWidth > 0 && _tileHeight > 0 && _totalAreaSqMeters > 0) {
      final double tileArea =
          _tileWidth * _tileHeight; // Área de um único ladrilho
      // Calcula a quantidade arredondando para cima para garantir que a área seja coberta
      _calculatedQuantity = (_totalAreaSqMeters / tileArea).ceil();
    } else {
      _calculatedQuantity =
          0; // Se os valores não forem válidos, a quantidade é 0
    }
  }

  // Reseta todas as propriedades do pedido para seus valores iniciais
  void resetOrder() {
    _selectedTile = null;
    _baseTileColor = Colors.grey;
    _drawingColors = {};
    _tileWidth = 0.30;
    _tileHeight = 0.30;
    _totalAreaSqMeters = 0.0;
    _calculatedQuantity = 0;
    notifyListeners(); // Notifica os ouvintes
  }
}
