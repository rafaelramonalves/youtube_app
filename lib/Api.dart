import 'package:http/http.dart' as http;
import 'dart:convert';

import 'models/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyBzGH3JSOmH6y72LMOEZn-_tMMEwj_ll6U";
const ID_CANAL = "UCQ5w3fSomzziZfO7neK7eAg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api{
  Future<List<Video>>  pesquisar(String pesquisa) async{

    http.Response response = await http.get(
      URL_BASE + "search"
        //Primeiro parâmetro usa o "?" e nos seguintes "&"
          "?part=snippet"
          "&type=video"
          "&maxResults=20"
          "&order=date"
          "&key=$CHAVE_YOUTUBE_API"
          //"&channelId=$ID_CANAL" --> Trazer video especificos de um canal
          "&q=$pesquisa"

    );
    if(response.statusCode==200){
      Map<String, dynamic>  dadosJson = json.decode(response.body);

      ///Uma das formas de se pegar a lista de video
      /*
      for( var video in dadosJson["items"]){
        print("Resultado: " + video.toString());
      }*/

      ///Segunda for ( e mais fácil) de fazer
      List<Video> videos = dadosJson["items"].map<Video>(
        //Percorre todo o dadosJson e retorna um map de videos
          (map){
                //Metódo criado na classe Video para fazer a conversão
              return Video.fromJason(map);
          }
      ).toList();

      return videos;
    }else{
        print("Código de erro: ${response.statusCode}");
    }

  }
}