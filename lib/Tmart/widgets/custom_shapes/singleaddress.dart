import 'package:flashchat/Tmart/colors.dart';
import 'package:flashchat/Tmart/widgets/custom_shapes/rounded_container.dart';
import 'package:flutter/material.dart';

class TSingleAddress extends StatelessWidget {
  const TSingleAddress({
    super.key,
    required this.selectedAddress,
    required this.name,
    required this.phone,
    required this.fullAddress,
});

  final bool selectedAddress;
  final String name;
  final String phone;
  final String fullAddress;

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
                name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height:8),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.grey, size: 16),
                  const SizedBox(width:12),
                  Text(
                    phone,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height:8),
              Row(
                children: [
                  const Icon(Icons.location_history, color: Colors.grey, size: 16),
                  const SizedBox(width:12),
                  SizedBox(
                    width: 274,
                    child: Text(
                      fullAddress,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: Theme.of(context).textTheme.bodyMedium,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
