# Implementation Plan: Store Panel Loadout Bar & Simplified Boost Store Redesign

## Overview
Redesign the Godot 4 Endless Runner Store UI (`StorePanel`) to replace cramped dual-button boost cards with a dedicated Equipped Boost Loadout Header Bar (`LoadoutBarContainer`) and simplified Boost Store Cards with inventory stock guarding.

## Architecture Decisions
- Add `LoadoutBarContainer` (`VBoxContainer`) inside `$UI/StorePanel` positioned between the Character Scroll Container and the Boost Cards Container.
- Each Loadout Slot Card (`Slot1Card`, `Slot2Card`, `Slot3Card`) contains an internal `VBox` (`VBoxContainer`) holding `KeyLabel`, `IconRect`, and `QtyLabel`.
- Simplify Boost Store Cards (`ShieldBoostCard`, `LifeBoostCard`, `SlowBoostCard`, `FlyBoostCard`) to have a `BUY (1 COIN)` button and an `EQUIP` / `EQUIPPED` / `NO SLOTS` action button.
- Enforce inventory stock guarding: `EQUIP` button is disabled when owned quantity is 0.
- Synchronize all UI states via `CharacterManager` signals (`boost_inventory_changed`, `character_changed`) triggering `UIManager._update_all_ui()`.

## Task List

### Phase 1: Scene Hierarchy Update
- [ ] **Task 1: Update `Main.tscn` Scene Structure**
  - Add `LoadoutBarContainer` (`VBoxContainer`) with `LoadoutTitleLabel` and `LoadoutSlotsHBox`.
  - Add `Slot1Card`, `Slot2Card`, `Slot3Card` with internal `VBox` layout containers.
  - Re-align `BoostCardsHBox` buttons for clean single `BUY` and `EQUIP` flow.

### Checkpoint 1: Scene Hierarchy
- [ ] Godot Editor compiles scene without node path errors.

### Phase 2: Script Logic & UI Synchronization
- [ ] **Task 2: Update `ui_manager.gd` Script Logic**
  - Add `@onready` variable bindings for `LoadoutBarContainer` components.
  - Implement dynamic title string: `"EQUIPPED LOADOUT (CURRENT: %s)" % curr_char.display_name`.
  - Implement stock-guarded `EQUIP` button logic (`qty >= 1`).
  - Wire slot desequipping and equipping via `CharacterManager.equip_boost_to_slot()`.

### Checkpoint 2: Script Synchronization
- [ ] Headless Godot check passes with exit code 0.

### Phase 3: Runtime Verification & Persistence Check
- [ ] **Task 3: Run Engine Verification & Save persistence**
  - Verify headless reimport and scene loading.
  - Verify real-time slot state updating across character selection (`TIRED` vs `DEMON`).

### Checkpoint 3: Complete
- [ ] All verification criteria met.
