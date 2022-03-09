import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:unsplashed_client/models/common.dart';
import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/details/details_view.dart';
import 'package:unsplashed_client/modules/home/home_controller.dart';
import 'package:unsplashed_client/modules/search/search_view.dart';
import 'package:unsplashed_client/theme/app_theme.dart';
import 'package:unsplashed_client/utils/helpers.dart';

import '../../theme/app_colors.dart';
import '../favorites/favorites_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController homeController = HomeController();

  @override
  void initState() {
    super.initState();
    _makeInitAsyncCalls();
  }

  Future<void> _makeInitAsyncCalls() async {
    await homeController.initSharedPreferences().then((value) async {
      bool useLocalRepo =
          (value?.getString('useLocalRepo') ?? "false") == "true";
      await homeController
          .getDesktopWallpapers(
              repository: useLocalRepo
                  ? ResponseRepository.local
                  : ResponseRepository.web)
          .then((value) => value?.results?.add(Results(
                id: "show-more",
                urls: Urls(small: 'assets/next.png'),
              )));
      await homeController
          .getMobileWallpapers(
              repository: useLocalRepo
                  ? ResponseRepository.local
                  : ResponseRepository.web)
          .then((value) => value?.results?.add(Results(
                id: "show-more",
                urls: Urls(small: 'assets/next.png'),
              )));
    });
    await homeController.updateHeaderText();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: AppColors.bgGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Observer(
                  builder: (_) => ListTile(
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    tileColor: AppColors.lightPurple,
                    leading: SizedBox(
                      child: Image.asset('assets/logo.png'),
                      height: 60,
                      width: 60,
                    ),
                    // Lottie.network(
                    //   'https://assets2.lottiefiles.com/packages/lf20_jX856c.json',
                    //   repeat: false,
                    //   height: 200,
                    // ),
                    subtitle: Observer(
                      builder: (_) => Text(
                        homeController.headerText,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    title: Text(
                      "Logged in as ${homeController.prefs?.getString('email') ?? ''}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Semantics(
                      label: "logout",
                      child: IconButton(
                        icon: const Icon(Icons.logout),
                        onPressed: () {
                          homeController.prefs?.remove('email');
                          homeController.prefs?.remove('uid');
                          homeController.prefs?.remove('useLocalRepo');
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 100,
                        ),
                        child: Align(
                          child: TextButton.icon(
                            icon: const Icon(
                              Icons.search,
                            ),
                            label: Text(
                              "SEARCH",
                              style: AppTheme.heroTextStyle,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SearchView(searchParam: ""))).then(
                                  (value) async =>
                                      await homeController.updateHeaderText());
                            },
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Container(
                        color: Colors.grey,
                        constraints: const BoxConstraints(
                          minHeight: 100,
                          maxWidth: 1,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        constraints: const BoxConstraints(
                          minHeight: 100,
                        ),
                        child: Align(
                          child: TextButton.icon(
                            icon: Icon(Icons.favorite),
                            label: Text(
                              "LIKES",
                              style: AppTheme.heroTextStyle,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FavoritesView())).then(
                                  (value) async =>
                                      await homeController.updateHeaderText());
                            },
                          ),
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
                NamedDivider(
                  "DESKTOP",
                ),
                SizedBox(
                  height: 200.0,
                  child: Observer(
                    builder: (_) => homeController.isLoadingDesktopWallpapers
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeController
                                    .desktopWallpapers?.results?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsView(
                                                imageDetails: {
                                                  (homeController
                                                          .desktopWallpapers
                                                          ?.results?[index]
                                                          .id ??
                                                      "no-id"): (homeController
                                                          .desktopWallpapers
                                                          ?.results?[index]
                                                          .urls
                                                          ?.regular ??
                                                      "")
                                                },
                                              ))).then((value) async =>
                                      await homeController.updateHeaderText());
                                },
                                child: HorizontalListItemTemplate(
                                  results:
                                      homeController.desktopWallpapers?.results,
                                  height: 200,
                                  width: 300,
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                NamedDivider(
                  "MOBILE",
                ),
                SizedBox(
                  height: 300.0,
                  child: Observer(
                    builder: (_) => homeController.isLoadingMobileWallpapers
                        ? const Center(
                            child: CircularProgressIndicator.adaptive())
                        : ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeController
                                    .mobileWallpapers?.results?.length ??
                                0,
                            itemBuilder: (BuildContext context, int index) =>
                                Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsView(
                                                imageDetails: {
                                                  (homeController
                                                          .mobileWallpapers
                                                          ?.results?[index]
                                                          .id ??
                                                      "no-id"): (homeController
                                                          .mobileWallpapers
                                                          ?.results?[index]
                                                          .urls
                                                          ?.regular ??
                                                      "")
                                                },
                                              ))).then((value) async =>
                                      await homeController.updateHeaderText());
                                },
                                child: HorizontalListItemTemplate(
                                  results:
                                      homeController.mobileWallpapers?.results,
                                  height: 300,
                                  width: 220,
                                  index: index,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalListItemTemplate extends StatelessWidget {
  HomeController homeController = HomeController();
  HorizontalListItemTemplate({
    Key? key,
    required this.results,
    required this.index,
    required this.height,
    required this.width,
  }) : super(key: key);

  final List<Results>? results;
  final int index;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: results?[index].id != "show-more"
                ? Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(results?[index].urls?.small ?? ""),
                  )
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SearchView(searchParam: "wallpapers"))).then(
                          (value) async =>
                              await homeController.updateHeaderText());
                    },
                    icon: Image(
                      height: 40,
                      width: 40,
                      fit: BoxFit.scaleDown,
                      image: AssetImage(results?[index].urls?.small ?? ""),
                    ),
                  ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    (results?[index].user?.name ?? ""),
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NamedDivider extends StatelessWidget {
  String title;
  NamedDivider(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            const Expanded(
              child: Divider(),
            ),
            Text(
              title,
              style: AppTheme.heroTextStyle,
            ),
            const Expanded(
              child: Divider(),
            ),
          ],
        ),
      ),
    );
  }
}
