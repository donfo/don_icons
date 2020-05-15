import 'package:flutter/material.dart';
import 'package:don_icons/don_icons.dart';
import 'package:don_icons_example/icons.dart';

void main() {
  runApp(DonIconsGalleryApp());
}

class DonIconsGalleryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Don Icons Gallery',
      theme: ThemeData.light().copyWith(
        iconTheme: IconThemeData(size: 36.0, color: Colors.black87),
        textTheme: TextTheme(
          body1: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
      ),
      home: DonIconsGalleryHome(),
    );
  }
}

class DonIconsGalleryHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DonIconsGalleryHomeState();
}

class DonIconsGalleryHomeState extends State<DonIconsGalleryHome> {
  var _searchTerm = "";
  var _isSearching = false;

  @override
  Widget build(BuildContext context) {
    final filteredIcons = icons.where((icon) => _searchTerm.isEmpty || icon.title.toLowerCase().contains(_searchTerm.toLowerCase())).toList();
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: _isSearching ? _searchBar(context) : _titleBar(),
      body: GridView.builder(
        itemCount: filteredIcons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
        ),
        itemBuilder: (context, index) {
          final icon = filteredIcons[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute<Null>(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Hero(
                          tag: icon,
                          child: Icon(
                            icon.iconData,
                            size: 100,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(tag: icon, child: Icon(icon.iconData)),
                Container(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(icon.title),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _titleBar() {
    return AppBar(
      title: Text("DonIcons Gallery"),
      actions: [
        IconButton(
          icon: Icon(DonIcons.search),
          onPressed: () {
            ModalRoute.of(context).addLocalHistoryEntry(
              LocalHistoryEntry(
                onRemove: () {
                  setState(() {
                    _searchTerm = "";
                    _isSearching = false;
                  });
                },
              ),
            );

            setState(() {
              _isSearching = true;
            });
          },
        ),
      ],
    );
  }

  AppBar _searchBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(DonIcons.arrowLeft),
        onPressed: () {
          setState(
            () {
              Navigator.pop(context);
              _isSearching = false;
              _searchTerm = "";
            },
          );
        },
      ),
      title: TextField(
        onChanged: (text) => setState(() => _searchTerm = text),
        autofocus: true,
        style: TextStyle(fontSize: 18.0),
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
