import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/search/search_controller.dart';
import 'package:unsplashed_client/theme/app_colors.dart';

class SearchView extends StatefulWidget {
  final String searchParam;
  const SearchView({Key? key, required this.searchParam}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchTextContoller = TextEditingController();
  SearchController searchController = SearchController();

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  void _makeAsyncCalls() async {
    searchController.searchWallpapers(widget.searchParam);
  }

  @override
  Widget build(BuildContext context) {
    searchTextContoller.text = widget.searchParam;
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: AppColors.bgGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30)),
                      child: TextField(
                        cursorColor: AppColors.lightPurple,
                        controller: searchTextContoller,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: AppColors.lightPurple,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white),
                            border: InputBorder.none,
                            labelText: 'Search...',
                            suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  searchTextContoller.clear();
                                  //searchContoller.clearSearch();
                                })),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.primary)),
                    onPressed: () async {
                      //searchContoller.clearSearch();
                      //await controller.getWeather(textController.text);
                    },
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 14.0, horizontal: 20),
                      child: Text('GO'),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                ],
              ),
              Expanded(
                child: Observer(
                  builder: (_) => searchController.isLoading
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : GridView.count(
                          crossAxisCount: searchController.getGridViewColumns(
                            MediaQuery.of(context).size.width,
                          ),
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          children: List.generate(
                            searchController.wallpapers?.results?.length ?? 0,
                            (index) {
                              return Center(
                                child: GridItemTemplate(
                                  height: 200,
                                  index: index,
                                  results: searchController.wallpapers?.results,
                                  width: 200,
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItemTemplate extends StatelessWidget {
  const GridItemTemplate({
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
              )),
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
