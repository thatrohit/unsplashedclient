import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/home/home_controller.dart';
import 'package:unsplashed_client/theme/app_theme.dart';
import 'package:unsplashed_client/utils/helpers.dart';

import '../../theme/app_colors.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences? prefs;
  @override
  void initState() {
    super.initState();
    _makeInitAsyncCalls();
  }

  Future<void> _makeInitAsyncCalls() async {
    prefs = await SharedPreferences.getInstance();
    bool useLocalRepo = prefs?.getBool('useLocalRepo') ?? false;
    await homeController.getDesktopWallpapers(
        repository:
            useLocalRepo ? ResponseRepository.local : ResponseRepository.web);
    await homeController.getMobileWallpapers(
        repository:
            useLocalRepo ? ResponseRepository.local : ResponseRepository.web);
  }

  final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    print("getting from shared ${prefs?.getString('email')}");
    return SingleChildScrollView(
      child: Material(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                ListTile(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                  tileColor: AppColors.lightPurple,
                  leading: Lottie.network(
                    'https://assets2.lottiefiles.com/packages/lf20_jX856c.json',
                    repeat: false,
                    height: 200,
                  ),
                  subtitle: const Text(
                    "You don't have any favorite images yet",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  title: Text(
                    "Logged in as ${prefs?.getString('email') ?? ''}",
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      prefs?.remove('email');
                      prefs?.remove('uid');
                      Navigator.pop(context);
                    },
                  ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HorizontalListItemTemplate extends StatelessWidget {
  const HorizontalListItemTemplate({
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
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(results?[index].urls?.small ?? ""),
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
