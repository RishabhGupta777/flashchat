import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.selectedAddress,
  });

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? TColors.primary.withOpacity(0.3)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : Colors.black12,
      margin:8,
      padding: 8,
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 5,
            child: Icon(
              selectedAddress ? Icons.check: null,
              color: selectedAddress
                  ? Colors.black
                  : Colors.transparent,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'John Doe',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 6),
              Text('+91 9113141516'),
              const SizedBox(height: 6),
              Text(
                'Jimmy Coves, South Lima, Maine, 87845, USA',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
