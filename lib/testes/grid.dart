import 'package:flutter/material.dart';
import 'package:nova_agenda/services/widgets.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:transparent_image/transparent_image.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> imageList = [
    'https://picsum.photos/seed/image001/500/500',
    'https://picsum.photos/seed/image005/500/600',
    'https://picsum.photos/seed/image006/500/500',
    'https://picsum.photos/seed/image007/500/400',
    'https://picsum.photos/seed/image008/500/700',
    'https://picsum.photos/seed/image009/500/600',
    'https://picsum.photos/seed/image010/500/900',
    'https://picsum.photos/seed/image011/500/900',
    'https://picsum.photos/seed/image012/500/700',
    'https://picsum.photos/seed/image013/500/700',
    'https://picsum.photos/seed/image014/500/800',
    'https://picsum.photos/seed/image015/500/500',
    'https://picsum.photos/seed/image016/500/700',
    'https://picsum.photos/seed/image017/500/600',
    'https://picsum.photos/seed/image018/500/900',
    'https://picsum.photos/seed/image019/500/800',
    'https://picsum.photos/seed/image010/500/900',
    'https://picsum.photos/seed/image011/500/900',
    'https://picsum.photos/seed/image012/500/700',
    'https://picsum.photos/seed/image006/500/500',
    'https://picsum.photos/seed/image007/500/400',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarra(context, 'Fotos'),
      body: Container(
        margin: const EdgeInsets.all(12),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            crossAxisSpacing: 06,
            mainAxisSpacing: 06,
            itemCount: imageList.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
            }),
      ),
    );
  }
}
