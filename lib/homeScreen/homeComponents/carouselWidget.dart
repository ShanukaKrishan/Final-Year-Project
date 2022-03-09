import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({Key? key}) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  final stringImages = [
    'assets/images/carol1.jpg',
    'assets/images/carol2.jpg',
    'assets/images/carol3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: stringImages.length,
      itemBuilder: (context, index, realIndex) {
        final image = stringImages[index];
        return buildImage(image, index);
      },
      options: CarouselOptions(
        height: 200,
        initialPage: 1,
        viewportFraction: 0.95,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
    );
  }

  Widget buildImage(String image, int index) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
      );
}
