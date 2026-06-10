import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:premium_portfolio/main.dart';

void main() {
  testWidgets('Portfolio displays hero section correctly', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify hero section elements
    expect(find.text('မိုးကျော်အောင်'), findsOneWidget);
    expect(find.text('Moe Kyaw Aung'), findsOneWidget);
    expect(find.text('Senior Android Developer'), findsOneWidget);
    expect(find.text('Tachileik, Myanmar 🇲🇲  ↔  Bangkok, Thailand 🇹🇭'), findsOneWidget);
    
    // Verify Open to Work badge
    expect(find.text('🟢 Open to Work'), findsOneWidget);
    
    // Verify stats
    expect(find.text('82+'), findsOneWidget);
    expect(find.text('Certificates'), findsOneWidget);
    expect(find.text('40+'), findsOneWidget);
    expect(find.text('Projects'), findsOneWidget);
  });

  testWidgets('Theme toggle button exists and is clickable', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Find theme toggle button
    final themeToggle = find.byIcon(Icons.light_mode);
    expect(themeToggle, findsOneWidget);
    
    // Tap the button
    await tester.tap(themeToggle);
    await tester.pumpAndSettle();
    
    // Verify theme changed
    final theme = Theme.of(tester.element(find.byType(MaterialApp)));
    expect(theme.brightness, Brightness.light);
  });

  testWidgets('Quick action buttons are clickable', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify action buttons exist
    expect(find.text('📱 Apps'), findsOneWidget);
    expect(find.text('📄 Resume'), findsOneWidget);
    expect(find.text('💼 LinkedIn'), findsOneWidget);
    
    // Tap Apps button
    final appsButton = find.text('📱 Apps');
    await tester.tap(appsButton);
    await tester.pumpAndSettle();
  });

  testWidgets('Focus areas cards display correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify focus areas
    expect(find.text('📱 Mobile'), findsOneWidget);
    expect(find.text('☁️ Backend'), findsOneWidget);
    expect(find.text('🔐 Security'), findsOneWidget);
    expect(find.text('🤖 AI / ML'), findsOneWidget);
    
    // Verify technology details
    expect(find.text('Kotlin · Jetpack Compose · MVVM · Clean Arch'), findsOneWidget);
    expect(find.text('Firebase · REST APIs · Python'), findsOneWidget);
  });

  testWidgets('Tech stack tags display correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify key tech tags
    expect(find.text('Kotlin'), findsOneWidget);
    expect(find.text('Jetpack Compose'), findsOneWidget);
    expect(find.text('Android'), findsOneWidget);
    expect(find.text('Firebase'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Python'), findsOneWidget);
  });

  testWidgets('Projects grid displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify project count
    expect(find.text('16 Production Projects'), findsOneWidget);
    
    // Verify individual projects
    expect(find.text('Social Dashboard'), findsOneWidget);
    expect(find.text('PWA App'), findsOneWidget);
    expect(find.text('Job Portal App'), findsOneWidget);
    expect(find.text('Video Player'), findsOneWidget);
  });

  testWidgets('Certifications badge displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify certification badge
    expect(find.text('82+ Certificates · Programming Hub · Google Developers Launchpad'), findsOneWidget);
    
    // Verify individual certs
    expect(find.text('⌨️ C Programming'), findsOneWidget);
    expect(find.text('🤖 Kotlin / Android'), findsOneWidget);
  });

  testWidgets('Contact information displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify contact details
    expect(find.text('📬 Get In Touch'), findsOneWidget);
    expect(find.text('📱 Phone'), findsOneWidget);
    expect(find.text('+95 9 889 000 889'), findsOneWidget);
    expect(find.text('📧 Email'), findsOneWidget);
    expect(find.text('moekyawaung@programmer.net'), findsOneWidget);
    expect(find.text('💼 LinkedIn'), findsOneWidget);
    expect(find.text('🖥️ GitHub'), findsOneWidget);
  });

  testWidgets('Footer displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const PremiumPortfolioV1());
    await tester.pumpAndSettle();

    // Verify footer content
    expect(find.text('"Code with culture. Build with purpose."'), findsOneWidget);
    expect(find.text('© 2026 Moe Kyaw Aung | Senior Android Developer'), findsOneWidget);
  });
}
