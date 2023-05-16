import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:katim_app/presentation/features/event_list/event_list_mobile_view.dart';

void main() {
  testWidgets("description", (tester) async {
    await tester.pumpWidget(const EventListMobileView());

    await tester.drag(
        find.byKey(const Key('ListViewKey')), const Offset(0.0, -50));
    await tester.pump();
  });
}
