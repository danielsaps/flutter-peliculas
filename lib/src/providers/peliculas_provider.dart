import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  String _apiKey = '209af391e492cca9a053691e6afb0463';
  String _url = 'api.themoviedb.org';
  String _languaje = 'es-ES';
  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = [];

  final _popularesSteamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesSteamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesSteamController.stream;

  void disposeStrams() {
    // _popularesSteam?.close();
    _popularesSteamController.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    // print(decodeData['results']);
    final peliculas = new Peliculas.fromJson(decodeData['results']);
    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _languaje,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;
    _popularesPage++;
    print('getPopulares');
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apiKey,
      'language': _languaje,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);
    popularesSink(_populares);
    _cargando = false;
    return resp;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '/3/movie/$peliId/credits', {
      'api_key': _apiKey,
      'language': _languaje,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    print(decodeData['cast']);
    final cast = new Cast.fromJson(decodeData['cast']);

    return cast.actores;
  }

  Future<List<Pelicula>> buscarPelicula(String query) async {
    final url = Uri.https(_url, '/3/search/movie', {
      'api_key': _apiKey,
      'language': _languaje,
      'query': query,
    });

    return await _procesarRespuesta(url);
  }
}
