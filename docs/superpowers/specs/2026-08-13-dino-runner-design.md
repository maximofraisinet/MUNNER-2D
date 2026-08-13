# Specification Design: 2D Dino Runner with Object Pooling & Fair Spawn Math (Godot 4)

## 1. Overview
This document specifies the design for a 2D Endless Runner ("Dino Run style") game built in Godot Engine 4 (GDScript).
The project is optimized for low-end / legacy hardware using the `gl_compatibility` (OpenGL 3.0) renderer, pure `ColorRect` placeholder visual elements, object pooling to eliminate GC micro-stutters, and a mathematically guaranteed fair obstacle spawner system.

---

## 2. Architecture & Scene Hierarchy

### 2.1 Main Scene (`res://scenes/Main.tscn`)
- `Main` (`Node2D`) - Main game scene & manager orchestrator.
  - `Ground` (`StaticBody2D`) - World floor collision & visuals.
    - `ColorRect` - Visual representation of ground (green/brown placeholder).
    - `CollisionShape2D` - `RectangleShape2D` representing floor bounds.
  - `Player` (`CharacterBody2D`) - Player character controller (`res://scripts/player.gd`).
    - `ColorRect` - Visual representation of player (blue box).
    - `CollisionShape2D` - `RectangleShape2D` matching player size.
  - `ObstaclePool` (`Node2D`) - Spawner and pool manager (`res://scripts/obstacle_pool.gd`).
  - `UI` (`CanvasLayer`) - Screen overlays (`res://scripts/ui_manager.gd`).
    - `HUD` (`Control`)
      - `ScoreLabel` (`Label`) - Displays current score.
      - `SpeedLabel` (`Label`) - Displays current game speed.
      - `GameOverPanel` (`Panel`) - Displayed on player collision.

### 2.2 Obstacle Scene (`res://scenes/Obstacle.tscn`)
- `Obstacle` (`Area2D`) - Obstacle entity (`res://scripts/obstacle.gd`).
  - `ColorRect` - Visual representation of obstacle (red box).
  - `CollisionShape2D` - `RectangleShape2D` matching obstacle size.

---

## 3. Detailed Component Mechanics

### 3.1 Player Mechanics (`player.gd`)
- Class: `CharacterBody2D`
- Controls: Jump on `ui_accept` (Spacebar) or `ui_up` (Up Arrow).
- Jump Behavior: Fixed-height arcade jump.
- Parameters:
  - `gravity`: $2200.0 \text{ px/s}^2$
  - `jump_velocity`: $-750.0 \text{ px/s}$
- Air Hang Time ($T_{air}$):
  $$T_{air} = 2 \cdot \frac{|v_{jump}|}{g} = 2 \cdot \frac{750.0}{2200.0} \approx 0.6818 \text{ s}$$

### 3.2 Global Speed & Game Manager (`main.gd` / `game_manager.gd`)
- `initial_speed`: $400.0 \text{ px/s}$
- `speed_acceleration`: $12.0 \text{ px/s}^2$
- `current_speed`: $V_{game}(t) = V_{initial} + a \cdot t$
- `score`: Accumulated survival time or distance ($Score = \lfloor \text{elapsed\_time} \times 10 \rfloor$).

### 3.3 Object Pool & Fair Spawner (`obstacle_pool.gd`)
- Pre-allocates a fixed pool of $10$ `Obstacle` instances during `_ready()`.
- Active obstacles move left: $\Delta x = -V_{game} \cdot \Delta t$.
- Recycles obstacles when `global_position.x < -100.0`.
- **Fair Spawn Formula**:
  To guarantee every obstacle is physically jumpable:
  $$D_{min} = (V_{game} \times T_{air}) + W_{player} + W_{obstacle} + \text{margin}$$
  $$T_{min} = \frac{D_{min}}{V_{game}} = T_{air} + \frac{W_{player} + W_{obstacle} + \text{margin}}{V_{game}}$$
  Spawn timer duration:
  $$T_{spawn} = T_{min} + \text{randf\_range}(0.3, 1.2)$$

---

## 4. Performance & Low-End PC Strategy
1. **Renderer**: Enforce `rendering/renderer/rendering_method="gl_compatibility"` in `project.godot`.
2. **Allocation Zero-Stutter**: No `instantiate()` or `queue_free()` calls after initial loading phase.
3. **Collision Optimization**: Layers and masks strictly assigned (`Player` on layer 1, `Ground` on layer 2, `Obstacles` on layer 3).

---

## 5. Implementation Phases
1. **Phase 1: Project Settings**: Configure GL Compatibility renderer and input map.
2. **Phase 2: Player Script**: Implement physics, gravity, fixed jump, collision.
3. **Phase 3: Obstacle & Pool Manager**: Implement pre-allocated pool and movement.
4. **Phase 4: Spawner & Mathematical Guarantee**: Implement the $T_{min}$ formula.
5. **Phase 5: Game Manager & UI**: Wire up speed scaling, score, game over state.
