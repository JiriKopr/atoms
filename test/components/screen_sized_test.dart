import 'package:atoms/atoms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('takes up the size of the screen', (WidgetTester tester) async {
    // Create the parent of the [MaxConstrains] widget
    final uniqueKey = UniqueKey();
    final widget = ScreenSized(child: Container(), key: uniqueKey);
    final app = MaterialApp(home: widget);

    await tester.pumpWidget(app);

    final foundByKey = find.byKey(uniqueKey);
    final foundWidget = foundByKey.evaluate().first;

    final foundAppWidget = find.byType(MaterialApp).evaluate().first;
    final appHeight = foundAppWidget.size.height;
    final appWidth = foundAppWidget.size.width;

    expect(foundByKey, findsOneWidget);
    expect(foundWidget.size.height, appHeight);
    expect(foundWidget.size.width, appWidth);
  });
}
