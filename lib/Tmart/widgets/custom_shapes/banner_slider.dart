import 'package:flashchat/Tmart/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({
    super.key,
  });

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  int _currentIndex = 0; // Tracks the currently displayed image
  List<Map<String, dynamic>> banners= [];


  @override
  void initState() {
    super.initState();
    loadBanner();
  }

  Future<void> loadBanner() async {
    final loadedProducts = await FirestoreService.fetchCollection('banner');
    setState(() {
      banners = loadedProducts;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 3),
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 0.9,
            autoPlay: true,
            enlargeCenterPage: true, // Enables the zoom effect
            enlargeFactor: 0.1, // Controls how much bigger the center image appears
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index; // Updates indicator when page changes
              });
            },
          ),
          items: banners.map((banner)  {
            final imageUrl=banner['pic'];
            return Builder(
              builder: (BuildContext context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical:12,horizontal: 3),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child:Image.network(imageUrl, fit: BoxFit.cover),),
                  ),
                );
              },
            );
          }).toList(),
        ),


        // **Dot Indicator Below the Carousel**
        const SizedBox(height: 1),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex, // Binds to current image index
          count: banners.length, // Number of dots
          effect: const ExpandingDotsEffect(
            dotHeight: 8.0,
            dotWidth: 8.0,
            activeDotColor: Colors.blue, // Active dot color
            dotColor: Colors.grey, // Inactive dot color
          ),
        ),
      ],
    );
  }
}

