import 'package:ditonton/presentation/main/pages/home_page.dart';
import 'package:flutter/widgets.dart';

class HomeTVSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/home-tv-series';

  const HomeTVSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomePage(
      title: Text("Tv Series"),
      content: Container(),
    );
  }
}
