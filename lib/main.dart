import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: false, primarySwatch: Colors.amber),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String escolhabotImg = '';
  String resultado = '';
  int vitorias = 0;
  int derrotas = 0;
  int empates = 0;
  final Random rng = Random();
  final String srcPedra =
      'https://cdn.leroymerlin.com.br/products/pedra_galaxy_calcaria_37x66cm_revestimentos_naturais_92151213_80b2_600x600.png';
  final String srcPapel =
      'https://images.tcdn.com.br/img/img_prod/834319/papel_de_seda_50x70_100_unidades_273_1_ac410df50fdeae4e3f7c47129653c96f.png';
  final String srcTesoura =
      'https://images.tcdn.com.br/img/img_prod/1220230/tesoura_esc_class_basic_13cm_3443_1_7c4e109c2464d4748756ea93f8b41742.jpg';

  void interpretarJogada(String jogada) {
    int escolhaBot = rng.nextInt(3); //0= pedra 1=papel 2=tesoura
    String escolhaBotImg;
    String escolhaBotStr;

    switch (escolhaBot) {
      case 0:
        escolhaBotImg = srcPedra;
        escolhaBotStr = 'Pedra';
        break;
      case 1:
        escolhaBotImg = srcPapel;
        escolhaBotStr = 'Papel';
        break;
      case 2:
        escolhaBotImg = srcTesoura;
        escolhaBotStr = 'Tesoura';
        break;
      default:
        escolhaBotImg = '';
        escolhaBotStr = '';
    }

    String resultadoJogo = determinarResultado(jogada, escolhaBotStr);

    setState(() {
      this.escolhabotImg = escolhaBotImg;
      this.resultado = resultadoJogo;
      if (resultadoJogo == 'Você ganhou!') {
        vitorias++;
      } else if (resultadoJogo == 'Você perdeu!') {
        derrotas++;
      } else {
        empates++;
      }
      ;
    });

    print('Jogador escolheu: $jogada');
    print('Bot escolheu: $escolhaBotStr');
    print('Resultado: $resultado');
  }

  String determinarResultado(String jogadaJogador, String jogadaBot) {
    if (jogadaJogador == jogadaBot) {
      return 'Empate!';
    }
    if ((jogadaJogador == 'Pedra' && jogadaBot == 'Tesoura') ||
        (jogadaJogador == 'Papel' && jogadaBot == 'Pedra') ||
        (jogadaJogador == 'Tesoura' && jogadaBot == 'Papel')) {
      return 'Você ganhou!';
    }
    return 'Você perdeu!';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Jokempo'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => interpretarJogada('Pedra'),
                  child: Container(
                    color: Colors.green,
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    child: Image.network(srcPedra),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => interpretarJogada('Papel'),
                  child: Container(
                    color: Colors.green,
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    child: Image.network(srcPapel),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => interpretarJogada('Tesoura'),
                  child: Container(
                    color: Colors.green,
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.all(5),
                    child: Image.network(srcTesoura),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            color: Colors.green,
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(5),
            child: Center(
              child: escolhabotImg.isNotEmpty
                  ? Image.network(escolhabotImg)
                  : Text('Escolha do computador'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            resultado,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text('Vitórias: $vitorias'),
                  Text('Empates: $empates'),
                  Text('Derrotas: $derrotas')
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
