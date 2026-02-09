# 📱 Reels Page - UIKit

A full-screen vertical video feed application built with UIKit, mimicking the popular reels/stories feature found in social media apps like Instagram and TikTok.

![Platform](https://img.shields.io/badge/platform-iOS-lightgrey)
![Language](https://img.shields.io/badge/language-Swift-orange)
![Framework](https://img.shields.io/badge/framework-UIKit-blue)
![UI](https://img.shields.io/badge/UI-Storyboard-green)

---

## 📋 Table of Contents

- [Features](#features)
- [Requirements](#requirements)
- [Project Structure](#project-structure)
- [Architecture & Flow](#architecture--flow)
- [Installation](#installation)
- [Code Explanation](#code-explanation)
- [How It Works](#how-it-works)
- [Customization](#customization)
- [Known Issues](#known-issues)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## ✨ Features

- ✅ **Full-screen vertical video feed** - Immersive viewing experience
- ✅ **Swipe up/down navigation** - Natural gesture-based navigation
- ✅ **Auto-play/pause** - Videos automatically play when visible
- ✅ **Video looping** - Seamless continuous playback
- ✅ **Pagination** - One video per screen with smooth transitions
- ✅ **Social interactions** - Like, comment, share buttons
- ✅ **User information display** - Profile picture, username, and caption
- ✅ **Formatted counts** - Numbers displayed as 12.5K, 1.2M format
- ✅ **Memory efficient** - Proper cell reuse and resource cleanup

---

## 📱 Requirements

- **iOS:** 13.0+
- **Xcode:** 14.0+
- **Swift:** 5.0+
- **Device:** iPhone (Portrait orientation)

---

## 📁 Project Structure

```
ReelsPageUIKit/
│
├── Models/
│   └── ReelCell.swift              # Data model for reels
│
├── Views/
│   ├── Main.storyboard             # UI design
│   └── ReelCollectionViewCell.swift # Custom collection view cell
│
├── Controllers/
│   └── ReelsViewController.swift    # Main view controller
│
├── Supporting Files/
│   ├── SceneDelegate.swift
│   ├── AppDelegate.swift
│   └── Info.plist
│
└── README.md
```

---

## 🏗️ Architecture & Flow

### **Design Pattern:**
This project follows the **MVC (Model-View-Controller)** architecture pattern:

```
┌─────────────────────────────────────────────────────┐
│                       USER                          │
│                   (Interacts)                       │
└──────────────────────┬──────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────┐
│                  VIEW LAYER                         │
│  ┌──────────────────────────────────────────────┐  │
│  │          Main.storyboard                     │  │
│  │  - Collection View (Full Screen)             │  │
│  │  - ReelCell Design                           │  │
│  │  - UI Elements (Buttons, Labels, ImageViews) │  │
│  └──────────────────────────────────────────────┘  │
└──────────────────────┬──────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────┐
│               CONTROLLER LAYER                      │
│  ┌──────────────────────────────────────────────┐  │
│  │      ReelsViewController.swift               │  │
│  │  - Manages Collection View                   │  │
│  │  - Handles scroll events                     │  │
│  │  - Controls video playback                   │  │
│  │  - Data source & delegate methods            │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │    ReelCollectionViewCell.swift              │  │
│  │  - AVPlayer setup                            │  │
│  │  - Video playback control                    │  │
│  │  - UI updates                                │  │
│  └──────────────────────────────────────────────┘  │
└──────────────────────┬──────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────┐
│                  MODEL LAYER                        │
│  ┌──────────────────────────────────────────────┐  │
│  │           Reel.swift (Struct)                │  │
│  │  - id: String                                │  │
│  │  - videoURL: String                          │  │
│  │  - username: String                          │  │
│  │  - userProfileImage: String                  │  │
│  │  - caption: String                           │  │
│  │  - likes: Int                                │  │
│  │  - comments: Int                             │  │
│  │  - getSampleReels() -> [Reel]                │  │
│  └──────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────┘
```

### **Application Flow:**

```
App Launch
    ↓
SceneDelegate
    ↓
ReelsViewController loads
    ↓
viewDidLoad() called
    ↓
1. setupCollectionView()
   - Set delegate & dataSource
   - Enable paging
   - Hide scroll indicators
    ↓
2. loadReels()
   - Fetch sample data
   - Reload collection view
    ↓
3. Collection View renders cells
    ↓
cellForItemAt() called for each visible cell
    ↓
ReelCollectionViewCell.configure(with: reel)
    ↓
1. Set username, caption, likes, comments
2. setupVideoPlayer(with: url)
   - Create AVPlayer
   - Create AVPlayerLayer
   - Add to videoContainerView
   - Setup loop notification
    ↓
viewDidAppear() called
    ↓
playCurrentVideo() - Start playing first video
    ↓
┌─────────────────────────────────────────┐
│          USER INTERACTION               │
│                                         │
│  User swipes up/down                    │
│         ↓                               │
│  scrollViewDidEndDecelerating()         │
│         ↓                               │
│  Calculate new page index               │
│         ↓                               │
│  pauseCurrentVideo()                    │
│         ↓                               │
│  currentIndex = pageIndex               │
│         ↓                               │
│  playCurrentVideo()                     │
│         ↓                               │
│  New video plays                        │
└─────────────────────────────────────────┘
```

---

## 🚀 Installation

### **Step 1: Clone the Repository**
```bash
git clone https://github.com/yourusername/ReelsPageUIKit.git
cd ReelsPageUIKit
```

### **Step 2: Open in Xcode**
```bash
open ReelsPageUIKit.xcodeproj
```

### **Step 3: Configure Info.plist**
Add the following to allow HTTP video loading (for testing):

```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```

### **Step 4: Run**
- Select a simulator or device
- Press `Cmd + R` or click the Run button

---

## 💻 Code Explanation

### **1. Reel Model (ReelCell.swift)**

```swift
struct Reel {
    let id: String              // Unique identifier for each reel
    let videoURL: String         // URL of the video to play
    let username: String         // Username of the content creator
    let userProfileImage: String // Profile image (SF Symbol for now)
    let caption: String          // Video caption/description
    let likes: Int              // Number of likes
    let comments: Int           // Number of comments
}
```

**Purpose:** 
- Defines the data structure for each reel
- Encapsulates all information needed to display a reel
- Provides sample data for testing via `getSampleReels()`

**Why struct instead of class?**
- Reels are value types (immutable data)
- No need for inheritance
- Better performance for simple data models

---

### **2. ReelCollectionViewCell - Video Player Setup**

```swift
private func setupVideoPlayer(with url: URL) {
    // Create AVPlayer instance with the video URL
    player = AVPlayer(url: url)
    
    // Create AVPlayerLayer to display video content
    playerLayer = AVPlayerLayer(player: player)
    playerLayer?.frame = videoContainerView.bounds
    playerLayer?.videoGravity = .resizeAspectFill  // Fill screen without black bars
    
    // Add player layer to the video container view
    if let playerLayer = playerLayer {
        videoContainerView.layer.insertSublayer(playerLayer, at: 0)
    }
    
    // Setup video looping notification
    NotificationCenter.default.addObserver(
        self,
        selector: #selector(videoDidEnd),
        name: .AVPlayerItemDidPlayToEndTime,
        object: player?.currentItem
    )
}
```

**Detailed Explanation:**

1. **AVPlayer:** 
   - Core media playback engine from AVFoundation
   - Manages video loading, buffering, and playback
   - Can play local or remote videos

2. **AVPlayerLayer:**
   - Visual component that displays video frames
   - Acts as a CALayer subclass
   - Must be added to a view's layer hierarchy to be visible

3. **videoGravity = .resizeAspectFill:**
   - Scales video to fill the entire view
   - Maintains aspect ratio
   - Crops edges if necessary (better than black bars)

4. **insertSublayer(at: 0):**
   - Adds player layer at the bottom of layer stack
   - Ensures UI elements (buttons, labels) appear on top

5. **NotificationCenter Observer:**
   - Listens for video completion event
   - Triggers `videoDidEnd()` method
   - Enables seamless looping

---

### **3. Video Looping Implementation**

```swift
@objc private func videoDidEnd() {
    player?.seek(to: .zero)  // Reset playback to beginning
    player?.play()           // Start playing again
}
```

**Explanation:**
- `seek(to: .zero)` rewinds video to 0:00
- `play()` resumes playback
- Creates infinite loop effect
- No visible gap between loops

---

### **4. Cell Reuse and Memory Management**

```swift
override func prepareForReuse() {
    super.prepareForReuse()
    stopPlayback()                          // Pause video
    player = nil                            // Release player
    playerLayer?.removeFromSuperlayer()     // Remove layer
    playerLayer = nil                       // Release layer
}
```

**Why is this critical?**

Collection view cells are **reused** to save memory. Without proper cleanup:
- ❌ Multiple videos would play simultaneously
- ❌ Memory leaks (players not deallocated)
- ❌ Layers pile up on top of each other
- ❌ App crashes from excessive memory usage

**What happens:**
1. User scrolls → Cell goes off-screen
2. `prepareForReuse()` called automatically
3. Video stops, resources released
4. Cell ready to display new content
5. `configure(with:)` called with new data

---

### **5. Pagination and Playback Control**

```swift
func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    // Calculate which page is currently visible
    let pageIndex = Int(scrollView.contentOffset.y / scrollView.frame.height)
    
    if pageIndex != currentIndex {
        // Stop previous video
        pauseCurrentVideo()
        
        // Update current index
        currentIndex = pageIndex
        
        // Play new video
        playCurrentVideo()
    }
}
```

**Breakdown:**

1. **scrollViewDidEndDecelerating:**
   - Called when user stops scrolling
   - Scroll has come to a complete stop
   - Perfect time to update playback state

2. **contentOffset.y / frame.height:**
   - `contentOffset.y`: How far scrolled vertically (in points)
   - `frame.height`: Height of one screen
   - Division gives page number (0, 1, 2, etc.)

3. **Example Math:**
   - Screen height = 852 points
   - User scrolls to 1704 points
   - Page index = 1704 / 852 = 2
   - Now showing page 2 (third video)

4. **Conditional Check:**
   - Only updates if page actually changed
   - Prevents unnecessary operations
   - Optimizes performance

---

### **6. Collection View Cell Sizing**

```swift
func collectionView(_ collectionView: UICollectionView,
                    layout collectionViewLayout: UICollectionViewLayout,
                    sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width,
                  height: collectionView.frame.height)
}
```

**Purpose:**
- Makes each cell **exactly** the size of the screen
- Enables full-screen experience
- Works dynamically on all iPhone sizes

**Why dynamic sizing?**
```
iPhone 13 Mini:  375 x 812
iPhone 13/14:    390 x 844
iPhone 14 Pro:   393 x 852
iPhone 14 Pro Max: 430 x 932
```
Using `collectionView.frame` automatically adapts!

---

### **7. Number Formatting**

```swift
private func formatCount(_ count: Int) -> String {
    if count >= 1000000 {
        return String(format: "%.1fM", Double(count) / 1000000.0)
    } else if count >= 1000 {
        return String(format: "%.1fK", Double(count) / 1000.0)
    } else {
        return "\(count)"
    }
}
```

**Conversion Examples:**
```
1,234       → 1.2K
12,500      → 12.5K
156,789     → 156.8K
1,200,000   → 1.2M
15,200,000  → 15.2M
```

**Format String Explained:**
- `%.1f` = Floating point with 1 decimal place
- `M` = Million suffix
- `K` = Thousand suffix

---

### **8. Content Inset Adjustment**

```swift
collectionView.contentInsetAdjustmentBehavior = .never
```

**What it does:**
- Prevents iOS from automatically adding safe area padding
- Ensures video extends to screen edges
- Required for true full-screen experience

**Without this:**
```
┌─────────────────┐
│  Safe Area Gap  │ ← Unwanted white space
├─────────────────┤
│                 │
│     Video       │
│                 │
├─────────────────┤
│  Safe Area Gap  │ ← Unwanted white space
└─────────────────┘
```

**With this:**
```
┌─────────────────┐
│                 │
│                 │
│  Full Screen    │
│     Video       │
│                 │
│                 │
└─────────────────┘
```

---

## 🔄 How It Works

### **Complete User Flow:**

```
1. App Launches
   └─→ ReelsViewController loads
   
2. First Load
   └─→ Fetch sample reels data
   └─→ Collection view displays cells
   └─→ First video auto-plays
   
3. User Swipes Up
   └─→ Collection view scrolls
   └─→ Paging snaps to next cell
   └─→ Scroll stops (deceleration ends)
   └─→ System calls: scrollViewDidEndDecelerating()
   └─→ Calculate new page index
   └─→ Pause previous video
   └─→ Update currentIndex
   └─→ Play new video
   
4. Cell Goes Off-Screen
   └─→ System calls: prepareForReuse()
   └─→ Stop video playback
   └─→ Release player & layer
   └─→ Cell ready for reuse
   
5. Cell Becomes Visible Again
   └─→ System calls: cellForItemAt()
   └─→ Dequeue reused cell
   └─→ Call: configure(with: reel)
   └─→ Setup new video player
   └─→ Load new data
   
6. Video Ends
   └─→ NotificationCenter fires
   └─→ System calls: videoDidEnd()
   └─→ Seek to beginning
   └─→ Play again (loop)
```

---

## 🎨 Customization

### **Change Video Sources**

Edit `Reel.swift`:
```swift
static func getSampleReels() -> [Reel] {
    return [
        Reel(id: "1",
             videoURL: "YOUR_VIDEO_URL_HERE",
             username: "your_username",
             userProfileImage: "person.circle.fill",
             caption: "Your caption here",
             likes: 1000,
             comments: 50)
    ]
}
```

### **Modify UI Colors**

In `ReelCollectionViewCell.swift`:
```swift
private func setupUI() {
    profileImageView.layer.borderColor = UIColor.systemPink.cgColor  // Change border color
    profileImageView.layer.borderWidth = 3  // Change border width
}
```

### **Add More Buttons**

1. Add button in Storyboard
2. Create IBOutlet in `ReelCollectionViewCell.swift`
3. Create IBAction for button tap
4. Connect in Storyboard

### **Change Cell Sizing**

Modify in `ReelsViewController.swift`:
```swift
func collectionView(..., sizeForItemAt...) -> CGSize {
    // Custom size (not recommended for full-screen)
    return CGSize(width: 350, height: 700)
}
```
 
