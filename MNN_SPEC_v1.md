# Muscular Neuro Notation (MNN) — Formal Specification

**Version:** 1.0.0  
**Date:** March 1, 2026  
**Author:** Tom / AIUNITES LLC / BODWAVE  
**Copyright:** © 2026 AIUNITES LLC. All rights reserved.  
**License:** This specification is published for prior art and DMCA registration purposes. Use of the notation format in personal training logs is permitted. Commercial implementations, machine firmware integration, avatar control systems, and derivative specification documents require written permission from the author.

---

## 1. Purpose

Muscular Neuro Notation (MNN) is a unified text notation system for describing human movement at the neuromuscular level. It encodes:

1. **Which muscles contracted** and at what activation level
2. **Which nerves drove them** and from which spinal roots
3. **Which movement pattern** was performed
4. **What joint positions** were held (3-DOF per joint)
5. **What resistance vector** was applied (source, height, angle)
6. **Whether compensation occurred** (wrong muscle dominated)

MNN is designed to be:
- **Human-readable** in a gym log, clinical note, or training plan
- **Machine-parseable** for automated training equipment, exoskeletons, VR environments, and robotic rehabilitation systems
- **Avatar-compatible** for virtual world character posing, animation blending, and remote-controlled movement
- **Anatomically complete** — every tag maps to real neuroanatomy
- **Portable** — the same string works in a text file, a database field, a game engine, or a hardware controller

### 1.1 The Three Domains of MNN

MNN is a notation for **human movement**, not just exercise. The same MNN string is valid and useful across three domains:

| Domain | Use Case | Example |
|--------|----------|---------|
| **Exercise & Rehabilitation** | Gym logging, physical therapy, clinical documentation, personal training | Track which angle clears the acromion, log nerve flare-ups alongside sets, document compensation patterns over time |
| **Virtual Worlds & Avatars** | Virtual worlds, VR training, Second Life / OpenSim, digital twins, animation | Pose an avatar precisely using joint angles, animate contraction sequences, build training simulations |
| **Remote Control & Robotics** | Cable rigs, exoskeletons, robotic rehabilitation, isokinetic machines, teleoperation | Drive a pulley to the exact height and angle, set joint limits on an exoskeleton, reproduce a therapist's prescribed position |

A single MNN string like:
```
{Push.H} [Con:Pec.S+++, Dlt.A+] → MedPec/Axil
[Pos:L.Sh(IR:25,Flex:90)] [Vec:H:Mid,A:0°,Src:Cable]
```
...is simultaneously a gym log entry a human can read, an avatar pose command a game engine can execute, and a machine instruction a cable rig can actuate. The notation does not change between contexts. The implementation does.

This is the core design principle of MNN: **write once, use everywhere.**

MNN is developed and published by AIUNITES LLC. AIUNITES is a middleware company — the integration layer between domain-specific applications that don't normally talk to each other. The sites are the endpoints. The notation systems are the protocols. The notation standard lives at the AIUNITES level:

| Site | Role | URL |
|------|------|-----|
| **AIUNITES** | The standard — holds the MNN specification | aiunites.github.io/aiunites-site |
| **BodSpas** | Exercise & rehabilitation application of MNN | aiunites.github.io/bodspas-site |
| **InThisWorld** | Virtual world application of MNN — avatar posing, LSL bridge, simulation | inthisworld.com |
| **VoiceStry** | Vocal movement — VRN (Voice Resonance Notation) | aiunites.github.io/voicestry-site |

AIUNITES is the middleware layer. Each site is a domain-specific endpoint for the same underlying protocols. The name means what it says: **uniting**.

*How can you have AI gains in this world without having unity?*

---

## 2. Notation Structure

A complete MNN string follows this format:

```
{Movement} [Con:Muscles] → Nerves
[Pos:Side.Joint(Axis:value,...)] [Vec:H:height,A:angle,Src:source]
[Comp:Compensator for Target]
```

All components are optional. The minimum valid MNN string is a single tag.

---

## 3. Movement Pattern Tags

Movement patterns describe the kinematic category of the exercise.

### Format
```
{Pattern.Direction}
```

### Defined Values

| Tag | Meaning |
|-----|---------|
| `{Push.H}` | Horizontal push (bench press, push-up) |
| `{Push.V}` | Vertical push (overhead press) |
| `{Pull.H}` | Horizontal pull (row, cable fly) |
| `{Pull.V}` | Vertical pull (pull-up, lat pulldown) |
| `{Squat}` | Squat pattern |
| `{Hinge}` | Hip hinge (deadlift, RDL) |
| `{Lunge}` | Lunge / split stance |
| `{Carry}` | Loaded carry |
| `{Iso}` | Isolation / single-joint |
| `{Rotate}` | Rotational (woodchop, Pallof) |

### Grammar
```
MovementTag := "{" Pattern ["." Direction] "}"
Pattern := "Push" | "Pull" | "Squat" | "Hinge" | "Lunge" | "Carry" | "Iso" | "Rotate"
Direction := "H" | "V"
```

---

## 4. Contraction Tags

Contraction tags list which muscles fired and at what activation level.

### Format
```
[Con:Muscle+level, Muscle+level, ...]
```

### Activation Levels
| Symbol | Level | Meaning |
|--------|-------|---------|
| `+` | 1 | Low — stabilizer, light assist |
| `++` | 2 | Moderate — synergist, secondary mover |
| `+++` | 3 | High — prime mover |

### Muscle Symbols

#### Chest
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Pec.S` | Pectoralis Major — Sternal Head | MedPec | C8–T1 |
| `Pec.C` | Pectoralis Major — Clavicular Head | LatPec | C5–C7 |
| `Pec.Min` | Pectoralis Minor | MedPec | C8–T1 |

#### Shoulders
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Dlt.A` | Anterior Deltoid | Axil | C5–C6 |
| `Dlt.L` | Lateral Deltoid | Axil | C5–C6 |
| `Dlt.P` | Posterior Deltoid | Axil | C5–C6 |

#### Arms
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Tri` | Triceps Brachii | Rad | C6–C8 |
| `Bic` | Biceps Brachii | MusCut | C5–C7 |

#### Back
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Lat` | Latissimus Dorsi | ThDors | C6–C8 |
| `Trp.U` | Upper Trapezius | CNXI | C1–C4 |
| `Trp.M` | Middle Trapezius | CNXI | C3–C4 |
| `Trp.L` | Lower Trapezius | CNXI | C3–C4 |
| `Rhm` | Rhomboids | DorsScap | C4–C5 |
| `Ser` | Serratus Anterior | LTh | C5–C7 |
| `Ers` | Erector Spinae | DorsRami | T1–L5 |

#### Neck
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `SCM` | Sternocleidomastoid | CNXI | C1–C3 |
| `SubOcc` | Suboccipitals | SubOccN | C1–C2 |

#### Rotator Cuff
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Ssp` | Supraspinatus | SupScap | C5–C6 |
| `Inf` | Infraspinatus | SupScap | C5–C6 |
| `Sub` | Subscapularis | Subscap | C5–C6 |
| `Ter.Mn` | Teres Minor | Axil | C5–C6 |

#### Quadriceps
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Quad.RF` | Rectus Femoris | Fem | L2–L4 |
| `Quad.VL` | Vastus Lateralis | Fem | L2–L4 |
| `Quad.VM` | Vastus Medialis | Fem | L2–L4 |
| `Quad.VI` | Vastus Intermedius | Fem | L2–L4 |

#### Hamstrings / Glutes
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Ham` | Hamstrings | Sci.T | L5–S2 |
| `Glu.Mx` | Gluteus Maximus | InfGlu | L5–S2 |
| `Glu.Md` | Gluteus Medius | SupGlu | L4–S1 |
| `Glu.Mn` | Gluteus Minimus | SupGlu | L4–S1 |

#### Legs
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Add` | Adductors | Obturator | L2–L4 |
| `Gas` | Gastrocnemius | Sci.T | S1–S2 |
| `Sol` | Soleus | Sci.T | S1–S2 |
| `Tib.A` | Tibialis Anterior | Sci.P | L4–L5 |

#### Core
| Symbol | Full Name | Nerve | Spinal Roots |
|--------|-----------|-------|-------------|
| `Rect.Ab` | Rectus Abdominis | Intercostal | T7–T12 |
| `Obl.E` | External Oblique | Intercostal | T5–T12 |
| `Obl.I` | Internal Oblique | Intercostal | T7–L1 |
| `Trans.Ab` | Transverse Abdominis | Intercostal | T7–L1 |

### Grammar
```
ConTag := "[Con:" MuscleEntry ("," MuscleEntry)* "]"
MuscleEntry := MuscleSymbol ActivationLevel
ActivationLevel := "+" | "++" | "+++"
```

---

## 5. Nerve Tags

Nerve tags identify which peripheral nerves were active.

### Format
```
→ Nerve/Nerve/...
```

### Nerve Symbols

| Symbol | Full Name |
|--------|-----------|
| `MedPec` | Medial Pectoral Nerve |
| `LatPec` | Lateral Pectoral Nerve |
| `Axil` | Axillary Nerve |
| `Rad` | Radial Nerve |
| `MusCut` | Musculocutaneous Nerve |
| `ThDors` | Thoracodorsal Nerve |
| `CNXI` | Cranial Nerve XI (Spinal Accessory) |
| `DorsScap` | Dorsal Scapular Nerve |
| `LTh` | Long Thoracic Nerve |
| `DorsRami` | Dorsal Rami |
| `SupScap` | Suprascapular Nerve |
| `Subscap` | Subscapular Nerve |
| `Fem` | Femoral Nerve |
| `Sci.T` | Sciatic Nerve — Tibial Division |
| `Sci.P` | Sciatic Nerve — Peroneal Division |
| `InfGlu` | Inferior Gluteal Nerve |
| `SupGlu` | Superior Gluteal Nerve |
| `Obturator` | Obturator Nerve |
| `Intercostal` | Intercostal Nerves |
| `SubOccN` | Suboccipital Nerve |

### Grammar
```
NerveTag := "→" NerveSymbol ("/" NerveSymbol)*
```

---

## 6. Joint Position Tags

Position tags define the angular state of each joint using anatomical degrees of freedom. Each joint has a defined set of axes with physiological range limits.

### Format
```
[Pos:Side.Joint(Axis:value,...) Joint(Axis:value,...)]
```

### Side Identifiers
| Symbol | Meaning |
|--------|---------|
| `L` | Left |
| `R` | Right |
| `Bi` | Bilateral |
| *(omitted)* | Unspecified |

### Joint Definitions

#### Shoulder (Sh) — 3 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Flex` | Flexion (+) / Extension (-) | -45 to 180 | degrees |
| `Abd` | Abduction / Adduction | 0 to 180 | degrees |
| `IR` | Internal Rotation | 0 to 90 | degrees |
| `ER` | External Rotation | 0 to 90 | degrees |

#### Elbow (El) — 2 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Flex` | Flexion | 0 to 145 | degrees |
| `Pro` | Pronation | 0 to 90 | degrees |
| `Sup` | Supination | 0 to 90 | degrees |

#### Wrist (Wr) — 2 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Flex` | Flexion (+) / Extension (-) | -70 to 80 | degrees |
| `Rad` | Radial Deviation | 0 to 20 | degrees |
| `Uln` | Ulnar Deviation | 0 to 35 | degrees |

#### Hip (Hip) — 3 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Flex` | Flexion (+) / Extension (-) | -30 to 125 | degrees |
| `Abd` | Abduction / Adduction | 0 to 45 | degrees |
| `IR` | Internal Rotation | 0 to 45 | degrees |
| `ER` | External Rotation | 0 to 45 | degrees |

#### Knee (Kn) — 1 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Flex` | Flexion | 0 to 140 | degrees |

#### Ankle (Ank) — 2 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Dors` | Dorsiflexion | 0 to 20 | degrees |
| `Plan` | Plantarflexion | 0 to 50 | degrees |
| `Inv` | Inversion | 0 to 35 | degrees |
| `Ev` | Eversion | 0 to 25 | degrees |

#### Spine (Sp) — 3 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Flex` | Flexion (+) / Extension (-) | -30 to 80 | degrees |
| `Lat` | Lateral Flexion | 0 to 35 | degrees |
| `Rot` | Rotation | 0 to 55 | degrees |

#### Scapula (Scap) — 3 DOF
| Axis | Full Name | Range | Unit |
|------|-----------|-------|------|
| `Pro` | Protraction (+) / Retraction (-) | -15 to 15 | degrees |
| `Elev` | Elevation (+) / Depression (-) | -10 to 12 | degrees |
| `UpRot` | Upward Rotation | 0 to 60 | degrees |

### Mapping to Euler Rotations

For machine and VR implementations, joint axes map to standard euler rotation frames:

| Anatomical Axis | Euler Equivalent | SL/VW Equivalent |
|-----------------|-----------------|-------------------|
| Flexion/Extension | Pitch (X-axis rotation) | llSetLocalRot X |
| Abduction/Adduction | Roll (Z-axis rotation) | llSetLocalRot Z |
| Internal/External Rotation | Yaw (Y-axis rotation) | llSetLocalRot Y |

The local coordinate frame is anchored to the proximal bone segment of each joint, with the X-axis along the bone's long axis, Z-axis pointing laterally, and Y-axis pointing anteriorly.

### Grammar
```
PosTag := "[Pos:" [Side "."] JointEntry (" " JointEntry)* "]"
Side := "L" | "R" | "Bi"
JointEntry := JointSymbol "(" AxisEntry ("," AxisEntry)* ")"
JointSymbol := "Sh" | "El" | "Wr" | "Hip" | "Kn" | "Ank" | "Sp" | "Scap"
AxisEntry := AxisId ":" Integer
```

---

## 7. Resistance Vector Tags

Vector tags describe the external force applied to the body during the exercise.

### Format
```
[Vec:H:height,A:angle,Src:source]
```

### Height Values
| Value | Meaning | Approximate Position |
|-------|---------|---------------------|
| `Floor` | Floor level | 0–6 inches |
| `Low` | Low position | Knee height |
| `Mid` | Mid position | Chest / sternum height |
| `High` | High position | Head / above shoulder |
| `Over` | Overhead | Above head |

### Angle
- **0°** = Force vector directly ahead of the person (sagittal plane)
- **Positive** = Force from the person's left side
- **Negative** = Force from the person's right side
- **±180°** = Force from directly behind

### Source Values
| Value | Meaning |
|-------|---------|
| `Cable` | Cable stack / pulley system |
| `Band` | Elastic resistance band |
| `Gravity` | Free weight (gravity only) |
| `Machine` | Fixed path machine |
| `Manual` | Manual resistance (therapist, partner) |

### Machine Control Extension

For automated equipment, the vector tag can be extended with precise values:

```
[Vec:H:Mid,A:0°,Src:Cable,Load:20lb,Pulley:48in]
```

| Extension | Type | Meaning |
|-----------|------|---------|
| `Load` | String | Resistance magnitude with unit |
| `Pulley` | String | Exact pulley height from floor |
| `Speed` | String | Cable speed (for isokinetic modes) |
| `Accom` | String | Accommodating resistance curve ID |

### Grammar
```
VecTag := "[Vec:" VecEntry ("," VecEntry)* "]"
VecEntry := "H:" HeightVal | "A:" Integer "°" | "Src:" SourceVal | ExtKey ":" String
HeightVal := "Floor" | "Low" | "Mid" | "High" | "Over"
SourceVal := "Cable" | "Band" | "Gravity" | "Machine" | "Manual"
```

---

## 8. Compensation Tags

Compensation tags flag when the wrong muscle dominated the movement.

### Format
```
[Comp:Compensator for Target]
```

Where `Compensator` is the muscle that took over and `Target` is the muscle that should have been the prime mover.

### Common Compensations
| Pattern | Meaning |
|---------|---------|
| `[Comp:Dlt.A for Pec.S]` | Anterior deltoid took over for sternal pec |
| `[Comp:Trp.U for Dlt.L]` | Shrugging instead of lateral raise |
| `[Comp:Bic for Lat]` | Biceps pulling instead of back |
| `[Comp:Ers for Glu.Mx]` | Low back extending instead of glutes |
| `[Comp:Trp.U for Trp.L]` | Upper trap compensating for weak lower trap |

### Grammar
```
CompTag := "[Comp:" MuscleSymbol " for " MuscleSymbol "]"
```

---

## 9. Nerve Status Tags

Nerve status tags record which spinal levels were symptomatic at the time of the exercise.

### Format
```
[Nerve:C5-C6,T8-T9]
```

### Spinal Level Format
Each level represents a vertebral disc segment: `C1-C2` through `S1-S2`.

Full list:
- **Cervical:** C1-C2, C2-C3, C3-C4, C4-C5, C5-C6, C6-C7, C7-C8
- **Thoracic:** T1-T2 through T11-T12 (11 levels)
- **Lumbar:** L1-L2, L2-L3, L3-L4, L4-L5
- **Lumbosacral:** L5-S1
- **Sacral:** S1-S2

### Grammar
```
NerveStatusTag := "[Nerve:" Level ("," Level)* "]"
Level := SpineSegment "-" SpineSegment
SpineSegment := ("C" | "T" | "L" | "S") Integer
```

---

## 10. Complete Example

A single-arm cable fly, left side, with shoulder at 25° internal rotation, cable at mid height, using the sternal pec as prime mover, on a day when C5-C6 was flared:

```
{Pull.H} [Con:Pec.S+++, Dlt.A+] → MedPec/Axil
[Pos:L.Sh(IR:25,Flex:90,Abd:10)] [Vec:H:Mid,A:0°,Src:Cable]
```

With nerve status context:
```
[Nerve:C5-C6]
{Pull.H} [Con:Pec.S+++, Dlt.A+] → MedPec/Axil
[Pos:L.Sh(IR:25,Flex:90,Abd:10)] [Vec:H:Mid,A:0°,Src:Cable]
```

This string is simultaneously:
- A gym log entry a human can read
- A machine instruction set that could drive a cable rig to reproduce the position
- A clinical record of neuromuscular activation pattern with joint angles
- A VR/game engine command for avatar posing with force application

---

## 11. Formal Grammar (EBNF)

```ebnf
MNNString     := [MovementTag] [ConTag] [NerveTag] [PosTag] [VecTag] [CompTag]

MovementTag   := "{" Identifier ["." Identifier] "}"
ConTag        := "[Con:" MuscleEntry ("," MuscleEntry)* "]"
MuscleEntry   := Identifier ("+" | "++" | "+++")
NerveTag      := "→" Identifier ("/" Identifier)*
PosTag        := "[Pos:" [Side "."] JointEntry (" " JointEntry)* "]"
Side          := "L" | "R" | "Bi"
JointEntry    := Identifier "(" AxisEntry ("," AxisEntry)* ")"
AxisEntry     := Identifier ":" Integer
VecTag        := "[Vec:" KVPair ("," KVPair)* "]"
KVPair        := Identifier ":" Value
CompTag       := "[Comp:" Identifier " for " Identifier "]"
NerveStatus   := "[Nerve:" Level ("," Level)* "]"
Level         := Segment "-" Segment
Segment       := Letter Digits

Identifier    := Letter (Letter | Digit | ".")*
Value         := (Letter | Digit | "°" | "." | "-")+
Integer       := ["-"] Digits
Digits        := Digit+
Letter        := "A"-"Z" | "a"-"z"
Digit         := "0"-"9"
```

---

## 12. Implementation Notes

### Parser Requirements
Any MNN parser MUST:
1. Accept tags in any order within a string
2. Treat all tags as optional
3. Preserve unknown tags without error (forward compatibility)
4. Parse muscle symbols case-sensitively (`Pec.S` ≠ `pec.s`)
5. Accept both `→` (U+2192) and `->` as the nerve arrow

### Machine Control Requirements
Any MNN machine controller MUST:
1. Validate all joint angles against physiological range limits before actuating
2. Implement soft stops at range limits (not hard stops)
3. Require explicit side specification (`L`/`R`) — never assume bilateral
4. Default to minimum resistance if `Load` is omitted
5. Log the complete MNN string for every repetition

### Display Mode
Implementations SHOULD support two display modes:
- **Compact:** Uses symbols (`Pec.S`, `MedPec`, `Sh`)
- **Full Anatomy:** Uses full names (`Sternal Pec`, `Medial Pectoral`, `Shoulder`)

---

## 13. Prior Art and Related Standards

MNN exists at the intersection of several established fields, each with its own standards and notation systems. None of them combine neuromuscular targeting, joint position, resistance vector, and compensation tracking into a single notation. MNN bridges this gap.

### 13.1 Biomechanics — ISB Joint Coordinate System (JCS)

The International Society of Biomechanics (ISB) Standardization and Terminology Committee published joint coordinate system definitions in two landmark papers:
- **Part I** (Wu et al., 2002): Ankle, hip, and spine — *Journal of Biomechanics* 35, 543–548
- **Part II** (Wu et al., 2005): Shoulder, elbow, wrist, and hand — *Journal of Biomechanics* 38, 981–992

ISB JCS defines local coordinate systems on proximal and distal bone segments, with joint rotations expressed as Euler/Cardan angles. It is a *research reporting convention* used in journal papers and biomechanics software. It does not define a compact text notation, does not encode muscle activation or nerve involvement, and is not designed for real-time logging.

MNN's `[Pos:]` tag is designed to be compatible with ISB joint axis conventions. The anatomical axes (Flexion/Extension, Abduction/Adduction, Internal/External Rotation) map directly to ISB's recommended decomposition sequences. MNN expresses these as compact key-value pairs (`Sh(IR:25,Flex:90)`) rather than tabular data.

### 13.2 Motion Capture — C3D, BVH, OpenSim

Several binary and text file formats store full-body motion data captured from cameras, IMUs, or marker systems:

| Format | Origin | Type | Content |
|--------|--------|------|--------|
| **C3D** | NIH, mid-1980s | Binary | 3D marker positions, analog data (force plates, EMG), parameters |
| **BVH** | Biovision, 1990s | ASCII | Skeletal hierarchy + per-frame joint rotations |
| **OpenSim .trc/.mot** | Stanford/NIH | ASCII | Marker trajectories and motion files for musculoskeletal simulation |
| **FBX** | Autodesk | Binary | Animation data including mesh, skeleton, and motion |
| **MVNX** | Xsens | XML | IMU-based motion capture with joint angles, segment velocity, CoM |

These are *sensor data formats* — they store time-series frame data generated by motion capture hardware. They are not designed for human authoring, do not encode which muscles or nerves were active, and do not capture training intent (compensation, activation level, resistance setup).

MNN is not a replacement for motion capture formats. It is a *semantic annotation layer* that could accompany C3D/BVH data to describe the neuromuscular intent behind the captured movement.

### 13.3 Electromyography — SENIAM and ISEK

Surface electromyography (sEMG) has two major standards bodies:
- **SENIAM** (Surface EMG for Non-Invasive Assessment of Muscles): European project that developed electrode placement recommendations for 30 muscles, signal processing guidelines, and sensor specifications.
- **ISEK** (International Society of Electrophysiology and Kinesiology): Sets broader standards for electrophysiological measurement and reporting.

EMG output is voltage waveforms normalized to Maximum Voluntary Contraction (%MVC). Research papers use informal muscle abbreviations (UT = upper trapezius, SA = serratus anterior, BB = biceps brachii) but there is no formal, standardized symbol table for muscle names.

MNN's `[Con:]` tag provides what EMG lacks: a standardized symbol table for muscles with defined abbreviations, explicit nerve innervation mapping, and qualitative activation levels (+, ++, +++) that approximate the low/moderate/high categories used in EMG research without requiring sensor hardware.

### 13.4 Exercise Prescription — ACSM FITT and NSCA

The American College of Sports Medicine (ACSM) defines exercise prescription through the **FITT principle**: Frequency, Intensity, Time, and Type. This is a *prose framework* — a physician writes "moderate intensity aerobic, 30 min, 5×/week" in natural language.

The National Strength and Conditioning Association (NSCA) uses the universal gym shorthand: **sets × reps × load** (e.g., 3×10×135lb). This captures dose but encodes zero information about joint position, nerve involvement, muscle targeting, or compensation patterns.

MNN is complementary to FITT/NSCA notation. A complete training log entry might read:
```
Session: Upper Push — 3×12×20lb RPE:6
{Push.H} [Con:Pec.S+++, Dlt.A+] → MedPec/Axil
[Pos:L.Sh(IR:25,Flex:90)] [Vec:H:Mid,Src:Cable]
```
The first line is NSCA-style dose. The MNN string adds the neuromuscular detail.

### 13.5 Dance and Movement — Labanotation

Labanotation (Kinetography Laban), created by Rudolf Laban in the 1920s, is the only established notation system for human movement. It uses a vertical staff with symbols for direction, level, timing, body part, and effort quality. It is comprehensive for choreographic description and is used in dance, theater, and movement therapy.

Labanotation describes *where* the body goes through space and with what quality of effort (Float, Punch, Glide, Slash, Dab, Wring, Flick, Press). It has no concept of which nerve fired, which muscle contracted, what the resistance vector was, or whether compensation occurred. It is a visual notation requiring specialized training to read and write.

Birdwhistell's Kinesics system offers hundreds of codes for body part movements but is used in psychology for gesture analysis, not exercise.

### 13.6 Why No Unified Notation Exists

Every field that touches human movement built its own silo. Whether by design or by accident, the result is the same: your data doesn't travel with you.

A biomechanics lab uses C3D files that only their software can read. A gym equipment manufacturer stores joint angles in a proprietary firmware format that only their machines can interpret. A physical therapy clinic documents exercises in prose notes that cannot be parsed by any other system. A game studio uses BVH files that encode skeleton motion but nothing about which muscles fired or why. These fields evolved independently, in different decades, solving different problems. Nobody planned the fragmentation — but nobody solved it either.

The practical effect is the same regardless of intent: when your movement data lives inside a vendor's format, taking it with you is expensive and painful. Exporting, converting, and re-importing between systems requires specialized software, technical expertise, or both. For most people, the data effectively stays behind when they switch providers, facilities, or platforms. The patient who got a detailed movement analysis at one clinic starts from zero at another. The athlete whose gym tracked their joint angles on brand-name machines loses all that data when they switch facilities. The researcher who captured motion in one lab's software cannot share it with a collaborator using different tools without expensive format conversion.

The result is that a simple truth — "this person's left shoulder was at 25° internal rotation and 90° flexion while contracting the sternal pec via the medial pectoral nerve using a mid-height cable" — cannot be expressed in any single, portable, human-readable format that works across all of these contexts.

MNN exists because that sentence should be writable as:
```
[Con:Pec.S+++] → MedPec [Pos:L.Sh(IR:25,Flex:90)] [Vec:H:Mid,Src:Cable]
```
...and that string should work in a gym log, a clinical record, a game engine, a cable rig controller, and a research paper without conversion, without proprietary software, and without paying anyone for the privilege of reading your own movement data.

MNN is an open notation. It is plain text. It requires no special software to read. It requires no license to write. It belongs to the person whose body produced the movement.

### 13.7 Summary — The MNN Gap

| Domain | Standard | What It Captures | What It Lacks |
|--------|----------|-----------------|---------------|
| Joint angles | ISB JCS | Per-joint rotations via Euler angles | No muscle/nerve data, no compact text format |
| Motion data | C3D/BVH/OpenSim | Full-body time-series from sensors | No semantic layer, no human authoring |
| Muscle activity | EMG + SENIAM | Voltage waveforms, electrode standards | No standardized symbol table, no nerve mapping |
| Exercise dose | ACSM FITT / NSCA | Frequency, intensity, sets×reps×load | No joint position, no muscle targeting |
| Choreography | Labanotation | Spatial path, timing, effort quality | No neuromuscular data, no resistance vector |
| **All of the above** | **MNN** | **Muscle + nerve + joint + vector + compensation** | **—** |

MNN is the first notation system that combines neuromuscular targeting (which muscles, which nerves, from which spinal roots), joint position (ISB-compatible degrees per axis), resistance vector (source, height, angle), and compensation tracking into a single human-readable, machine-parseable string.

---

## 14. Intellectual Property

Muscular Neuro Notation (MNN) is an original notation system created by Tom and published by AIUNITES LLC under the BODWAVE product line. This specification document serves as timestamped prior art establishing authorship and publication date.

The notation format, symbol tables, tag grammar, three-domain architecture (exercise, avatar, remote control), and the concept of a unified human-readable/machine-parseable human movement notation system are the intellectual property of AIUNITES LLC.

All AIUNITES web applications (BodSpas, Gameatica, VideoBate, AIByJob, ERPize, and all other sites in the AIUNITES network) operate as part of AIUNITES LLC.

Reference implementation: https://aiunites.github.io/bodspas-site/log.html

---

## 15. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | March 1, 2026 | Initial specification — movement, contraction, nerve, position, vector, compensation, nerve status tags, joint position, resistance vector, prior art analysis |

---

*MNN Specification v1.0.0 — © 2026 AIUNITES LLC / BODWAVE*
