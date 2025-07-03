import 'package:flutter/material.dart';
import '../models/vendor_model.dart';
import '../screens/product_screen.dart';

class VendorTile extends StatelessWidget {
  final Vendor vendor;

  const VendorTile({super.key, required this.vendor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductScreen(vendor: vendor),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Vendor Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: vendor.image.isNotEmpty
                  ? Image.network(
                vendor.image,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              )
                  : Container(
                height: 70,
                width: 70,
                color: Colors.grey[300],
                child: const Icon(Icons.storefront),
              ),
            ),
            const SizedBox(width: 12),

            // Vendor Info (Expanded to prevent overflow)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vendor.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    vendor.location,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.green, size: 16),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          '${vendor.rating} rated',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.pedal_bike, size: 16, color: Colors.green),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Prepare in ${vendor.time} mins',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${vendor.distance.toStringAsFixed(2)} km Away',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}