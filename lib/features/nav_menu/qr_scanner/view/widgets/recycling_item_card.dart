import 'package:flutter/material.dart';
import 'package:wastenot/features/nav_menu/qr_scanner/model/qr_scanner_model.dart';
import 'package:wastenot/utils/constants/colors.dart';
import 'package:wastenot/utils/constants/sizes.dart';


class RecyclingItemCard extends StatelessWidget {
  final String materialType;
  final int count;

  const RecyclingItemCard({
    Key? key,
    required this.materialType,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final points = count * RecyclingData.getPointsPerItem(materialType);

    return Card(
      margin: const EdgeInsets.only(bottom: WNSizes.sm),
      child: Padding(
        padding: const EdgeInsets.all(WNSizes.md),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(WNSizes.sm),
              decoration: BoxDecoration(
                color: _getMaterialColor(materialType).withOpacity(0.2),
                borderRadius: BorderRadius.circular(WNSizes.sm),
              ),
              child: Icon(
                _getMaterialIcon(materialType),
                color: _getMaterialColor(materialType),
                size: 30,
              ),
            ),
            const SizedBox(width: WNSizes.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _capitalizeFirstLetter(materialType),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('${count} ${count > 1 ? 'items' : 'item'}'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$points pts',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: WNColors.primary,
                  ),
                ),
                Text(
                  '${RecyclingData.getPointsPerItem(materialType)} pts each',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getMaterialIcon(String materialType) {
    switch (materialType.toLowerCase()) {
      case 'plastic':
        return Icons.local_drink;
      case 'can':
        return Icons.crop_square;
      case 'paper':
        return Icons.article;
      case 'glass':
        return Icons.wine_bar;
      default:
        return Icons.recycling;
    }
  }

  Color _getMaterialColor(String materialType) {
    switch (materialType.toLowerCase()) {
      case 'plastic':
        return Colors.blue;
      case 'can':
        return Colors.orange;
      case 'paper':
        return Colors.amber;
      case 'glass':
        return Colors.teal;
      default:
        return Colors.green;
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}