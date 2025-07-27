# Glowing Wave Button

A beautiful animated button widget with glowing wave effects and floating words for Flutter applications. Perfect for meditation, relaxation, and interactive UI elements.

![Glowing Wave Button Demo](https://raw.githubusercontent.com/Haraprosad/glowing_wave_button/refs/heads/main/assets/glowing_wave_only.gif)

## Features

- 🌊 **Animated Wave Effects**: Smooth ripple animations that emanate from the button
- ✨ **Floating Words**: Option to display floating words around the button instead of waves
- 🎨 **Customizable Colors**: Configure primary and wave colors to match your theme
- 📏 **Flexible Sizing**: Adjustable button size and animation parameters
- 🖼️ **Icon or Image Support**: Use built-in icons or custom image widgets
- 🔄 **State Management**: Manual activation and automatic state handling
- 🎭 **Breathing Animation**: Gentle scaling effect for a calming user experience

### Wave Effects
![Wave Effects Demo](https://raw.githubusercontent.com/Haraprosad/glowing_wave_button/refs/heads/main/assets/glowing_wave_only.gif)

### Floating Words Mode
![Floating Words Demo](https://raw.githubusercontent.com/Haraprosad/glowing_wave_button/refs/heads/main/assets/glowing_wave_demo.gif)

<!-- Add this when you have the button variations GIF -->
<!-- 
### Button Variations
![Button Variations Demo](https://raw.githubusercontent.com/Haraprosad/glowing_wave_button/refs/heads/main/assets/button_variations.gif)
-->

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  glowing_wave_button: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:flutter/material.dart';
import 'package:glowing_wave_button/glowing_wave_button.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GlowingWaveButton(
            onPressed: () {
              print('Button pressed!');
            },
          ),
        ),
      ),
    );
  }
}
```

### Advanced Usage

```dart
GlowingWaveButton(
  onPressed: () {
    // Handle button press
  },
  primaryColor: Colors.blue,
  waveColor: Colors.lightBlue,
  icon: Icons.favorite,
  size: 80.0,
  waveCount: 6,
  waveDuration: Duration(seconds: 3),
  isActive: true,
  showWaves: true,
  emitWords: true,
  floatingWords: ['Love', 'Peace', 'Joy', 'Hope'],
  containerSizeMultiplier: 4.0,
  expansionMultiplier: 2.5,
)
```

### Using Custom Image

```dart
GlowingWaveButton(
  onPressed: () {
    // Handle button press
  },
  showImageInsteadIcon: true,
  imageWidget: Image.asset(
    'assets/my_image.png',
    width: 30,
    height: 30,
  ),
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onPressed` | `VoidCallback?` | `null` | Callback function when button is pressed |
| `primaryColor` | `Color` | `Color(0xFF6B73FF)` | Primary color of the button |
| `waveColor` | `Color` | `Color(0xFF9BA3FF)` | Color of the wave animations |
| `icon` | `IconData` | `Icons.spa` | Icon to display in the button |
| `size` | `double` | `56.0` | Size of the button |
| `waveCount` | `int` | `4` | Number of wave ripples |
| `waveDuration` | `Duration` | `Duration(seconds: 4)` | Duration of wave animation cycle |
| `isActive` | `bool` | `true` | Whether the button is active |
| `showWaves` | `bool` | `true` | Whether to show wave animations |
| `emitWords` | `bool` | `false` | Whether to emit floating words instead of waves |
| `floatingWords` | `List<String>` | `['Peace', 'Calm', 'Breathe', 'Relax', 'Serenity']` | Words to display when `emitWords` is true |
| `containerSizeMultiplier` | `double` | `3.5` | Multiplier for container size |
| `expansionMultiplier` | `double` | `2.0` | Multiplier for wave expansion distance |
| `showImageInsteadIcon` | `bool` | `false` | Whether to show custom image instead of icon |
| `imageWidget` | `Widget` | `SizedBox.shrink()` | Custom image widget to display |

## Examples

### Meditation Button

```dart
GlowingWaveButton(
  onPressed: () => startMeditation(),
  primaryColor: Color(0xFF4CAF50),
  waveColor: Color(0xFF81C784),
  icon: Icons.self_improvement,
  emitWords: true,
  floatingWords: ['Breathe', 'Relax', 'Peace', 'Calm'],
)
```

### Like Button

```dart
GlowingWaveButton(
  onPressed: () => toggleLike(),
  primaryColor: Color(0xFFE91E63),
  waveColor: Color(0xFFF48FB1),
  icon: Icons.favorite,
  size: 48.0,
  waveCount: 3,
)
```

### Custom Themed Button

```dart
GlowingWaveButton(
  onPressed: () => performAction(),
  primaryColor: Theme.of(context).primaryColor,
  waveColor: Theme.of(context).primaryColor.withOpacity(0.6),
  icon: Icons.star,
  size: 64.0,
  containerSizeMultiplier: 4.0,
)
```

## Animation States

The button has several animation states:

- **Active**: Waves and breathing animations are running
- **Inactive**: No animations, dimmed appearance
- **Manual Activation**: User can toggle animations by pressing the button

## Performance

The widget is optimized for performance with:

- Efficient animation controllers
- Proper disposal of resources
- Conditional rendering based on animation states
- Minimal rebuilds using `AnimatedBuilder`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a list of changes.
