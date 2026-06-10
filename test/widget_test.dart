import 'package:flutter_test/flutter_test.dart';
import 'package:premium_portfolio/main.dart';

void main() {
  testWidgets('Portfolio should display hero section', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    
    // Wait for app to load
    await tester.pumpAndSettle();
    
    // Verify hero section exists
    expect(find.text('Moe Kyaw Aung'), findsOneWidget);
    expect(find.text('Senior Android Developer'), findsOneWidget);
  });

  testWidgets('Theme toggle should work', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();
    
    // Find theme toggle button
    final themeButton = find.byType(IconButton);
    expect(themeButton, findsOneWidget);
    
    // Tap toggle
    await tester.tap(themeButton);
    await tester.pumpAndSettle();
    
    // Verify theme changed
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
