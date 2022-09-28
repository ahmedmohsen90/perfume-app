import 'package:flutter/material.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../model/home_model.dart';
import '../../../core/components/video_player_widget.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({
    Key? key,
    required this.images,
  }) : super(key: key);
  final List<Sliders> images;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: ScreenUtil().setHeight(160),
      child: Card(
        margin: EdgeInsets.zero,
        elevation: 8,
        child: Carousel(
          autoplay: true,
          autoplayDuration: const Duration(seconds: 30),
          indicatorBgPadding: 2,
          dotSpacing: 16,
          dotSize: ScreenUtil().radius(5),
          dotIncreasedColor: Colors.black, //Theme.of(context).primaryColor,
          images: List.generate(
            images.length,
            (index) {
              var banner = images[index];
              if (banner.type == 'image' || banner.type == 'cover') {
                return InkWell(
                  child: FadeInImage(
                    image: NetworkImage(
                      banner.url ?? '',
                    ),
                    placeholder: const AssetImage(
                      'assets/icons/loader.jpeg',
                    ),
                    fit: BoxFit.cover,
                    imageErrorBuilder: (_, __, ___) {
                      return SpinKitFadingCircle(
                        color: Theme.of(context).primaryColor,
                      );
                    },
                  ),
                );
              }
              return InkWell(
                child: VideoPlayerWidget(
                  videoUrl: banner.url ?? '',
                  // 'http://merkatosa.com/storage/celebrities/sliders/videos/2022-03-12/03122022165936622cd1780f48e.mp4',
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
