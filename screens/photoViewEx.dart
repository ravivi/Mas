import 'package:Mas/shared/customColor.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_view/photo_view.dart';

import 'package:photo_view/photo_view_gallery.dart';

class HeroExample extends StatelessWidget {
  final int id;
  final String image;

  HeroExample({this.id, this.image});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HeroPhotoViewWrapper(
                loadingBuilder: (contex, event) => Center(
                      child: SpinKitFadingCube(
                        color: CustomColors.skyBlue,
                      ),
                    ),
                id: id,
                imageProvider: NetworkImage("${image}")),
          ),
        );
      },
      child: Container(
        child: Hero(
          tag: id,
          child: CachedNetworkImage(
            height: 80.0,
            imageUrl: image,
            placeholder: (context, url) => Center(
                child: Image.asset(
              'images/maison.jpg',
              fit: BoxFit.cover,
            )),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}

class HeroPhotoViewWrapper extends StatelessWidget {
  const HeroPhotoViewWrapper({
    this.imageProvider,
    this.id,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final int id;
  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        loadingBuilder: loadingBuilder,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        //enableRotation: true,
        maxScale: maxScale,
        initialScale: PhotoViewComputedScale.contained * 0.8,
        heroAttributes: PhotoViewHeroAttributes(tag: id),
      ),
    );
  }
}

class GalleryExample extends StatefulWidget {
  @override
  _GalleryExampleState createState() => _GalleryExampleState();
}

class _GalleryExampleState extends State<GalleryExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Center(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: galleryItems.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width - 100,
                    child: GalleryExampleItemThumbnail(
                      galleryExampleItem: galleryItems[i],
                      onTap: () {
                        open(context, i);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper({
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex,
    @required this.galleryItems,
    this.scrollDirection = Axis.horizontal,
  }) : pageController = PageController(initialPage: initialIndex);

  final LoadingBuilder loadingBuilder;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryExampleItem> galleryItems;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: _buildItem,
              itemCount: widget.galleryItems.length,
              loadingBuilder: widget.loadingBuilder,
              backgroundDecoration: widget.backgroundDecoration,
              pageController: widget.pageController,
              onPageChanged: onPageChanged,
              scrollDirection: widget.scrollDirection,
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Image ${currentIndex + 1}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  decoration: null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final GalleryExampleItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: item.id),
    );
  }
}

class GalleryExampleItem {
  GalleryExampleItem({this.id, this.resource});

  final int id;
  final String resource;
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail(
      {Key key, this.galleryExampleItem, this.onTap})
      : super(key: key);

  final GalleryExampleItem galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: galleryExampleItem.id,
            child: CachedNetworkImage(
              height: 80.0,
              imageUrl: galleryExampleItem.resource,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          )),
    );
  }
}

List<GalleryExampleItem> galleryItem;

List<GalleryExampleItem> galleryItems = <GalleryExampleItem>[
  GalleryExampleItem(
    id: 1,
    resource: "https://mas.wmcci.com/images/img3.jpg",
  ),
  GalleryExampleItem(id: 2, resource: "https://mas.wmcci.com/images/img1.jpg"),
  GalleryExampleItem(
    id: 3,
    resource: "https://mas.wmcci.com/images/img2.jpg",
  ),
  GalleryExampleItem(
    id: 4,
    resource: "https://mas.wmcci.com/images/img4.jpg",
  ),
];
List myImages = [
  "https://mas.wmcci.com/images/img3.jpg",
  "https://mas.wmcci.com/images/img1.jpg",
  "https://mas.wmcci.com/images/img2.jpg",
  "https://mas.wmcci.com/images/img4.jpg"
];
