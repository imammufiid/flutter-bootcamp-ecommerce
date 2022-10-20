import 'package:component/widget/progress_indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class DialogLoading {
  static void show(BuildContext context) {
    showDialog(
        // The user CANNOT close this dialog  by pressing outsite it
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  Center(child: CustomCircularProgressIndicator()),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          );
        });
  }

  static void dismiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
