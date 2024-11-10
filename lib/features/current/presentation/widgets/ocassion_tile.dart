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
    final String content = ocassion.event != null
        ? '${ocassion.event!.name} : ${ocassion.event!.address}'
        : '${ocassion.booking!.isHouse ? AppStrings.house : AppStrings.apartment} : ${ocassion.booking!.address}';

    // Action button color and text
    final Color buttonColor = ocassion.isInside ? Colors.red : Colors.green;
    final String action = ocassion.isInside ? AppStrings.exit : AppStrings.enter;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.surfaceContainerLowest, theme.surfaceContainer],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadow.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with type icon and label
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Type icon
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.primaryContainer,
                    ),
                    child: Icon(
                      ocassion.event != null ? Icons.event : Icons.home,
                      color: theme.onPrimaryContainer,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Type label
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
              // Small status indicator (if needed, e.g., for in-progress states)
              if (ocassion.isInside)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    AppStrings.inside,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.onSecondaryContainer,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 12),
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
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: ElevatedButton(
                      onPressed: () => callback(ocassion.ocassionId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        shadowColor: buttonColor.withOpacity(0.4),
                      ),
                      child: Text(
                        action,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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
