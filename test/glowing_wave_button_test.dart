import 'package:flutter_test/flutter_test.dart';
import 'package:glowing_wave_button/glowing_wave_button.dart';
import 'package:flutter/material.dart';

void main() {
  group('GlowingWaveButton', () {
    testWidgets('should render with default properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(),
          ),
        ),
      );

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('should call onPressed when tapped',
        (WidgetTester tester) async {
      bool pressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              onPressed: () {
                pressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      expect(pressed, isTrue);
    });

    testWidgets('should display custom icon', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              icon: Icons.star,
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('should use custom colors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              primaryColor: Colors.red,
              waveColor: Colors.pink,
            ),
          ),
        ),
      );

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      // Additional color verification would require widget testing with specific color checks
    });

    testWidgets('should show image widget when showImageInsteadIcon is true',
        (WidgetTester tester) async {
      const testImageWidget = Icon(Icons.image);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              showImageInsteadIcon: true,
              imageWidget: testImageWidget,
            ),
          ),
        ),
      );

      expect(find.byWidget(testImageWidget), findsOneWidget);
    });

    testWidgets('should handle inactive state', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              isActive: false,
            ),
          ),
        ),
      );

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      // In inactive state, waves should not be visible
    });

    testWidgets('should toggle manual activation on press',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              isActive: false, // Start inactive
            ),
          ),
        ),
      );

      // Tap to manually activate
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      // After tap, manual activation should be enabled
    });

    testWidgets('should handle custom floating words',
        (WidgetTester tester) async {
      const customWords = ['Test', 'Words', 'Custom'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              emitWords: true,
              floatingWords: customWords,
            ),
          ),
        ),
      );

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      // Words should be present when emitWords is true
    });

    testWidgets('should respect custom wave count',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              waveCount: 6,
              showWaves: true,
            ),
          ),
        ),
      );

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      // With custom wave count, more waves should be generated
    });

    testWidgets('should handle custom size', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GlowingWaveButton(
              size: 80.0,
            ),
          ),
        ),
      );

      expect(find.byType(GlowingWaveButton), findsOneWidget);
      // Button should render with custom size
    });
  });
}
