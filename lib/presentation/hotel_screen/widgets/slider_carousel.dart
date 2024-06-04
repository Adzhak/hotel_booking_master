import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:hotel_booking/core/app_export.dart';

import '../notifier/hotel_notifier.dart';
import 'basic_data.dart';

class SliderCarousel extends StatefulWidget {
  const SliderCarousel({super.key});

  @override
  State<SliderCarousel> createState() => _SliderCarouselState();
}

class _SliderCarouselState extends State<SliderCarousel> {
  final List<String> imagesList = [
    'https://masterpiecer-images.s3.yandex.net/5fd531dca6427c7:upscaled',
    'https://avatars.dzeninfra.ru/get-zen_doc/8269145/pub_641ec1d0798be415157b4180_641f3d1cd4b1f54fcf2f0a01/scale_1200',
    'https://cdnn21.img.ria.ru/images/148839/96/1488399659_0:0:960:960_600x0_80_0_1_e38b72053fffa5d3d7e82d2fe116f0b3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.fillWhiteA.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 257.v,
            width: 343.h,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    return CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 257.v,
                        initialPage: 0,
                        autoPlay: true,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (
                          index,
                          reason,
                        ) {
                          ref.watch(hotelNotifier).sliderIndex = index;
                        },
                      ),
                      itemCount: imagesList.length,
                      itemBuilder:
                          (BuildContext context, int index, int realIndex) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  imagesList[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer(
                    builder: (context, ref, _) {
                      return Container(
                        height: 17.v,
                        margin: EdgeInsets.only(bottom: 8.v),
                        child: AnimatedSmoothIndicator(
                          activeIndex: ref.watch(hotelNotifier).sliderIndex,
                          count: ref
                                  .watch(hotelNotifier)
                                  .hotelModelObj
                                  ?.sliderList
                                  .length ??
                              0,
                          axisDirection: Axis.horizontal,
                          effect: ScrollingDotsEffect(
                            spacing: 5,
                            activeDotColor: theme.colorScheme.secondaryContainer
                                .withOpacity(1),
                            dotColor: theme.colorScheme.secondaryContainer
                                .withOpacity(0.22),
                            dotHeight: 7.v,
                            dotWidth: 7.h,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.v),
          BasicData(),
        ],
      ),
    );
  }
}
