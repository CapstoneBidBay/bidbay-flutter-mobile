import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarRatingBar extends StatelessWidget {
  final double rating;
  final double size;
  const StarRatingBar({required this.rating, required this.size, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      allowHalfRating: true,
      initialRating: rating,
      ignoreGestures: true,
      itemSize: size,
      ratingWidget: RatingWidget(
          full: const Icon(Icons.star, color: Color.fromARGB(255, 222, 67, 44)),
          half: const Icon(Icons.star_half, color: Color.fromARGB(255, 237, 226, 76)),
          empty: const Icon(Icons.star_outline, color: Color.fromARGB(255, 0, 0, 0))),
      onRatingUpdate: (_) {},
    );
  }
}
