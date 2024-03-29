import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/blocs/on_air/on_air_tvseries_bloc.dart';
import 'package:tvseries/presentation/blocs/popular/popular_tvseries_bloc.dart';
import 'package:tvseries/presentation/blocs/top_rated/top_rated_tvseries_bloc.dart';
import 'package:tvseries/presentation/pages/on_air_tvseries_page.dart';
import 'package:tvseries/presentation/pages/popular_tvseries_page.dart';
import 'package:tvseries/presentation/pages/top_rated_tvseries_page.dart';
import 'package:tvseries/presentation/pages/tvseries_detail_page.dart';
import 'package:flutter/material.dart';

class HomeTVSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/home-tv-series';

  const HomeTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeTVSeriesPage> createState() => _HomeTVSeriesPageState();
}

class _HomeTVSeriesPageState extends State<HomeTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<OnAirTVSeriesBloc>().add(const FetchOnAirTVSeries());
      context.read<PopularTVSeriesBloc>().add(const FetchPopularTVSeries());
      context.read<TopRatedTVSeriesBloc>().add(const FetchTopRatedTVSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return HomePage(
      title: const Text("Tv Series"),
      isMovies: false,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On Air',
                onTap: () =>
                    Navigator.pushNamed(context, OnAirTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<OnAirTVSeriesBloc, OnAirTVSeriesState>(
                  builder: (context, state) {
                if (state is OnAirTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OnAirTVSeriesLoaded) {
                  return TVSeriesList(state.tvSeries);
                } else if (state is OnAirTVSeriesError) {
                  return const Text('Failed');
                } else if (state is OnAirTVSeriesEmpty) {
                  return const Text('Tidak ada data');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                    context, PopularTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTVSeriesBloc, PopularTVSeriesState>(
                  builder: (context, state) {
                if (state is PopularTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTVSeriesLoaded) {
                  return TVSeriesList(state.tvSeries);
                } else if (state is PopularTVSeriesError) {
                  return const Text('Failed');
                } else if (state is PopularTVSeriesEmpty) {
                  return const Text('Tidak ada data');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, TopRatedTVSeriesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTVSeriesBloc, TopRatedTVSeriesState>(
                  builder: (context, state) {
                if (state is TopRatedTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTVSeriesLoaded) {
                  return TVSeriesList(state.tvSeries);
                } else if (state is TopRatedTVSeriesError) {
                  return const Text('Failed');
                } else if (state is TopRatedTVSeriesEmpty) {
                  return const Text('Tidak ada data');
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> series;

  const TVSeriesList(this.series, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvseries = series[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tvseries.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvseries.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: series.length,
      ),
    );
  }
}
