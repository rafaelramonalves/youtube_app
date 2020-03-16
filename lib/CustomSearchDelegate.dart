import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String>{

  ///Nenhuma dos metodos podem retornar nulo

  //Ações que o usuário pode utilizar (widgets dentro da barra)
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          //Acessar o que está sendo digitado na barra
          query=""; //Limpar a query quando clicar no X
        },
      ),
    ];
  }

  //Define o botão de voltar
  @override
  Widget buildLeading(BuildContext context) {

    return
      IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          close(context,"");
        },
      );
  }

  //Constroi os resultados do que foi buscado
  @override
  Widget buildResults(BuildContext context) {
    close(context, query); // A pagina é fechada e a query é passada como
    // parâmetro
    return Container();
  }

  //Define as sugestões de pesquisa
  //O certo é usar uma API que traga o resultados.
  //Criando uma lista para demonstrar o resultado
  @override
  Widget buildSuggestions(BuildContext context) {

    List<String> lista = List();
    if(query.isNotEmpty){
      lista=[
        "Android",
        "ios",
        "Jogos"
        "Futebol"
      ].where(
              (texto) => texto.toLowerCase().startsWith(query.toLowerCase())
      ).toList(); //Pesquisa dentro da lista
      return ListView.builder(
        itemCount: lista.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(lista[index]),
            onTap: (){
              close(context, lista[index]);
          },
          );
        },
      );
    }else{
      return Center(
      //    child: Text("Nenhum resultado para a pesquida"),
      );
    }

  }

}