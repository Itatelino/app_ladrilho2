import 'package:app_ladrilho2/models/drawing.dart';
import 'package:app_ladrilho2/providers/tile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';

class TileCustomizationScreen extends StatefulWidget {
  const TileCustomizationScreen({super.key});

  @override
  State<TileCustomizationScreen> createState() =>
      _TileCustomizationScreenState();
}

class _TileCustomizationScreenState extends State<TileCustomizationScreen> {
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  String _message = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<TileOrderProvider>(context, listen: false);
      _widthController.text = provider.tileWidth.toStringAsFixed(2);
      _heightController.text = provider.tileHeight.toStringAsFixed(2);
      _areaController.text = provider.totalAreaSqMeters.toStringAsFixed(2);
    });
  }

  @override
  void dispose() {
    _widthController.dispose();
    _heightController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  Future<void> _launchWhatsApp(String message) async {
    const String phoneNumber = '5547912345678';
    final String url =
        'whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        setState(() {
          _message =
              'Não foi possível abrir o WhatsApp. Verifique se o aplicativo está instalado.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Erro ao tentar abrir o WhatsApp: $e';
      });
    }
  }

  // O restante do seu código _TileCustomizationScreenState permanece inalterado
  @override
  Widget build(BuildContext context) {
    // ... (restante do build)
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalizar Ladrilho'),
        centerTitle: true,
      ),
      body: Consumer<TileOrderProvider>(
        builder: (context, tileProvider, child) {
          if (tileProvider.selectedTile == null) {
            return const Center(child: Text('Nenhum ladrilho selecionado.'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Ladrilho Selecionado: ${tileProvider.selectedTile!.name}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black26),
                          ),
                          child: CustomPaint(
                            painter: TilePainter(
                              baseColor: tileProvider.baseTileColor,
                              drawings: tileProvider.selectedTile!.drawings,
                              drawingColors: tileProvider.drawingColors,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cor da Base do Ladrilho:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            _buildColorOption(
                              context,
                              Colors.red,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.green,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.blue,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.yellow,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.purple,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.black,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.white,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.grey,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.brown,
                              isBaseColor: true,
                            ),
                            _buildColorOption(
                              context,
                              Colors.teal,
                              isBaseColor: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (tileProvider.selectedTile!.drawings.isNotEmpty)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Personalizar Cores dos Desenhos:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ...tileProvider.selectedTile!.drawings.map((drawing) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Desenho: ${drawing.name}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Wrap(
                                    spacing: 8.0,
                                    runSpacing: 8.0,
                                    children: [
                                      _buildColorOption(
                                        context,
                                        Colors.red,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.green,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.blue,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.yellow,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.purple,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.black,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.white,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.grey,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.brown,
                                        drawingId: drawing.id,
                                      ),
                                      _buildColorOption(
                                        context,
                                        Colors.teal,
                                        drawingId: drawing.id,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Definir Dimensões do Ladrilho (em metros):',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _widthController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Largura (m)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.line_weight),
                          ),
                          onChanged: (value) {
                            try {
                              double width = double.parse(value);
                              tileProvider.updateDimensions(
                                width,
                                tileProvider.tileHeight,
                              );
                            } catch (e) {
                              // Ignora entradas inválidas
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Altura (m)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.height),
                          ),
                          onChanged: (value) {
                            try {
                              double height = double.parse(value);
                              tileProvider.updateDimensions(
                                tileProvider.tileWidth,
                                height,
                              );
                            } catch (e) {
                              // Ignora entradas inválidas
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Definir Área Total (m²):',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _areaController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Área Total (m²)',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.square_foot),
                          ),
                          onChanged: (value) {
                            try {
                              double area = double.parse(value);
                              tileProvider.updateTotalArea(area);
                            } catch (e) {
                              // Ignora entradas inválidas
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Quantidade Estimada de Ladrilhos: ${tileProvider.calculatedQuantity}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  onPressed: () {
                    if (tileProvider.selectedTile == null ||
                        tileProvider.calculatedQuantity == 0) {
                      setState(() {
                        _message =
                            'Por favor, selecione um ladrilho e defina as dimensões/área para calcular a quantidade.';
                      });
                      return;
                    }
                    String drawingColorsString = '';
                    if (tileProvider.selectedTile!.drawings.isNotEmpty) {
                      drawingColorsString += '\n*Cores dos Desenhos:*\n';
                      for (var drawing in tileProvider.selectedTile!.drawings) {
                        final color = tileProvider.drawingColors[drawing.id];
                        if (color != null) {
                          drawingColorsString +=
                              '  - ${drawing.name}: #${color.value.toRadixString(16).substring(2).toUpperCase()}\n';
                        }
                      }
                    }

                    final String orderMessage =
                        """
                    Olá, gostaria de fazer um pedido de ladrilhos com as seguintes especificações:

                    *Tipo de Ladrilho:* ${tileProvider.selectedTile!.name}
                    *Cor Base do Ladrilho (HEX):* #${tileProvider.baseTileColor.value.toRadixString(16).substring(2).toUpperCase()}
                    $drawingColorsString
                    *Dimensões do Ladrilho:* ${tileProvider.tileWidth.toStringAsFixed(2)}m x ${tileProvider.tileHeight.toStringAsFixed(2)}m
                    *Área Total Desejada:* ${tileProvider.totalAreaSqMeters.toStringAsFixed(2)}m²
                    *Quantidade Estimada:* ${tileProvider.calculatedQuantity} ladrilhos

                    Favor entrar em contato para confirmar os detalhes e o orçamento.
                    """;
                    _launchWhatsApp(orderMessage);
                  },
                  label: const Text('Enviar Pedido por WhatsApp'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                if (_message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _message,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildColorOption(
    BuildContext context,
    Color color, {
    String? drawingId,
    bool isBaseColor = false,
  }) {
    final tileProvider = Provider.of<TileOrderProvider>(context, listen: false);
    Color? activeColor;

    if (isBaseColor) {
      activeColor = tileProvider.baseTileColor;
    } else if (drawingId != null) {
      activeColor = tileProvider.drawingColors[drawingId];
    }

    return GestureDetector(
      onTap: () {
        if (isBaseColor) {
          tileProvider.updateBaseTileColor(color);
        } else if (drawingId != null) {
          tileProvider.updateDrawingColor(drawingId, color);
        }
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: activeColor == color
                ? Colors.blueAccent
                : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}

// A classe TilePainter foi movida para fora da classe State
class TilePainter extends CustomPainter {
  final Color baseColor;
  final List<Drawing> drawings;
  final Map<String, Color> drawingColors;

  TilePainter({
    required this.baseColor,
    required this.drawings,
    required this.drawingColors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint basePaint = Paint()..color = baseColor;
    canvas.drawRect(Offset.zero & size, basePaint);

    void drawDrawing(String type, Color color) {
      final Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      final Paint strokePaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      switch (type) {
        case 'border':
          canvas.drawRect(
            Rect.fromLTWH(0, 0, size.width, size.height),
            strokePaint,
          );
          break;
        case 'corner_top_left':
          final path = Path()
            ..moveTo(0, 0)
            ..lineTo(size.width * 0.4, 0)
            ..lineTo(0, size.height * 0.4)
            ..close();
          canvas.drawPath(path, paint);
          break;
        case 'corner_bottom_right':
          final path = Path()
            ..moveTo(size.width, size.height)
            ..lineTo(size.width * 0.6, size.height)
            ..lineTo(size.width, size.height * 0.6)
            ..close();
          canvas.drawPath(path, paint);
          break;
        case 'cross_lines':
          canvas.drawLine(
            Offset(0, 0),
            Offset(size.width, size.height),
            strokePaint,
          );
          canvas.drawLine(
            Offset(size.width, 0),
            Offset(0, size.height),
            strokePaint,
          );
          break;
        case 'center_circle':
          canvas.drawCircle(
            Offset(size.width / 2, size.height / 2),
            size.width * 0.3,
            paint,
          );
          break;
        case 'quarters':
          final halfWidth = size.width / 2;
          final halfHeight = size.height / 2;
          canvas.drawRect(Rect.fromLTWH(0, 0, halfWidth, halfHeight), paint);
          canvas.drawRect(
            Rect.fromLTWH(halfWidth, halfHeight, halfWidth, halfHeight),
            paint,
          );
          break;
        case 'irregular_border':
          final path = Path()
            ..moveTo(0, 0)
            ..lineTo(size.width, 0)
            ..lineTo(size.width * 0.9, size.height * 0.1)
            ..lineTo(size.width * 0.1, size.height * 0.9)
            ..lineTo(0, size.height)
            ..close();
          canvas.drawPath(path, strokePaint..strokeWidth = 5.0);
          break;
        case 'spiral':
          final center = Offset(size.width / 2, size.height / 2);
          final double maxRadius = size.width / 2 * 0.9;
          final int turns = 3;
          final double angleStep = 0.1;

          final spiralPath = Path();
          spiralPath.moveTo(center.dx, center.dy);

          for (double i = 0; i < turns * 2 * pi; i += angleStep) {
            final radius = maxRadius * (i / (turns * 2 * pi));
            final x = center.dx + radius * cos(i);
            final y = center.dy + radius * sin(i);
            spiralPath.lineTo(x, y);
          }
          canvas.drawPath(spiralPath, strokePaint..strokeWidth = 2.0);
          break;
        case 'dots':
          final double dotRadius = size.width * 0.03;
          final int numDotsX = 5;
          final int numDotsY = 5;
          for (int i = 0; i < numDotsX; i++) {
            for (int j = 0; j < numDotsY; j++) {
              final double x = size.width / (numDotsX + 1) * (i + 1);
              final double y = size.height / (numDotsY + 1) * (j + 1);
              canvas.drawCircle(Offset(x, y), dotRadius, paint);
            }
          }
          break;
        case 'fine_grid':
          final int numLines = 10;
          for (int i = 1; i < numLines; i++) {
            final double x = size.width / numLines * i;
            final double y = size.height / numLines * i;
            canvas.drawLine(Offset(x, 0), Offset(x, size.height), strokePaint);
            canvas.drawLine(Offset(0, y), Offset(size.width, y), strokePaint);
          }
          break;
        default:
          canvas.drawLine(
            Offset(0, 0),
            Offset(size.width, size.height),
            strokePaint,
          );
          canvas.drawLine(
            Offset(size.width, 0),
            Offset(0, size.height),
            strokePaint,
          );
          break;
      }
    }

    for (var drawing in drawings) {
      final Color? drawColor = drawingColors[drawing.id];
      if (drawColor != null) {
        drawDrawing(drawing.type, drawColor);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is TilePainter) {
      return oldDelegate.baseColor != baseColor ||
          oldDelegate.drawingColors != drawingColors;
    }
    return true;
  }
}
