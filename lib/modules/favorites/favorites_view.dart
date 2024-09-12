import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:unsplashed_client/modules/favorites/favorites_controller.dart';
import 'package:unsplashed_client/theme/app_theme.dart';

import '../../theme/app_colors.dart';
import '../details/details_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoritesController favoritesController = FavoritesController();

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  _makeAsyncCalls() async {
    await favoritesController.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(children: [
        SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: AppColors.bgGradient,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight)),
              ),
              Observer(
                builder: (_) => favoritesController.isLoading
                    ? Center(
                        child: Text(
                          "NO FAVORITES YET",
                          style: AppTheme.heroTextStyle,
                        ),
                      )
                    : GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemCount:
                            favoritesController.userFavorites.values.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              color: Colors.blue,
                              child: Image(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(favoritesController
                                      .userFavorites.values
                                      .elementAt(index))),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsView(
                                            imageDetails: {
                                              favoritesController
                                                      .userFavorites.keys
                                                      .elementAt(index):
                                                  favoritesController
                                                      .userFavorites.values
                                                      .elementAt(index)
                                            },
                                          ))).then((value) async =>
                                  (value as bool)
                                      ? await _makeAsyncCalls()
                                      : {});
                            },
                          );
                        },
                      ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 40, 0, 0),
                child: Semantics(
                  label: "go back",
                  child: IconButton(
                    alignment: Alignment.topLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.navigate_before),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
