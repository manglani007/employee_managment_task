import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class EmptyListPlaceholder extends StatelessWidget {
  const EmptyListPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
            height: 200, width: 200, child: Image.asset("assets/empty.png")),
      ],
    );
  }
}
