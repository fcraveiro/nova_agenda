import 'package:flutter/material.dart';

class MainCollapsingToolbar extends StatefulWidget {
  const MainCollapsingToolbar({Key? key}) : super(key: key);

  @override
  _MainCollapsingToolbarState createState() => _MainCollapsingToolbarState();
}

class _MainCollapsingToolbarState extends State<MainCollapsingToolbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 230.0,
                floating: false,
                pinned: true,
                actions: const [
                  Icon(Icons.menu),
                  SizedBox(
                    width: 10,
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: const Text("Cadastro de Pacientes",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        )),
                    background: Image.asset(
                      "assets/imagens/vera1.jpeg",
                      fit: BoxFit.cover,
                    )),
              ),
              /*
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    labelColor: Colors.black87,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(icon: Icon(Icons.info), text: "Tab 1"),
                      Tab(icon: Icon(Icons.lightbulb_outline), text: "Tab 2"),
                    ],
                  ),
                ),
                pinned: true,
              ),
*/
            ];
          },
          body: const Center(
            child: Text("Lista de Pacientes"),
          ),
        ),
      ),
    );
  }
}

// ignore: unused_element
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
