# Testing and Verification Guide

This document provides testing procedures to verify all game features are working correctly.

## Prerequisites

Before testing, ensure you have:
- Godot Engine 4.3 or later installed
- The project opened in Godot Editor
- All scripts compiled without errors

## Quick Verification Checklist

### ✅ Project Structure
- [ ] `project.godot` exists and is configured
- [ ] `scenes/main.tscn` exists
- [ ] All 9 script files in `scripts/` directory
- [ ] Icon files present (icon.png, icon.svg)
- [ ] Documentation files present (5 .md files)

### ✅ Script Compilation
Run in Godot Editor:
1. Open project in Godot
2. Check "Output" panel for errors
3. All scripts should load without errors

Expected: No syntax errors, all scripts compile successfully.

## Feature Testing

### 1. Player Movement

#### Desktop Test
1. Press F5 to run the game
2. Use WASD or Arrow keys to move
3. Player (blue square) should move in all directions
4. Movement should be smooth (200 px/sec)

#### Touch Test (if available)
1. Click anywhere on screen
2. Player should move toward click location
3. Works on both desktop (simulated) and Android

**Expected**: Player moves smoothly, responds to input immediately.

### 2. Farming System

#### Test Sequence
1. Run the game (F5)
2. Move player near a farm plot (brown square at bottom)
3. Click/tap the plot → Should turn dark brown (tilled)
4. Click/tap again → Should turn green (planted with wheat)
5. Click/tap again → Should turn blue-green (watered)
6. Wait for days to pass (or modify time in game_manager.gd)
7. When golden/yellow → Click to harvest

**Expected**: Plot transitions through states, crops added to inventory.

#### Three Crop Types Verification
Check `scripts/farm_plot.gd`:
- Wheat: 3 days, yield 2 ✅
- Carrot: 4 days, yield 3 ✅
- Tomato: 5 days, yield 4 ✅

Note: Current version auto-plants wheat. Crop selection UI is future enhancement.

### 3. Inventory System

#### Test Sequence
1. Harvest some crops (see farming test above)
2. Click "Inventory" button (top-right)
3. Panel should show "Wheat x2" (or similar)
4. Close with X button
5. Harvest more crops
6. Reopen inventory
7. Count should increase

**Expected**: Inventory tracks all items, persists during session.

### 4. Crafting System

#### Test Sequence
1. Harvest at least 3 wheat
2. Click "Crafting" button (top-right)
3. See list of 5 recipes
4. "Bread" should show ✓ (can craft)
5. Other recipes show ✗ (cannot craft)
6. Select "Bread"
7. Click "Craft" button
8. Check inventory: Wheat reduced by 3, Bread added

**Expected**: Recipes check ingredients, consume on craft, add result.

#### Verify All Recipes
Test each recipe:
- [ ] Bread: 3 Wheat → 1 Bread
- [ ] Salad: 2 Carrots + 2 Tomatoes → 1 Salad
- [ ] Vegetable Soup: 1 Carrot + 1 Tomato + 1 Wheat → 1 Soup
- [ ] Tomato Sauce: 5 Tomatoes → 2 Tomato Sauce
- [ ] Carrot Cake: 4 Carrots + 2 Wheat → 1 Carrot Cake

### 5. Day/Night Cycle

#### Visual Test
1. Run the game
2. Watch the time label (top-left)
3. Time should advance automatically
4. Watch the screen lighting
5. At night (20:00+), screen should darken
6. At day (6:00-19:59), screen should brighten

**Expected**: Time advances, lighting changes visibly.

#### Time Verification
- Check time updates every game minute
- Full day = ~24 real minutes (at 60x speed)
- Day counter increments at midnight (00:00)

### 6. Weather System

#### Test Sequence
1. Note current weather (top-left HUD)
2. Let multiple days pass
3. Weather should change randomly
4. Should see: Sunny, Cloudy, Rainy

**Expected**: Weather displays and changes daily.

#### Weather Distribution Check
Over 10+ days, should see:
- Sunny: ~50% of days
- Cloudy: ~30% of days
- Rainy: ~20% of days

### 7. Save/Load System

#### Test Sequence
1. Play the game for a while:
   - Move to specific location
   - Plant some crops
   - Harvest items
   - Advance time
2. Click "Save Game" button
3. Note current state (position, inventory, time, day)
4. Continue playing and change things
5. Click "Load Game" button
6. Verify everything returns to saved state

**Expected**: All game state preserved and restored.

#### What Should Be Saved
- [ ] Player position
- [ ] Current time (hour:minute)
- [ ] Current day number
- [ ] Current weather
- [ ] All inventory items
- [ ] Farm plot states (empty/tilled/planted/etc.)
- [ ] Crop growth progress

### 8. NPC System

Note: NPCs are not placed in the scene yet, but the system is implemented.

#### Code Verification
Check `scripts/npc.gd`:
- [ ] Relationship levels (0-100)
- [ ] Daily interaction (+5 relationship)
- [ ] Gift system (loved/liked items)
- [ ] Relationship tiers (Strangers → Best Friends)

**To Test in Future**: Add NPC node to scene, attach npc.gd script, call interact().

### 9. UI System

#### HUD Elements Test
Verify all HUD elements visible and functional:
- [ ] Time label (top-left) - updates
- [ ] Day label (top-left) - updates daily
- [ ] Weather label (top-left) - shows current weather
- [ ] Inventory button (top-right) - opens panel
- [ ] Crafting button (top-right) - opens panel
- [ ] Save button (bottom-left) - saves game
- [ ] Load button (bottom-left) - loads game

#### Panel Tests
Inventory Panel:
- [ ] Opens/closes on button click
- [ ] Shows all items with quantities
- [ ] Close button works
- [ ] Panel centered on screen

Crafting Panel:
- [ ] Opens/closes on button click
- [ ] Shows all 5 recipes
- [ ] ✓/✗ indicators correct
- [ ] Craft button works
- [ ] Close button works
- [ ] Panel centered on screen

### 10. Performance Test

#### Desktop Performance
1. Run game (F5)
2. Press F3 to show FPS counter (in Godot debug)
3. Should maintain 60 FPS consistently
4. Move player around
5. Open/close menus
6. FPS should stay stable

**Expected**: 60 FPS, no stuttering or lag.

#### Memory Check
- Monitor RAM usage during gameplay
- Should stay under 100 MB
- No memory leaks over extended play

### 11. Touch Controls Test

#### Simulated Touch (Desktop)
1. In Godot editor: Project Settings → Input Devices
2. Verify "Emulate touch from mouse" is enabled
3. Run game
4. Click anywhere on screen
5. Player should move toward click

**Expected**: Mouse clicks act as touch input.

#### Real Touch (Android)
After building APK:
1. Install on Android device
2. Tap screen to move
3. Tap UI buttons
4. All interactions should work
5. No need for keyboard

## Code Quality Checks

### Script Organization
- [ ] All scripts in `scripts/` directory
- [ ] Each system has its own script
- [ ] No duplicate code
- [ ] Clear naming conventions

### Documentation
- [ ] All scripts have header comments
- [ ] Complex functions have comments
- [ ] README.md complete
- [ ] QUICKSTART.md clear
- [ ] DESIGN.md comprehensive
- [ ] ANDROID_BUILD.md detailed
- [ ] IMPLEMENTATION.md thorough

### Godot Best Practices
- [ ] Uses `@onready` for node references
- [ ] Uses signals for communication
- [ ] `@export` for configurable values
- [ ] Type hints where appropriate
- [ ] Proper `extends` declarations

## Known Issues / Limitations

### Current Limitations
1. **Graphics**: Placeholder colored sprites (not final art)
2. **Crop Selection**: Auto-plants wheat (no UI for choosing crop)
3. **NPCs**: System ready but no NPCs in scene
4. **Animations**: Player has no walk/idle animations
5. **Audio**: No sound effects or music

### Not Bugs
These are intentional for v1.0:
- Simple graphics (placeholders)
- Limited crop selection
- No NPCs in scene yet
- Silent gameplay

## Troubleshooting Common Issues

### Game Won't Start
- Check Godot version (need 4.3+)
- Verify main scene path in project.godot
- Check Output panel for errors

### Player Won't Move
- Verify input map in project settings
- Check player script is attached
- Ensure CharacterBody2D node exists

### Farm Plots Not Responding
- Check plot nodes have Sprite2D children
- Verify plot positions in scene
- Move player closer to plots

### UI Not Showing
- Check UI CanvasLayer exists
- Verify ui_manager.gd attached
- Check button signals connected

### Save/Load Fails
- Check console for error messages
- Verify file permissions
- Check save file path is writable

## Success Criteria

The game passes testing if:
✅ All 9 core systems work as described
✅ No critical bugs or crashes
✅ Performance is acceptable (30+ FPS)
✅ Save/load preserves all state
✅ UI is functional and responsive
✅ Documentation is clear and accurate

## Next Steps After Testing

Once testing is complete:
1. Document any bugs found
2. Test on Android device (see ANDROID_BUILD.md)
3. Gather feedback
4. Plan improvements (better graphics, more features)
5. Consider publishing to Google Play Store

---

**Test Date**: ___________
**Tester**: ___________
**Godot Version**: ___________
**Result**: ☐ Pass ☐ Fail ☐ Needs Work
