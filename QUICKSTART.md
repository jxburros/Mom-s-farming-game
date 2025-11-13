# Quick Start Guide - Mom's Farming Game

Welcome to Mom's Farming Game! This guide will help you get started with your farming adventure.

## First Time Setup

### Desktop Testing (Recommended for Development)
1. Download and install [Godot Engine 4.3+](https://godotengine.org/download)
2. Clone or download this repository
3. Open Godot Engine
4. Click "Import" and navigate to the project folder
5. Select `project.godot` file
6. Click "Import & Edit"
7. Press **F5** or click the "Run" button to start the game

### Android Device
See [ANDROID_BUILD.md](ANDROID_BUILD.md) for detailed build instructions.

## Your First Day

### Starting the Game
When you start the game, you'll see:
- Your character (blue square) in the center
- 6 farm plots below you (brown squares)
- Time, day, and weather in the top-left corner
- Inventory and Crafting buttons in the top-right
- Save and Load buttons at the bottom-left

### Basic Controls

#### Desktop (for testing)
- **Movement**: WASD or Arrow Keys
- **Interact**: E or Spacebar
- **UI Navigation**: Mouse clicks

#### Mobile/Touch
- **Movement**: Tap anywhere on screen
- **Interact**: Tap on farm plots or NPCs
- **UI**: Tap buttons

### Your First Crops

#### Step 1: Till the Soil
1. Move near a farm plot (brown square)
2. Tap or click on it
3. The plot turns dark brown (tilled state)

#### Step 2: Plant Seeds
1. Tap the tilled plot again
2. A seed will be planted automatically (Wheat in v1.0)
3. The plot turns green

#### Step 3: Water Your Crop
1. Tap the planted plot
2. It will turn blue-green (watered state)
3. The crop will now grow

#### Step 4: Wait for Growth
- Wheat takes 3 days to grow
- Watch the day counter in the top-left
- Each new day, watered crops grow
- You'll need to water again each day until harvest

#### Step 5: Harvest
1. When the plot turns golden/yellow, it's ready!
2. Tap the plot to harvest
3. Crops are added to your inventory

## Using the Inventory

### Opening Inventory
1. Tap the "Inventory" button (top-right)
2. See all your collected items
3. Format: "Item Name x[Quantity]"

### Closing Inventory
- Tap the X button in the corner
- Or tap the Inventory button again

## Crafting Items

### Opening Crafting Menu
1. Tap the "Crafting" button (top-right)
2. See all available recipes
3. ✓ means you can craft it
4. ✗ means you need more ingredients

### Crafting Process
1. Select a recipe from the list
2. Tap the "Craft" button
3. If you have ingredients, item is crafted
4. Ingredients are consumed
5. New item appears in inventory

### Recipe List
- **Bread**: 3 Wheat
- **Salad**: 2 Carrots + 2 Tomatoes
- **Vegetable Soup**: 1 Carrot + 1 Tomato + 1 Wheat
- **Tomato Sauce**: 5 Tomatoes
- **Carrot Cake**: 4 Carrots + 2 Wheat

## Saving Your Game

### Manual Save
1. Tap "Save Game" button (bottom-left)
2. Game state is saved automatically
3. Continue playing

### Manual Load
1. Tap "Load Game" button (bottom-left)
2. Last saved state is restored
3. Everything returns to saved state

### What Gets Saved
- Your position
- Current time and day
- Weather
- All inventory items
- Farm plot states

## Day/Night Cycle

### Time Flow
- Time passes automatically
- 60 game minutes = 1 real second
- Full day = ~24 real minutes

### Day vs Night
- **Daytime** (6:00-19:59): Bright and clear
- **Nighttime** (20:00-5:59): Darker lighting
- Time shown in HUD (top-left)

### Daily Events
- Crops grow when watered
- NPCs reset daily interactions
- Weather may change

## Weather System

### Weather Types
- **Sunny**: Clear skies (most common)
- **Rainy**: Precipitation
- **Cloudy**: Overcast

### Effects
- Displayed in HUD
- Changes daily
- Currently cosmetic (may affect crops in future)

## Tips for Success

### Farming Tips
1. **Till multiple plots at once** - Save time by preparing several plots
2. **Water every day** - Crops only grow when watered
3. **Harvest promptly** - Make room for new crops
4. **Mix crop types** - Plant wheat, carrots, and tomatoes for crafting

### Time Management
1. **Use speed-up** - Crops grow overnight, so you can wait
2. **Save before experimenting** - Try things without losing progress
3. **Check time often** - Plan your day around the clock

### Inventory Management
1. **Craft regularly** - Free up space by crafting items
2. **Don't hoard** - Items stack to 99, no need to worry
3. **Check recipes** - Know what you need before harvesting

### Efficiency
1. **Group tasks** - Till all plots, then plant all, then water all
2. **Save frequently** - Don't lose progress
3. **Plan ahead** - Know which crops you need for recipes

## Common Questions

### Q: How do I choose which crop to plant?
**A**: In v1.0, crops auto-plant as Wheat. Future updates will add crop selection.

### Q: Can I speed up time?
**A**: Time passes automatically at 60x speed. You can wait or continue playing.

### Q: What happens at night?
**A**: Lighting dims, but you can continue farming. Some future NPCs may have schedules.

### Q: How do I know when crops are ready?
**A**: Ready crops turn golden/yellow. Also check the growth days in the crop info.

### Q: Can I move farm plots?
**A**: No, farm plots are fixed locations in v1.0.

### Q: Is there a limit to inventory?
**A**: Each item stacks to 99, but you can have unlimited item types.

### Q: Can I undo actions?
**A**: No direct undo, but you can load your last save.

### Q: Where is my save file?
**A**: `user://savegame.json` - location varies by platform:
- Windows: `%APPDATA%\Godot\app_userdata\[project_name]\`
- Linux: `~/.local/share/godot/app_userdata/[project_name]/`
- Android: Internal storage (protected)

## Troubleshooting

### Game won't start
- Ensure Godot 4.3+ is installed
- Check project.godot is in root folder
- Verify all script files are present

### Touch controls not working
- Check Settings → Input Devices
- Ensure "Emulate touch from mouse" is enabled
- Try restarting the game

### Farm plots not responding
- Move closer to the plot
- Ensure you're tapping/clicking the plot directly
- Check that scripts are properly loaded

### Inventory not updating
- Close and reopen inventory panel
- Check console for errors
- Save and reload game

### Save/Load not working
- Check file permissions
- Verify save directory exists
- Look for error messages in output console

## Next Steps

Once you're comfortable with the basics:

1. **Experiment with crafting** - Try all 5 recipes
2. **Plan efficient farms** - Optimize crop placement
3. **Track your progress** - See how many days you can survive
4. **Customize the game** - Edit scripts to modify gameplay (if you know GDScript)

## Getting Help

- Check [README.md](README.md) for project overview
- See [DESIGN.md](DESIGN.md) for game design details
- Review [ANDROID_BUILD.md](ANDROID_BUILD.md) for mobile deployment
- Check Godot documentation for engine questions
- Report issues on the repository

## Have Fun!

This game was created with love for Mom. Enjoy the relaxing farming experience!

---

**Remember**: There's no wrong way to play. Farm at your own pace, experiment with crops and crafting, and most importantly - have fun! 🌾❤️
