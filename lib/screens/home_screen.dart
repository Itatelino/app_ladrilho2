import 'package:app_ladrilho2/models/drawing.dart';
import 'package:app_ladrilho2/models/tile.dart';
import 'package:app_ladrilho2/providers/tile_provider.dart';
import 'package:app_ladrilho2/screens/tile_customization_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Importa a tela de personalização

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Lista de ladrilhos de exemplo para seleção
  // Agora cada ladrilho pode ter uma lista de 'drawings'
  final List<Tile> sampleTiles = [
    Tile(
      id: '1',
      name: 'Ladrilho Clássico',
      defaultBaseColor: const Color(0xFFA0522D), // SaddleBrown
      imageUrl: 'https://placehold.co/100x100/A0522D/ffffff?text=Clássico',
      drawings: [
        Drawing(
          id: 'd1_borda',
          name: 'Contorno',
          defaultColor: Colors.black,
          type: 'border',
        ),
        Drawing(
          id: 'd1_canto_tl',
          name: 'Canto Superior Esquerdo',
          defaultColor: Colors.amber,
          type: 'corner_top_left',
        ),
        Drawing(
          id: 'd1_canto_br',
          name: 'Canto Inferior Direito',
          defaultColor: Colors.white,
          type: 'corner_bottom_right',
        ),
      ],
    ),
    Tile(
      id: '2',
      name: 'Ladrilho Moderno',
      defaultBaseColor: const Color(0xFF708090), // SlateGray
      imageUrl: 'https://placehold.co/100x100/708090/ffffff?text=Moderno',
      drawings: [
        Drawing(
          id: 'd2_cruz',
          name: 'Linhas Cruzadas',
          defaultColor: Colors.white,
          type: 'cross_lines',
        ),
      ],
    ),
    Tile(
      id: '3',
      name: 'Ladrilho Geométrico',
      defaultBaseColor: const Color(0xFF008080), // Teal
      imageUrl: 'https://placehold.co/100x100/008080/ffffff?text=Geométrico',
      drawings: [
        Drawing(
          id: 'd3_circulo',
          name: 'Círculo Central',
          defaultColor: Colors.yellow,
          type: 'center_circle',
        ),
        Drawing(
          id: 'd3_quadrantes',
          name: 'Quadrantes',
          defaultColor: Colors.lightGreen,
          type: 'quarters',
        ),
      ],
    ),
    Tile(
      id: '4',
      name: 'Ladrilho Rústico',
      defaultBaseColor: const Color(0xFFFFA500), // Orange
      imageUrl: 'https://placehold.co/100x100/FFA500/ffffff?text=Rústico',
      drawings: [
        Drawing(
          id: 'd4_borda_irreg',
          name: 'Borda Irregular',
          defaultColor: Colors.deepOrange,
          type: 'irregular_border',
        ),
      ],
    ),
    Tile(
      id: '5',
      name: 'Ladrilho Artístico',
      defaultBaseColor: const Color(0xFF8A2BE2), // BlueViolet
      imageUrl: 'https://placehold.co/100x100/8A2BE2/ffffff?text=Artístico',
      drawings: [
        Drawing(
          id: 'd5_espiral',
          name: 'Espiral',
          defaultColor: Colors.pinkAccent,
          type: 'spiral',
        ),
        Drawing(
          id: 'd5_pontos',
          name: 'Pontos Aleatórios',
          // ignore: deprecated_member_use
          defaultColor: Colors.white.withOpacity(0.7),
          type: 'dots',
        ),
      ],
    ),
    Tile(
      id: '6',
      name: 'Ladrilho Urbano',
      defaultBaseColor: const Color(0xFF424242), // Grey800
      imageUrl: 'https://placehold.co/100x100/424242/ffffff?text=Urbano',
      drawings: [
        Drawing(
          id: 'd6_grade',
          name: 'Grade Fina',
          defaultColor: Colors.white30,
          type: 'fine_grid',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Acessa o TileOrderProvider sem escutar mudanças (listen: false)
    // porque este widget apenas dispara ações, não reconstrói com base nelas.
    final tileProvider = Provider.of<TileOrderProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione Seu Ladrilho'), // Título da AppBar
        centerTitle: true, // Centraliza o título
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ), // Preenchimento em torno do conteúdo
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinha os filhos ao início
          children: [
            const Text(
              'Escolha o tipo de ladrilho que você deseja personalizar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Espaçamento vertical
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 itens por linha
                  crossAxisSpacing:
                      16.0, // Espaçamento horizontal entre os itens
                  mainAxisSpacing: 16.0, // Espaçamento vertical entre os itens
                  childAspectRatio:
                      0.8, // Proporção da largura para a altura de cada item
                ),
                itemCount: sampleTiles.length, // Número de itens na grade
                itemBuilder: (context, index) {
                  final tile = sampleTiles[index]; // Ladrilho atual
                  return GestureDetector(
                    onTap: () {
                      tileProvider.selectTile(
                        tile,
                      ); // Seleciona o ladrilho no provider
                      // Navega para a tela de personalização
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TileCustomizationScreen(),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5, // Elevação do card (sombra)
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ), // Borda arredondada do card
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Centraliza o conteúdo da coluna
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // Borda arredondada para a imagem
                            child: Image.network(
                              tile.imageUrl, // URL da imagem do ladrilho
                              width: 100,
                              height: 100,
                              fit: BoxFit
                                  .cover, // Ajusta a imagem para cobrir a área
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    // Widget exibido em caso de erro no carregamento da imagem
                                    width: 100,
                                    height: 100,
                                    // ignore: deprecated_member_use
                                    color: tile.defaultBaseColor.withOpacity(
                                      0.5,
                                    ), // Cor de fundo alternativa
                                    child: const Icon(
                                      Icons.broken_image,
                                      color: Colors.white,
                                      size: 50,
                                    ), // Ícone de imagem quebrada
                                  ),
                            ),
                          ),
                          const SizedBox(height: 10), // Espaçamento vertical
                          Text(
                            tile.name, // Nome do ladrilho
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, // Centraliza o texto
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
