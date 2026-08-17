# Specification Design: Slide Mechanic, Fast-Fall & Aerial Drone Obstacles for MUNNER 2D

## 1. Overview & Goals
This specification details the technical architecture and gameplay mechanics for:
1. **Slide Mechanic (`slide`)**: A ground-level evasive maneuver that temporarily halves the player's hitbox height for $0.55\text{ s}$, allowing the runner to slide under elevated hazards.
2. **Fast-Fall / Stomp (Air Control)**: An airborne downward velocity boost when pressing `slide` mid-air, allowing swift recovery to the ground to immediately slide under incoming aerial obstacles.
3. **Aerial Drone Obstacle (`AERIAL_DRONE`)**: An elevated hazard spawned at head height ($Y \approx 470\text{ px}$) that collides with standing or jumping players but allows sliding runners to pass safely underneath.
4. **Performance & Low-End Hardware Constraints**: 100% pre-allocated object pooling (zero heap allocations at runtime), simple AABB collision rectangles, lightweight mathematical oscillation (`sin(time)`), and zero GPU-heavy shaders.

---

## 2. Input System & Controls

### 2.1 Input Actions
- Action name: `"slide"`
- Default event bindings in `InputMap`:
  - `KEY_S` (Physical key S)
  - `KEY_DOWN` (Down arrow key)
  - Custom configurable mapping supported in `Settings` menu.

---

## 3. Player Movement & Hitbox Dynamics (`scripts/player.gd`)

### 3.1 States & Variables
- `is_sliding: bool = false`
- `slide_timer: float = 0.0`
- `slide_duration: float = 0.55`
- `slide_cooldown_timer: float = 0.0`
- `slide_cooldown: float = 0.1`

### 3.2 Hitbox Modulation
- **Normal Standing Shape**:
  - Size: $50 \times 70\text{ px}$
  - Center: `Vector2(0, 0)`
  - Top of head: $Y \approx 510\text{ px}$ (relative to ground $Y = 545\text{ px}$)
- **Sliding Shape**:
  - Size: $50 \times 32\text{ px}$
  - Center offset: `Vector2(0, 19)` (lowered so feet align with ground level $Y = 545\text{ px}$)
  - Top of head: $Y \approx 540\text{ px}$ (leaving clearance from $Y = 0$ to $Y = 530\text{ px}$)

### 3.3 Movement Logic
1. **Ground Slide**:
   - Condition: `is_on_floor() and Input.is_action_just_pressed("slide") and slide_cooldown_timer <= 0.0`.
   - Action:
     - Sets `is_sliding = true`, `slide_timer = slide_duration`.
     - Updates `CollisionShape2D.shape.size` and `CollisionShape2D.position`.
     - Applies kinetic tilt: `sprite.rotation_degrees = -30.0`, `sprite.scale.y *= 0.65`, `sprite.scale.x *= 1.25` (or assigns `current_character.slide_frame` if defined).
     - Plays subtle slide friction audio.
2. **Fast-Fall (Airborne)**:
   - Condition: `not is_on_floor() and Input.is_action_just_pressed("slide")`.
   - Action:
     - Overrides vertical velocity: `velocity.y = max(velocity.y, 1300.0)`.
     - Ensures player rapidly hits the ground, queueing or instantly transitioning to a slide upon floor contact.

---

## 4. Aerial Drone Obstacle & Pooling Architecture

### 4.1 Obstacle Types
In `scripts/obstacle.gd`:
```gdscript
enum ObstacleType { GROUND, AERIAL_DRONE }
var obstacle_type: ObstacleType = ObstacleType.GROUND
```

### 4.2 Scene & Visual Layout (`scenes/Obstacle.tscn`)
- `Obstacle` (`Area2D` on layer 3, mask 1):
  - `Sprite2D`: Displays obstacle texture.
  - `CollisionShape2D`: `RectangleShape2D`.
- For `GROUND`:
  - Size: $34 \times 52\text{ px}$
  - Position: $Y = 558.0\text{ px}$ (ground level).
- For `AERIAL_DRONE`:
  - Size: $42 \times 36\text{ px}$
  - Base Position: $Y = 475.0\text{ px}$ (leaving $>40\text{ px}$ clearance above the floor).
  - Micro-floating animation in `_process(delta)`:
    `global_position.y = base_y + sin(time_accum * 6.0) * 3.0` (zero allocation, negligible CPU cost).

### 4.3 Obstacle Spawner Rhythm (`scripts/obstacle_pool.gd`)
- `ObstaclePool` pool size: Pre-allocated 16 instances.
- Spawner randomly alternates between `GROUND` and `AERIAL_DRONE`:
  - $65\%$ Ground obstacle (Jump challenge).
  - $35\%$ Aerial Drone (Slide challenge).
- Guaranteed fair reaction distance ($T_{min}$) calculated dynamically based on current game velocity.
- Coin placement cues:
  - Ground obstacles feature high overhead coin arcs.
  - Aerial drones feature low ground-level coin trails that reward sliding through.

---

## 5. Audio & Game Feel
- **Slide Audio**: Short, crisp friction whoosh (`res://assets/sfx/slide.wav` or procedurally generated SFX).
- **Near-Miss / Close Call Detector**: Passing an aerial drone or ground obstacle with $<25\text{ px}$ margin awards bonus score toast (`"CLOSE CALL! +100"`).

---

## 6. Verification & Test Plan

### 6.1 Collision & Physics Validation
1. Run straight into an aerial drone while standing $\rightarrow$ Confirm collision and life/shield decrement or Game Over.
2. Slide under an aerial drone $\rightarrow$ Confirm clean pass with zero collision.
3. Jump into an aerial drone $\rightarrow$ Confirm collision.
4. Jump and press Down mid-air $\rightarrow$ Confirm fast fall downward acceleration.

### 6.2 Performance Verification
- Frame rate monitor: Confirm consistent 60 FPS without memory spikes or garbage collection freezes on low-end profiles.
