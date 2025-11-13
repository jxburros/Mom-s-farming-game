# Game Design Document - Mom's Farming Game

## Overview
A casual 2D farming RPG designed for mobile (Android) with simple touch controls and relaxing gameplay mechanics.

## Core Gameplay Loop
1. Player wakes up on Day 1
2. Tends to farm plots (till, plant, water, harvest)
3. Collects crops and stores in inventory
4. Interacts with NPCs to build relationships
5. Uses crafting system to create items from crops
6. Manages time through day/night cycle
7. Saves progress and continues next day

## Game Systems

### Player System
- **Movement**: Touch-based navigation
- **Speed**: 200 pixels/second (adjustable)
- **Sprite**: Simple colored rectangle (blue-ish)
- **Collision**: Basic collision detection for boundaries

### Farming System
The core mechanic of the game revolves around managing farm plots.

#### Farm Plot States
1. **Empty** (brown) - Can be tilled
2. **Tilled** (dark brown) - Ready for planting
3. **Planted** (green) - Crop is growing, needs water
4. **Watered** (blue-green) - Crop will grow next day
5. **Ready to Harvest** (golden) - Can be harvested

#### Crop Types
| Crop | Growth Time | Yield | Color |
|------|-------------|-------|-------|
| Wheat | 3 days | 2 | Yellow/Gold |
| Carrot | 4 days | 3 | Orange |
| Tomato | 5 days | 4 | Red |

#### Farming Interactions
- Tap empty plot → till soil
- Tap tilled plot → plant seeds (auto-selects wheat in v1.0)
- Tap planted plot → water crop
- Tap ready plot → harvest and add to inventory

### Inventory System
- Stores unlimited item types
- Each item can stack up to 99
- Tracks all collected crops and crafted items
- UI shows item name and quantity
- Items persist through save/load

### Crafting System
Combines crops to create useful items.

#### Recipes
1. **Bread**: 3 Wheat → 1 Bread
2. **Salad**: 2 Carrots + 2 Tomatoes → 1 Salad
3. **Vegetable Soup**: 1 Carrot + 1 Tomato + 1 Wheat → 1 Soup
4. **Tomato Sauce**: 5 Tomatoes → 2 Tomato Sauce
5. **Carrot Cake**: 4 Carrots + 2 Wheat → 1 Carrot Cake

#### Crafting Flow
1. Open crafting menu
2. View available recipes
3. Check if you have required ingredients (✓ or ✗)
4. Select recipe
5. Click "Craft" button
6. Ingredients consumed, crafted item added to inventory

### NPC System
Build relationships with villagers through interactions.

#### Relationship Levels
- **0-19**: Strangers
- **20-39**: Acquaintances
- **40-59**: Friends
- **60-79**: Good Friends
- **80-100**: Best Friends

#### Interactions
- **Daily Talk**: +5 relationship (once per day)
- **Gift (Loved)**: +20 relationship (Tomato, Wheat)
- **Gift (Liked)**: +10 relationship (Carrot)
- **Gift (Neutral)**: +5 relationship (other items)

### Time System
A dynamic day/night cycle that affects gameplay.

#### Time Scale
- 60 game minutes = 1 real second
- 24 hours = 24 real minutes per day
- Time displayed as HH:MM format

#### Day/Night Cycle
- **6:00-19:59**: Daytime (bright)
- **20:00-5:59**: Nighttime (darker with reduced visibility)

#### Lighting
- Gradual transition between day and night
- Canvas modulation adjusts color based on time
- Darker blue tint during night hours

### Weather System
Random weather patterns that add variety.

#### Weather Types
1. **Sunny** (50% chance) - Bright and clear
2. **Cloudy** (30% chance) - Overcast
3. **Rainy** (20% chance) - Precipitation

#### Weather Effects
- Changes daily
- Displayed in HUD
- Could affect crop growth in future updates

### Save/Load System
Persistent game state across sessions.

#### What Gets Saved
- Player position
- Current day, hour, and minute
- Current weather
- All inventory items and quantities
- Farm plot states (tilled, planted, crop type, growth progress)
- NPC relationship levels (in future updates)

#### Save File
- Location: `user://savegame.json`
- Format: JSON
- Auto-versioning for future compatibility

## User Interface

### HUD (Always Visible)
- **Top Left**:
  - Time display
  - Day counter
  - Weather indicator
- **Top Right**:
  - Inventory button
  - Crafting button
- **Bottom Left**:
  - Save button
  - Load button

### Inventory Panel (Toggle)
- Centered overlay panel
- Scrollable item list
- Shows item name and quantity
- Close button (X)

### Crafting Panel (Toggle)
- Centered overlay panel
- List of all recipes
- Visual indicator of craftability (✓/✗)
- Craft button
- Close button (X)

### Touch Controls
- Virtual joystick (optional, currently hidden)
- Direct touch-to-move (active)
- Touch-optimized buttons

## Performance Optimizations

### Rendering
- Mobile rendering mode enabled
- Compressed textures (ETC2)
- Sprite batching where possible
- Minimal draw calls

### Physics
- Simple kinematic body for player
- No complex physics calculations
- Static collision shapes

### Memory
- Efficient dictionary-based inventory
- Minimal resource loading
- Compressed assets

## Art Style
Currently using placeholder graphics (colored shapes).

### Future Art Direction
- Pixel art style (16x16 or 32x32 sprites)
- Bright, cheerful color palette
- Simple, readable UI
- Consistent sprite sizing

### Asset Sources (Planned)
- OpenGameArt.org
- Kenney.nl assets
- itch.io free assets
- Custom pixel art

## Audio (Planned)
### Music
- Relaxing background music
- Day/night variations
- Seasonal themes

### Sound Effects
- Footsteps
- Farming actions (till, plant, water, harvest)
- UI interactions
- Crafting sounds
- Weather ambiance

## Future Features

### High Priority
1. Crop selection menu (choose which crop to plant)
2. More NPCs with unique personalities
3. NPC daily routines and schedules
4. Sound effects and music
5. Better graphics with proper sprites
6. Tutorial/help system

### Medium Priority
1. Shop/market system
2. More crop varieties
3. Farm animals
4. Seasonal changes
5. Festivals and events
6. Quests/achievements
7. Farm expansion

### Low Priority
1. Multiplayer/social features
2. Mini-games
3. Fishing system
4. Mining system
5. Character customization
6. Multiple save slots

## Technical Specifications

### Platform Requirements
- **Minimum**: Android 5.0 (API 21)
- **Target**: Android 13 (API 33)
- **Architecture**: ARM64-v8a, ARMeabi-v7a
- **Storage**: ~20-30 MB

### Performance Targets
- **FPS**: 60 FPS on mid-range devices
- **Load Time**: < 3 seconds
- **RAM**: < 100 MB
- **Battery**: Minimal impact

### Screen Support
- **Portrait Mode**: 9:16 ratio (720x1280 base)
- **Landscape Mode**: Not supported (v1.0)
- **Screen Sizes**: Small to XLarge
- **DPI**: All densities supported

## Controls Reference

### Desktop (Testing)
- **WASD** or **Arrow Keys**: Move
- **E** or **Space**: Interact
- **Mouse**: Click UI buttons

### Mobile (Primary)
- **Touch**: Tap to move toward location
- **Touch**: Tap farm plots to interact
- **Touch**: Tap UI buttons

## Localization (Future)
Currently English-only, but designed for easy translation.

### Target Languages
1. English (current)
2. Spanish
3. French
4. German
5. Portuguese

## Accessibility (Future)
- Colorblind modes
- Adjustable text size
- Audio cues
- Simplified controls option

## Monetization (If Applicable)
Current version is free with no ads or in-app purchases.

### Potential Future Models
- Optional cosmetic items
- Tip jar / support developer
- Premium expansion packs
- No pay-to-win mechanics

## Credits & Attribution
- Engine: Godot 4.3 (MIT License)
- Code: Original implementation
- Assets: Placeholder (to be replaced with free/open-source assets)
- Inspired by: Stardew Valley, Harvest Moon, Animal Crossing

---

**Version**: 1.0
**Last Updated**: 2025-11-13
**Status**: In Development
