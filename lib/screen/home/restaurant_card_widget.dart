import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;
  final Function() onTap;
  const RestaurantCard(
      {super.key, required this.restaurant, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 180,
            minHeight: 180,
            maxWidth: 160,
            minWidth: 160,
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  restaurant.pictureUrlMedium,
                  fit: BoxFit.cover,
                  width: 500,
                  height: 400,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  width: 500,
                  height: 400,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Positioned(
                bottom: 8,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    const SizedBox.square(dimension: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop_outlined,
                          color: Colors.red,
                        ),
                        const SizedBox.square(dimension: 4),
                        Text(
                          restaurant.city,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox.square(dimension: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox.square(dimension: 4),
                        Text(
                          restaurant.rating.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
