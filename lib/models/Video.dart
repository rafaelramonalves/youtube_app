class Video{
  String id;
  String titulo;
  String descricao;
  String imagem;
  String canal;

  //O {} diz que os itens são opcionais
  Video({this.id, this.titulo, this.descricao, this.imagem, this.canal});

  ///O problema é resolvido mas é pouco otimizado, a
  ///cada novo vídeo uma nova instância é chamada
  /*
  static converterJson(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["videoId"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],
    );
  }
  */
  //Fazer a conversão que será usada na API
  //A diferença do factory para o static é que no factory
  // o retorno vai ser de um único objeto com todos os objetos
 factory Video.fromJason(Map<String, dynamic> json){
    return Video(
      id: json["id"]["videoId"],
      titulo: json["snippet"]["title"],
      descricao: json["snippet"]["description"],
      imagem: json["snippet"]["thumbnails"]["high"]["url"],
      canal: json["snippet"]["channelId"],
    );
  }
}