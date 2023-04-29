import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/blocs/search/search_tvseries_bloc.dart';
import '../widgets/tvseries_card_list.dart';
import 'package:flutter/material.dart';

class TVSeriesSearchPage extends StatelessWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/search-tvseries';
  const TVSeriesSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTVSeriesBloc>().add(OnQueryChange(query));
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTVSeriesBloc, SearchTVSeriesState>(
              builder: (context, state) {
                if (state is SearchTVSeriesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is SearchTVSeriesLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tvseries = state.tvSeriesList[index];
                        return TVSeriesCard(
                          tvSeries: tvseries,
                        );
                      },
                      itemCount: state.tvSeriesList.length,
                    ),
                  );
                } else if (state is SearchTVSeriesError) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is SearchTVSeriesEmpty) {
                  return const Center(
                    child: Text('Tidak ada data'),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
