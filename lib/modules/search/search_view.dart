import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:unsplashed_client/models/search.dart';
import 'package:unsplashed_client/modules/details/details_view.dart';
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
  bool firstRun = true;
  int page = 1;

  @override
  void initState() {
    super.initState();
    _makeAsyncCalls();
  }

  void _makeAsyncCalls() async {
    await searchController.searchWallpapers(widget.searchParam, page);
  }

  @override
  Widget build(BuildContext context) {
    if (firstRun) {
      searchTextContoller.text = widget.searchParam;
      firstRun = false;
    }
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
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 8,
                  ),
                  Semantics(
                    label: "go back",
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.navigate_before),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(30)),
                      child: Semantics(
                        label: "search for wallpapers here",
                        child: TextField(
                          cursorColor: AppColors.lightPurple,
                          controller: searchTextContoller,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(0),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: AppColors.lightPurple,
                            prefixIcon:
                                const Icon(Icons.search, color: Colors.white),
                            border: InputBorder.none,
                            labelText: 'Search...',
                            suffixIcon: Semantics(
                              label: "clear search text",
                              child: IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  page = 1;
                                  searchTextContoller.clear();
                                  searchController.clearSearch();
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.primary)),
                      onPressed: () async {
                        page = 1;
                        await searchController.searchWallpapers(
                            searchTextContoller.text, page);
                      },
                      child: const Text('GO')),
                  const SizedBox(
                    width: 8,
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Divider(),
              ),
              PhotoGrid(searchController: searchController),
              SizedBox(
                height: 30,
                child: Observer(
                  builder: (_) => Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
                          child: Text("Page: $page"),
                        ),
                      ),
                      IconButton(
                        disabledColor: AppColors.grayBG,
                        onPressed: searchController.hasPrevPage
                            ? () async {
                                searchController.clearSearch();
                                if (page > 1) page--;
                                await searchController.searchWallpapers(
                                    searchTextContoller.text, page);
                              }
                            : null,
                        icon: const Icon(Icons.navigate_before),
                      ),
                      IconButton(
                        disabledColor: AppColors.grayBG,
                        onPressed: searchController.hasNextPage
                            ? () async {
                                searchController.clearSearch();
                                page++;
                                await searchController.searchWallpapers(
                                    searchTextContoller.text, page);
                              }
                            : null,
                        icon: const Icon(Icons.navigate_next),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PhotoGrid extends StatelessWidget {
  const PhotoGrid({
    Key? key,
    required this.searchController,
  }) : super(key: key);

  final SearchController searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                mainAxisSpacing: 4.0,
                children: List.generate(
                  searchController.wallpapers?.results?.length ?? 0,
                  (index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsView(
                                        imageDetails: {
                                          (searchController.wallpapers
                                                  ?.results?[index].id ??
                                              "no-id"): (searchController
                                                  .wallpapers
                                                  ?.results?[index]
                                                  .urls
                                                  ?.regular ??
                                              "")
                                        },
                                      )));
                        },
                        child: GridItemTemplate(
                          height: 200,
                          index: index,
                          results: searchController.wallpapers?.results,
                          width: 200,
                        ),
                      ),
                    );
                  },
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
