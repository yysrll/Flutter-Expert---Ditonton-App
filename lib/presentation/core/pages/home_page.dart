import 'package:ditonton/presentation/core/pages/about_page.dart';
import 'package:ditonton/presentation/movie/pages/home_movie_page.dart';
import 'package:ditonton/presentation/movie/pages/search_page.dart';
import 'package:ditonton/presentation/core/pages/watchlist_page.dart';
import 'package:ditonton/presentation/tvseries/pages/home_tv_series_page.dart';
import 'package:ditonton/presentation/tvseries/pages/tvseries_search_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Widget title;
  final Widget content;
  final bool isMovies;

  const HomePage({
    Key? key,
    required this.content,
    required this.title,
    required this.isMovies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeMoviePage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.tv),
              title: Text('Tv Series'),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, HomeTVSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: title,
        actions: [
          IconButton(
            onPressed: () {
              if (isMovies) {
                Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
              } else {
                Navigator.pushNamed(context, TVSeriesSearchPage.ROUTE_NAME);
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: content,
    );
  }
}
