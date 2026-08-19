import 'package:flutter_test/flutter_test.dart';

import 'package:scenora_mobile/app.dart';

void main() {
  testWidgets('Scenora launches with the movie community shell', (
    tester,
  ) async {
    loadRemoteImages = false;
    await tester.pumpWidget(const ScenoraApp());

    expect(find.text('SCENORA'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Explore'), findsOneWidget);
    expect(find.text('Top Rated Reviewers'), findsOneWidget);
  });
}
