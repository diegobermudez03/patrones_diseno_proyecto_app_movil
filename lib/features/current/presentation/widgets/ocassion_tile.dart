import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

class OcassionTile extends StatelessWidget {
  final OcassionEntity ocassion;
  final void Function(int) callback;
  final int? loadingOcassionId;

  const OcassionTile({
    super.key,
    required this.ocassion,
    required this.callback,
    required this.loadingOcassionId,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    // Determine type and content
    final String type = ocassion.event != null ? AppStrings.event : AppStrings.booking;
    late final String content;
    if (ocassion.event != null) {
      content = '${ocassion.event!.name} : ${ocassion.event!.address}';
    } else {
      String house = ocassion.booking!.isHouse ? AppStrings.house : AppStrings.apartment;
      content = '$house : ${ocassion.booking!.address}';
    }

    // Action button color and text
    final Color buttonColor = ocassion.isInside ? Colors.red : Colors.green;
    final String action = ocassion.isInside ? AppStrings.exit : AppStrings.enter;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin between tiles
      padding: const EdgeInsets.all(16.0), // Internal padding
      decoration: BoxDecoration(
        color: theme.surface, // Background color for the tile
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with type icon and label
          Row(
            children: [
              Icon(
                ocassion.event != null ? Icons.event : Icons.home,
                color: theme.primaryContainer,
              ),
              const SizedBox(width: 8),
              Text(
                type,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Content text
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: theme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          // Action button or loading indicator
          loadingOcassionId != ocassion.ocassionId
              ? Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => callback(ocassion.ocassionId),
                    style: TextButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    ),
                    child: Text(
                      action,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
