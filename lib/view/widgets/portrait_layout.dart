import 'package:flutter/material.dart';

import 'page_item.dart';

class PortraitLayout extends StatefulWidget {
  const PortraitLayout({
    Key? key,
    required this.index,
    required this.pages,
    required this.onSelected,
  }) : super(key: key);

  final int index;
  final List<PageItem> pages;
  final ValueChanged<int> onSelected;

  @override
  _PortraitLayoutState createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends State<PortraitLayout> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  MaterialPageRoute pageRoute(int index) {
    return MaterialPageRoute(
      builder: (context) {
        final page = widget.pages[index];
        return Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: Text(page.title),
            leading: BackButton(
              onPressed: () {
                widget.onSelected(-1);
                _navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(22.0),
                child: page.builder(context),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigator.maybePop(),
      child: Navigator(
        key: _navigatorKey,
        onGenerateInitialRoutes: (navigator, initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    elevation: 1,
                    title: const Text('Settings'),
                  ),
                  body: ListView(
                    children: [
                      for (var i = 0; i < widget.pages.length; ++i)
                        ListTile(
                          leading: Icon(widget.pages[i].iconData),
                          title: Text(widget.pages[i].title),
                          onTap: () {
                            _navigator.push(pageRoute(i));
                            widget.onSelected(i);
                          },
                        )
                    ],
                  ),
                );
              },
            ),
            if (widget.index != -1) pageRoute(widget.index)
          ];
        },
      ),
    );
  }
}
