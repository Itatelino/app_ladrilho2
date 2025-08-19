import 'package:app_ladrilho2/providers/tile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importa o pacote provider para gerenciamento de estado
import 'package:app_ladrilho2/screens/home_screen.dart';

// Importa a tela inicial do aplicativo
void main() {
  // Executa o aplicativo, envolvendo-o com o ChangeNotifierProvider
  // para disponibilizar o TileOrderProvider para toda a árvore de widgets.
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          TileOrderProvider(), // Cria uma instância do TileOrderProvider
      child: const MyApp(), // O widget raiz do seu aplicativo
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Ladrilhos por Encomenda', // Título do aplicativo
      theme: ThemeData(
        primarySwatch: Colors.blueGrey, // Tema de cores principal
        visualDensity: VisualDensity
            .adaptivePlatformDensity, // Densidade visual adaptativa
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey, // Cor de fundo da AppBar
          foregroundColor: Colors.white, // Cor do texto e ícones na AppBar
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8,
              ), // Borda arredondada para botões elevados
            ),
          ),
        ),
        cardTheme: CardThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              12,
            ), // Borda arredondada para cards
          ),
          elevation: 5, // Sombra para cards
        ),
      ),
      home: HomeScreen(), // A tela inicial do aplicativo
    );
  }
}
