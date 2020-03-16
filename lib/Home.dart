import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtubeapp/telas/Biblioteca.dart';
import 'package:youtubeapp/telas/EmAlta.dart';
import 'package:youtubeapp/telas/Inicio.dart';
import 'package:youtubeapp/telas/Inscricao.dart';


import 'CustomSearchDelegate.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Indice de navegação da buttomBar
  int _indiceAtual = 0;
  String resultado = "";

  @override
  Widget build(BuildContext context) {
    //Lista de telas que serão chamada no buttonNavigator
    List<Widget> telas =[
      Inicio(resultado),
      EmAlta(),
      Inscricao(),
      Biblioteca(),
    ];

    return Scaffold(
      appBar: AppBar(
        //Cores padrão para os icones
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black54,
        title: Row(
          children: <Widget>[
            Image.asset("imagens/youtube.png",
              width: 150,
              height: 150,),
            Text("     By Rafael",
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],

        ),
        actions: <Widget>[
          //Icones com ações
        /*
        IconButton(
            iconSize: 30,
            icon: Icon(Icons.videocam),
            onPressed: (){

            },
          ),
          IconButton(
            iconSize: 30,
            icon: Icon(Icons.account_circle),
            onPressed: (){

            },
          )
          */
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () async{
            //Exibir barra de pesquisa
            String res = await showSearch( //Receber a query digitada
                context: context,
                delegate: CustomSearchDelegate());
            setState(() {
              resultado = res;
            });
          },
        )
        ],
      ),
      body:  Container(
        padding: EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      //Botão de navegação no rodaé
      bottomNavigationBar: BottomNavigationBar(
        //Cor fixa quando se usa ate 3 navigations bar
        //type: BottomNavigationBarType.fixed,
        //Cores dinamicas para cada um dos navigations
        type: BottomNavigationBarType.shifting,
        fixedColor: Colors.white,
        //Em qual item vai ser iniciado por padrão
        currentIndex: _indiceAtual,
        onTap: (indice){
          setState(() {
            _indiceAtual = indice;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.black87,
            title: Text("Início"),
            icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.red,
              title: Text("Em alta"),
              icon: Icon(Icons.whatshot),
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.blue,
              title: Text("Incrições"),
              icon: Icon(Icons.subscriptions)
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.green,
              title: Text("Biblioteca"),
              icon: Icon(Icons.folder)
          ),
        ],
      ),
    );
  }
}
