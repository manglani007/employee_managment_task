import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppUtils {
  static void showSnackBar(
      {required BuildContext context,
      required String message,
      required String label,
      required Function onPress}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: label,
          onPressed: () => {onPress()},
        ),
      ));
  }

  static DateTime getNextDayOfWeek(int i) {
    DateTime cDate = DateTime.now();
    if (cDate.weekday == i) {
      cDate = cDate.add(const Duration(days: 1));
    }
    return cDate.add(Duration(
      days: (i - cDate.weekday) % DateTime.daysPerWeek,
    ));
  }

  static void showAboutDiilog({
    required BuildContext context,
  }) {
    showAdaptiveDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text("By Rohit Manglani"),
          content: const Text("hardevdresses@gmail.com"),
          actions: [
            TextButton(onPressed: context.pop, child: const Text("OK"))
          ],
        );
      },
    );
  }
}
