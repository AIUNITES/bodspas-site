# Muscular Neuro Notation (MNN) — Formal Specification

**Version:** 1.0.0  
**Date:** March 1, 2026  
**Author:** Tom / BodSpas / AIUNITES  
**Copyright:** © 2026 BodSpas. All rights reserved.  
**License:** This specification is published for prior art and DMCA registration purposes. Use of the notation format in personal training logs is permitted. Commercial implementations, machine firmware integration, and derivative specification documents require written permission from the author.

---

## 1. Purpose

Muscular Neuro Notation (MNN) is a structured text notation system for describing human muscular contraction events at the neuromuscular level. It encodes:

1. **Which muscles contracted** and at what activation level
2. **Which nerves drove them** and from which spinal roots
3. **Which movement pattern** was performed
4. **What joint positions** were held (3-DOF per joint)
5. **What resistance vector** was applied (source, height, angle)
6. **Whether compensation occurred** (wrong muscle dominated)

MNN is designed to be:
- **Human-readable** in a gym log or clinical note
- **Machine-parseable** for automated training equipment, exoskeletons, VR environments, and robotic rehabilitation systems
- **Anatomically complete** — every tag maps to real neuroanatomy

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

## 13. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | March 1, 2026 | Initial specification — movement, contraction, nerve, position, vector, compensation, nerve status tags |

---

## 14. Intellectual Property

Muscular Neuro Notation (MNN) is an original notation system created by Tom / BodSpas / AIUNITES. This specification document serves as timestamped prior art establishing authorship and publication date.

The notation format, symbol tables, tag grammar, and the concept of a human-readable/machine-parseable neuromuscular exercise notation system are the intellectual property of the author.

Reference implementation: https://aiunites.github.io/bodspas-site/log.html

---

*MNN Specification v1.0.0 — © 2026 BodSpas / AIUNITES*
