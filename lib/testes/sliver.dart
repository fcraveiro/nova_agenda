import 'package:flutter/material.dart';

class Sliver extends StatelessWidget {
  const Sliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: CustomScrollView(
        slivers: [
          // sliver app bar
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.deepPurple,
            leading: const Icon(Icons.menu),
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('F A N C Y A P P B A R'),
              background: Container(
                color: Colors.yellow[700],
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.red[700],
                  child: Container(
                    width: 20,
                    height: 10,
                    color: Colors.pink[700],
                  ),
                ),
              ),
            ),
          ),

          // sliver items 1
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.deepPurple[400],
                  height: 150,
                ),
              ),
            ),
          ),

          // sliver items 2
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.deepPurple[400],
                  height: 150,
                ),
              ),
            ),
          ),

          // sliver items 3
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.deepPurple[400],
                  height: 150,
                ),
              ),
            ),
          ),

          // sliver items 4
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.deepPurple[400],
                  height: 150,
                ),
              ),
            ),
          ),

          // sliver items 5
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.deepPurple[400],
                  height: 150,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
