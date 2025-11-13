# Android Build Guide

This guide will help you build Mom's Farming Game for Android devices.

## Prerequisites

1. **Godot Engine 4.3+**
   - Download from: https://godotengine.org/download

2. **Android SDK**
   - Download Android Studio or command line tools
   - Install Android SDK Platform 33 (API Level 33)
   - Install Android SDK Build-Tools
   - Install Android SDK Platform-Tools

3. **Java Development Kit (JDK)**
   - JDK 11 or higher
   - Download from: https://adoptium.net/

## Setting Up Godot for Android Export

### Step 1: Configure Android SDK in Godot

1. Open Godot Engine
2. Go to **Editor → Editor Settings**
3. Navigate to **Export → Android**
4. Set the following paths:
   - **Android SDK Path**: Path to your Android SDK directory
     - Windows: `C:\Users\YourName\AppData\Local\Android\Sdk`
     - macOS: `~/Library/Android/sdk`
     - Linux: `~/Android/Sdk`
   - **Debug Keystore**: Godot will generate one automatically for debug builds
   - **Debug Keystore User**: `androiddebugkey` (default)
   - **Debug Keystore Pass**: `android` (default)

### Step 2: Install Android Build Template

1. In Godot, open your project
2. Go to **Project → Install Android Build Template**
3. Click "Install" - this creates the `android/` directory in your project

### Step 3: Configure Export Preset

1. Go to **Project → Export**
2. Click **Add...** and select **Android**
3. Configure the preset:
   - **Name**: "Android" (or any name you prefer)
   - **Runnable**: Check this box
   - **Export Path**: `builds/moms-farming-game.apk`

4. In the **Options** tab:
   - **Package → Unique Name**: `com.example.momsfarmgame` (change to your package name)
   - **Package → Name**: "Mom's Farming Game"
   - **Version → Code**: 1
   - **Version → Name**: "1.0"
   - **Architectures**: Enable `arm64-v8a` and `armeabi-v7a`
   - **Min SDK**: 21 (Android 5.0)
   - **Target SDK**: 33 (Android 13)
   - **Screen → Immersive Mode**: true

### Step 4: Export the Game

#### For Debug Build (Testing)
1. In the Export window, select your Android preset
2. Click **Export Project**
3. Choose location for the APK file
4. Click **Save**

#### For Release Build (Publishing)
1. Generate a release keystore:
   ```bash
   keytool -genkey -v -keystore release.keystore -alias moms_farm_key -keyalg RSA -keysize 2048 -validity 10000
   ```

2. In the Export preset options:
   - **Package → Signed**: Check this box
   - **Keystore → Release**: Path to your `release.keystore` file
   - **Keystore → Release User**: Your alias (e.g., `moms_farm_key`)
   - **Keystore → Release Password**: Your keystore password

3. Export as release build

## Installing on Android Device

### Method 1: USB Connection
1. Enable **Developer Options** on your Android device:
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
2. Enable **USB Debugging** in Developer Options
3. Connect device to computer via USB
4. In Godot's Export window, click **Export & Run**

### Method 2: APK File Transfer
1. Export the APK file to your computer
2. Transfer the APK to your Android device (email, cloud, USB, etc.)
3. On the device, enable **Install from Unknown Sources**:
   - Settings → Security → Unknown Sources (or Install Unknown Apps)
4. Open the APK file on your device
5. Follow installation prompts

## Testing on Android

### Touch Controls
- The game is optimized for touch input
- Tap anywhere on screen to move the player
- Tap UI buttons to access menus

### Performance Testing
- Test on various devices if possible
- Check frame rate and responsiveness
- Verify touch input works correctly

## Troubleshooting

### "Android SDK not found"
- Verify the Android SDK path in Editor Settings
- Make sure Android SDK Platform 33 is installed

### "Build Tools not found"
- Install Android SDK Build-Tools via Android Studio or SDK Manager
- Version 30.0.0 or higher recommended

### "Unable to install APK"
- Ensure USB debugging is enabled
- Check device is authorized (check prompt on device)
- Try uninstalling previous version first

### "App crashes on launch"
- Check logcat for error messages:
  ```bash
  adb logcat | grep Godot
  ```
- Verify all resources are included in export
- Check for missing scripts or assets

### Low Performance
- Enable **Mobile** rendering method (already set in project)
- Reduce screen resolution in project settings if needed
- Disable unnecessary visual effects

## Publishing to Google Play Store

1. Create a Google Play Developer account ($25 one-time fee)
2. Build a release APK with proper keystore
3. Create store listing with:
   - App description
   - Screenshots (multiple device sizes)
   - Feature graphic (1024x500px)
   - Icon (512x512px)
4. Set up pricing and distribution
5. Upload APK (or Android App Bundle)
6. Submit for review

## Tips for Optimization

- Keep total APK size under 100MB for better downloads
- Test on low-end devices (Android 5.0+)
- Use compressed textures (ETC2 format enabled by default)
- Profile performance using Android Studio Profiler
- Consider multiple APKs for different architectures if needed

## Additional Resources

- [Godot Android Documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)
- [Android Developer Guide](https://developer.android.com/)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer/)
