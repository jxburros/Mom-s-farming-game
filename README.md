# Mom's Farming Game

A 2D farming RPG created with love for Mom! This game features player movement, farming with multiple crop types, inventory management, NPC relationships, day/night cycles, weather systems, crafting, and save/load functionality.

## Features

### Core Gameplay
- **Player Movement**: Touch controls optimized for Android devices (also supports keyboard for testing)
- **Farming System**: Plant, water, and harvest 3 types of crops:
  - 🌾 Wheat (3 days to grow, yields 2)
  - 🥕 Carrot (4 days to grow, yields 3)
  - 🍅 Tomato (5 days to grow, yields 4)

### Game Systems
- **Inventory**: Manage collected items and crafted goods
- **Crafting**: Create useful items from harvested crops:
  - Bread (3 Wheat)
  - Salad (2 Carrots + 2 Tomatoes)
  - Vegetable Soup (1 Carrot + 1 Tomato + 1 Wheat)
  - Tomato Sauce (5 Tomatoes)
  - Carrot Cake (4 Carrots + 2 Wheat)
- **NPC Relationships**: Build friendships with villagers through daily interactions and gifts
- **Day/Night Cycle**: Dynamic lighting that changes throughout the day
- **Weather System**: Experience sunny, rainy, and cloudy weather
- **Save/Load System**: Save your progress and continue later

## Technology Stack

- **Engine**: Godot 4.3 (Free and Open Source)
- **Platform**: Android (with desktop support for development)
- **Assets**: All free/open-source (placeholder graphics using colored sprites)
- **Language**: GDScript

## How to Play

### Desktop Controls (for testing)
- **WASD** or **Arrow Keys**: Move player
- **E** or **Space**: Interact with farm plots and NPCs
- **Inventory Button**: Open/close inventory
- **Crafting Button**: Open/close crafting menu
- **Save/Load**: Save or load your game progress

### Mobile Controls
- **Touch**: Tap anywhere on screen to move player in that direction
- **UI Buttons**: Tap buttons to access inventory, crafting, and save/load features

### Farming Guide
1. **Till the soil**: Tap an empty farm plot
2. **Plant seeds**: Tap again to plant (currently auto-plants wheat)
3. **Water crops**: Tap the planted plot to water it
4. **Wait for growth**: Crops grow over multiple days
5. **Harvest**: When ready (golden color), tap to harvest

## Installation & Building

### Prerequisites
- Godot Engine 4.3 or later
- For Android builds: Android SDK with API level 33+

### Running the Game
1. Download and install [Godot Engine](https://godotengine.org/download)
2. Clone this repository
3. Open Godot Engine
4. Click "Import" and select the `project.godot` file
5. Click "Run" or press F5

### Building for Android
1. In Godot, go to **Project → Export**
2. Add "Android" export template if not already added
3. Configure Android build settings:
   - Set package name
   - Configure signing keys (for release builds)
4. Click "Export Project"
5. Install the APK on your Android device

## Project Structure

```
Mom-s-farming-game/
├── project.godot          # Main Godot project configuration
├── icon.png              # App icon
├── scenes/
│   └── main.tscn         # Main game scene
├── scripts/
│   ├── main.gd           # Main game controller
│   ├── player.gd         # Player movement and controls
│   ├── game_manager.gd   # Day/night cycle and weather
│   ├── inventory.gd      # Inventory system
│   ├── farm_plot.gd      # Individual farm plot logic
│   ├── npc.gd            # NPC relationship system
│   ├── crafting.gd       # Crafting recipes and logic
│   ├── save_load.gd      # Save/load functionality
│   └── ui_manager.gd     # UI controls and displays
├── resources/
│   ├── sprites/          # Game sprites (placeholder)
│   ├── fonts/            # Fonts for UI
│   └── sounds/           # Sound effects and music
└── README.md

```

## Development Notes

### Performance Optimizations
- Mobile rendering method enabled in project settings
- Efficient sprite batching for farm plots
- Minimal physics calculations
- Optimized for touch input

### Future Enhancements
- More crop varieties
- Additional NPCs with unique personalities
- Seasonal changes
- Farm animals
- Market/shop system
- More crafting recipes
- Mini-games
- Sound effects and background music
- Improved graphics with proper sprite sheets

## Credits

- **Engine**: Godot Engine (MIT License)
- **Assets**: Placeholder graphics created programmatically
- **Code**: Original implementation

## License

This project is released under the MIT License. See LICENSE file for details.

---

Made with ❤️ for Mom
