import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:unsplashed_client/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _makeInitApiCalls();
  }

  Future<void> _makeInitApiCalls() async {
    await homeController.getWallpapers();
  }

  final HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    homeController.getWallpapers();
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Material(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Observer(
                builder: (_) => !homeController.isLoading
                    ? Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: homeController.wallpapers?.results?.length,
                          itemBuilder: (context, index) {
                            return Image(
                              height: 100,
                              width: 100,
                              image: NetworkImage(homeController.wallpapers
                                      ?.results?[index].urls?.small ??
                                  ""),
                            );
                          },
                        ),
                      )
                    : CircularProgressIndicator.adaptive(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
