import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mvvm/view_model/list_pic_viewmodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ListPictureViewModel listPictureViewModel = ListPictureViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pictures'),
      ),
      body: FutureBuilder(
        future: listPictureViewModel.fetchPictures(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: StaggeredGrid.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                children: listPictureViewModel.pictures!
                    .map((e) => Container(
                          color: Colors.grey,
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: e.picSumModel!.downloadUrl!),
                        ))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
