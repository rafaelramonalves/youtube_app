import 'package:flutter/material.dart';
import 'package:youtubeapp/Api.dart';
import 'package:youtubeapp/models/Video.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {

  _listarVideo(){


    Api api = Api();
    return api.pesquisar("");
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listarVideo(),
      builder: (context,snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if(snapshot.hasData){
              //Define um separador entre os itens
                return ListView.separated(
                    itemBuilder: (context, index){
                      //A lista de video
                      List<Video> videos = snapshot.data;
                      //Um único video da lista
                      Video video = videos[index];
                      return Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                //Como a imagem vai se comportar dentro da box
                                // no caso vai preencher ele todo
                                fit: BoxFit.cover,
                                image: NetworkImage(video.imagem)
                              )
                            ),
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>Divider(
                  height: 2,
                  color: Colors.red,
                ),
                    itemCount: snapshot.data.length);
            }else{
               return Center(
                 child: Text("Nenhum dado a ser exibido"),
               );
            }
            break;
        }
       return null;
      },
    );
  }
}

