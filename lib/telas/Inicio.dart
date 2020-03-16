import 'package:flutter/material.dart';
import 'package:youtubeapp/Api.dart';
import 'package:youtubeapp/models/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';



class Inicio extends StatefulWidget {

  //construtor para passagem de parametro
  String pesquisa;
  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {


  _listarVideo(String pesquisa){


    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Video>>(
      future: _listarVideo(widget.pesquisa),
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
                      return GestureDetector(
                        onTap: (){
                          FlutterYoutube.playYoutubeVideoById(
                              apiKey: CHAVE_YOUTUBE_API,
                              videoId: video.id,
                              autoPlay: true,
                              fullScreen: true);
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  //Como a imagem vai se comportar dentro da box
                                  // no caso vai preencher ele todo
                                    fit: BoxFit.cover,
                                    image: NetworkImage(video.imagem)
                                ),
                              ),
                            ),
                            ListTile(
                              title:  Text(video.titulo),
                              subtitle: Text(video.descricao),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>Divider(
                  height: 6,
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

