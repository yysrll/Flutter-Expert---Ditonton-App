import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/tvseries/provider/popular_tvseries_notifier.dart';
import 'package:ditonton/presentation/tvseries/widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tvseries';
  const PopularTVSeriesPage({Key? key}) : super(key: key);

  @override
  State<PopularTVSeriesPage> createState() => _PopularTVSeriesPageState();
}

class _PopularTVSeriesPageState extends State<PopularTVSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<PopularTVSeriesNotifier>(context, listen: false)
            .fetchPopularTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTVSeriesNotifier>(
          builder: (context, data, child) {
            if (data.popularState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.popularState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvseries = data.popularTVSeries[index];
                  return TVSeriesCard(tvSeries: tvseries);
                },
                itemCount: data.popularTVSeries.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
