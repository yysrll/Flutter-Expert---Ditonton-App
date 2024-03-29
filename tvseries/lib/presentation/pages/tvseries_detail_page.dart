import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tvseries.dart';
import 'package:core/domain/entities/tvseries_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/blocs/detail/tvseries_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/detail-tvseries';

  final int id;
  const TVSeriesDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TVSeriesDetailBloc>()
        ..add(FetchTVSeriesDetail(widget.id))
        ..add(FetchWatchListStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TVSeriesDetailBloc, TVSeriesDetailState>(
        listener: (context, state) {
          final message = state.watchlistMessage;
          final scaffold = ScaffoldMessenger.of(context);

          if (message == TVSeriesDetailBloc.watchlistAddSuccessMessage ||
              message == TVSeriesDetailBloc.watchlistRemoveSuccessMessage) {
            scaffold.showSnackBar(SnackBar(content: Text(message)));
          } else {
            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(message),
                  );
                });
          }
        },
        listenWhen: (previous, current) {
          return previous.watchlistMessage != current.watchlistMessage &&
              current.watchlistMessage != '';
        },
        builder: (context, state) {
          if (state.state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == RequestState.Loaded) {
            return SafeArea(
              child: TVSeriesDetailContent(
                tvSeries: state.tvSeriesDetail!,
                recommendations: state.tvSeriesRecommendation,
                isAddedWatchlist: state.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(state.message);
          }
        },
      ),
    );
  }
}

class TVSeriesDetailContent extends StatelessWidget {
  final TVSeriesDetail tvSeries;
  final List<TVSeries> recommendations;
  final bool isAddedWatchlist;
  const TVSeriesDetailContent({
    Key? key,
    required this.tvSeries,
    required this.isAddedWatchlist,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final bloc = context.read<TVSeriesDetailBloc>();
                                if (!isAddedWatchlist) {
                                  bloc.add(AddWatchlistTVSeries(tvSeries));
                                } else {
                                  bloc.add(RemoveWatchlistTVSeries(tvSeries));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? const Icon(Icons.check)
                                      : const Icon(Icons.add),
                                  const Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = tvSeries.seasons[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: season.posterPath != null
                                                ? 'https://image.tmdb.org/t/p/w500${season.posterPath}'
                                                : 'https://i.ibb.co/TWLKGMY/No-Image-Available.jpg',
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        Positioned(
                                          left: 4,
                                          right: 4,
                                          bottom: 4,
                                          child: Container(
                                            color: const Color.fromARGB(
                                                145, 49, 49, 49),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Text(
                                                season.name,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: tvSeries.seasons.length,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVSeriesDetailBloc,
                                TVSeriesDetailState>(
                              builder: (context, state) {
                                if (state.tvSeriesRecommendationState ==
                                    RequestState.Loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.tvSeriesRecommendationState ==
                                    RequestState.Error) {
                                  return Text(state.message);
                                } else if (state.tvSeriesRecommendationState ==
                                    RequestState.Loaded) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvseries = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvseries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: tvseries.posterPath !=
                                                        null
                                                    ? 'https://image.tmdb.org/t/p/w500${tvseries.posterPath}'
                                                    : 'https://i.ibb.co/TWLKGMY/No-Image-Available.jpg',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
