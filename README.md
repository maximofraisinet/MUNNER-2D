# MUNNER 2D

MUNNER 2D is a fast-paced, feature-packed 2D endless runner developed with Godot Engine 4. It combines classic arcade obstacle-dodging mechanics with an RPG-style perk inventory, multiple unlockable characters with unique stats, an in-game store, an achievement ladder, and casino betting minigames.

---
## Captures

<img width="1152" height="646" alt="Screenshot_20260815_225859" src="https://github.com/user-attachments/assets/ae28989b-9ac6-4ac0-b9ab-a98799190968" />


<img width="16383" height="960" alt="carrusel-like" src="https://github.com/user-attachments/assets/1f430b31-1120-4a2c-bde9-1b6bc3f8e90c" />

## Gameplay

https://github.com/user-attachments/assets/e5d7cf85-a330-41e4-b573-43c6630a234e

---

## Table of Contents

1. Overview
2. Core Gameplay Mechanics
3. Characters and Abilities
4. Power-Up and Inventory System
5. Casino and Minigames
6. Achievements and Progression
7. Audio and Customization
8. Controls
9. Installation and Running
10. Building from Source
11. Architecture and Performance
12. License

---

## 1. Overview

In MUNNER 2D, players control a runner navigating an endless track filled with ground obstacles, coins, and special power-ups. The game features an asymptotic speed-scaling curve designed to maintain fair reaction windows at high scores while providing a steady increase in challenge.

Collected coins can be spent in the in-game store to unlock characters, purchase consumable perk cards, customize visual themes, or wager coins in the casino minigames.

---

## 2. Core Gameplay Mechanics

- **Physics-Based Jump Control**: Variable jump height based on input duration, optimized for precise obstacle clearance.
- **Dynamic Decaying Acceleration Curve**: Unlike linear runners where difficulty spikes uncontrollably, MUNNER 2D utilizes a non-linear acceleration decay model. The game starts at 400 px/s, scales smoothly through mid-game (reaching approximately 1,500 px/s at 2,000 score), and approaches a top speed cap of 1,800 px/s.
- **Fair Reaction Window ($T_{min}$)**: Obstacle spawner intervals dynamically recalculate minimum reaction distance based on real-time runner velocity.
- **High-Performance Object Pooling**: Obstacles, coins, and power-ups are recycled from pre-allocated memory pools, eliminating garbage collection stutter during high-speed runs.

---

## 3. Characters and Abilities

The game includes nine playable characters, each featuring distinctive attributes, coin multipliers, jump profiles, and perk slot capacities:

| Character | Perk Slots | Coin Multiplier | Jump Gravity | Description |
|---|---|---|---|---|
| Tired | 0 | 1.0x | Standard | The default balanced runner. |
| Leech | 0 | 1.2x | Standard | Slightly higher coin earnings. |
| Maximo | 0 | 1.5x | Agile | Enhanced agility and boosted coin earnings. |
| Omablo | 0 | 2.0x | Heavy | High coin collection rate with heavier jump physics. |
| Ignacho | 1 | 2.0x | Agile | Unlocks perk slot 1 with +80% Fly rate but +150% speed debuffs. |
| Demon | 1 | 3.0x | Floaty | Unlocks active perk inventory slot 1. |
| Messi | 2 | 4.0x | High Agility | World-champion runner with 2 perk loadout slots. |
| Dark Angel | 3 | 4.0x | Low Gravity | Extended hangtime and 3 boost slots. |
| Demon Messi | 3 | 4.0x | Ultimate | The apex runner equipped with all 3 perk slots. |

---

## 4. Power-Up and Inventory System

### In-Run Power-Ups
- **Shield**: Grants temporary invulnerability against obstacle collisions (lasts 20 seconds or until hit).
- **2X Coin Multiplier**: Doubles the value of all collected coins for 20 seconds with an on-screen HUD countdown.
- **Extra Life**: Stores a reserve life that prevents death upon obstacle impact.
- **Slow Down**: Temporarily reduces running speed by 50% to navigate dense obstacle fields.
- **Flight**: Propels the character above ground level while spawning a trail of high-value coins.
- **Speed Boost**: Provides high-velocity forward momentum.

### Tactical Loadout System
Characters with available perk slots can equip purchased consumable boosts from the store before running. During gameplay, pressing hotkeys **[1]**, **[2]**, or **[3]** consumes the equipped perk on demand to escape dangerous obstacle configurations.

---

## 5. Casino and Minigames

Players can test their luck in the casino panel using their earned coin bankroll:

### Lucky Slots
A 3-reel mechanical slot machine with weighted payout tables:
- Cherries (3x), Lemons (5x), Bells (10x), Diamonds (25x), Crowns (50x), and 777 Jackpot (100x).
- Pair matches award 1.5x payout.
- Calibrated with a realistic house edge (~91.5% RTP).

### Coin Flip
A high-stakes 50/50 prediction game (Heads or Tails):
- 48% Win probability (pays 1.95x).
- 48% Loss probability.
- 4% Star Edge (the coin lands on edge, house takes the pot).

### Mines (Bustabit / Stake Style)
A 5x5 grid containing 22 hidden gems and 3 hidden explosive mines:
- Each safe gem uncovered increases the cashout multiplier (1.15x, 1.35x, 1.62x, up to 100x+).
- Players can cash out accumulated winnings at any point.
- Uncovering a mine triggers a detonation and forfeits the initial bet.

---

## 6. Achievements and Progression

- **Milestone Ladder**: Progressive achievements for reaching high score thresholds (100, 250, 500, 1,000, 2,000, 5,000+ points).
- **Claimable Coin Rewards**: Completing milestones awards substantial coin packages.
- **Persistent Storage**: High scores, total coins, character unlocks, and inventory stock are automatically saved to disk using encrypted/structured configuration storage.

---

## 7. Audio and Customization

- **Curated Multi-Genre Playlists**:
  - Electro Playlist
  - Hardcore Playlist
  - Epic Orchestral Playlist
  - Argenta Rock Playlist
- **High-Fidelity Audio Compression**: Music tracks are encoded using VBR Q2 joint-stereo for pristine audio fidelity at minimal disk overhead.
- **Visual Customization**:
  - UI Themes: Light and Dark mode options.
  - Icon Packs: Default and Argenta custom power-up icons.
  - Background Environments: Multiple parallax backdrop themes.

---

## 8. Controls

| Action | Default Keybinding | Alternative |
|---|---|---|
| Jump | Spacebar | Up Arrow / Left Mouse Button / Custom Rebind |
| Activate Perk Slot 1 | Key 1 | Numpad 1 |
| Activate Perk Slot 2 | Key 2 | Numpad 2 |
| Activate Perk Slot 3 | Key 3 | Numpad 3 |
| Close Modals / Menu | Escape | Click Backdrop |

*Note: Jump bindings can be rebound to any keyboard key or mouse button in the Settings menu.*

---

## 9. Installation and Running

Pre-compiled, standalone binaries for both Linux and Windows are available for direct download under the repository's **Releases** tab.

### Linux (AppImage)
Download `MUNNER_2D-x86_64.AppImage` from the latest Release, mark it executable, and run:
```bash
chmod +x MUNNER_2D-x86_64.AppImage
./MUNNER_2D-x86_64.AppImage
```

### Windows (.exe)
Download `MUNNER_2D.exe` or extract `MUNNER_2D-Windows-x86_64.zip` from the latest Release and double-click `MUNNER_2D.exe`. The game runs out of the box with zero external runtime dependencies.

---

## 10. Building from Source

### Prerequisites
- Linux OS (Ubuntu, Debian, Fedora, Arch, etc.)
- Godot Engine 4 (v4.7.1-stable or compatible 4.x binary)
- Standard Unix utilities (`bash`, `curl`, `unzip`, `zip`)

### Automated Build Scripts

1. **Build Linux AppImage**:
```bash
./build_appimage.sh
```
This exports the `.pck` package, configures the `AppDir` launcher and desktop entry, downloads `appimagetool`, and bundles `MUNNER_2D-x86_64.AppImage`.

2. **Build Windows Executable**:
```bash
./build_windows_exe.sh
```
This installs the official Windows export templates, compiles a self-contained embedded `MUNNER_2D.exe`, and packages `MUNNER_2D-Windows-x86_64.zip`.

---

## 11. Architecture and Performance

- **Engine Version**: Godot Engine 4.7.1 Stable
- **Renderer**: `gl_compatibility` (OpenGL 3.3 / GLES3) ensuring fluid 60 FPS performance on both integrated GPUs and dedicated graphics cards.
- **Language**: GDScript 2.0 with static typing annotations.
- **Audio Pipeline**: Dedicated `SoundManager` and `MusicManager` singletons with cross-fade volume controls and independent audio buses.

---

## 12. License

All source code and game scripts are released under the MIT License.
