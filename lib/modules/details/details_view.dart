import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_theme.dart';

class DetailsView extends StatefulWidget {
  final String imageUrl;
  const DetailsView({Key? key, required this.imageUrl}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: AppColors.bgGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height / 1.2),
              child: Stack(
                children: [
                  PinchZoom(
                    child: Image.network(widget.imageUrl),
                    resetDuration: const Duration(milliseconds: 100),
                    maxScale: 2.5,
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
            const Divider(),
            Expanded(
              child: Row(
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
                            Icons.download,
                          ),
                          label: Text(
                            "SAVE",
                            style: AppTheme.heroTextStyle,
                          ),
                          onPressed: () async {
                            if (!await launch(widget.imageUrl)) {
                              throw 'Could not launch ${widget.imageUrl}';
                            }
                          },
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                          icon: Icon(Icons.favorite_border),
                          label: Text(
                            "LIKE",
                            style: AppTheme.heroTextStyle,
                          ),
                          onPressed: () {},
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
