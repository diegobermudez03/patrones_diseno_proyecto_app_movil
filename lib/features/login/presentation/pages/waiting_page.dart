import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_strings.dart';

class WaitingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient for a more appealing look
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.surfaceContainerLow, theme.surfaceContainerHigh],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon representing waiting status
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [theme.primaryFixed, theme.primaryFixedDim],
                      ),
                    ),
                    child: Icon(
                      Icons.hourglass_empty,
                      size: 64,
                      color: theme.onPrimaryFixed,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Waiting message
                  Text(
                    AppStrings.waitingSession,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: theme.onSurface,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Subtle message for user reassurance (optional)
                  Text(
                    AppStrings.pleaseWaitWhileYourSessionIsBeingApproved,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: theme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
