import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  MovieHorizontal({required this.peliculas, required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          (_pageController.position.maxScrollExtent - 200.0)) {
        print('Cargar siguientes peliculas');
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * .3,
      // child: PageView(
      //   pageSnapping: false,
      //   controller: _pageController,
      //   children: _tarjetas(context),
      // ),
      child: PageView.builder(
        pageSnapping: false,
        itemBuilder: (context, i) {
          return _tarjeta(
            context,
            peliculas[i],
          );
        },
        itemCount: peliculas.length,
        controller: _pageController,
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Hero(
            tag: "${pelicula.uniqueId}",
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15), topLeft: Radius.circular(15)),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(
                  pelicula.getPosterImg(),
                ),
                fit: BoxFit.cover,
                height: 200.0,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            pelicula.title.toString(),
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula) {
  //     return _tarjeta(context, pelicula);
  //   }).toList();
  // }
}
