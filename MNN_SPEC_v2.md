# Muscular Neuro Notation (MNN) — Formal Specification

**Version:** 2.0.0
**Date:** April 3, 2026
**Author:** Tom / AIUNITES LLC / BODWAVE
**Copyright:** © 2026 AIUNITES LLC. All rights reserved.
**License:** This specification is published for prior art and copyright registration purposes. Use of the notation format in personal training logs is permitted. Commercial implementations, machine firmware integration, avatar control systems, and derivative specification documents require written permission from the author.

---

## Syntax Change Notice (v1.x → v2.0)

Version 2.0 introduces a fully redesigned tag syntax. All tags now use the **@TAG(...)** annotation style. This makes MNN strings visually distinctive, immediately parseable by regex, and unambiguously identifiable as MNN rather than any other notation system.

| Component | v1.x Syntax | v2.0 Syntax |
|-----------|------------|------------|
| Movement | `{Push.H}` | `@MOV(Push.H)` |
| Contraction | `[Con:Pec.S+++, Dlt.A+]` | `@ACT(Pec.S:3, Dlt.A:1)` |
| Nerve output | `→ MedPec/Axil` | `>> MedPec/Axil` |
| Joint position | `[Pos:L.Sh(IR:25,Flex:90)]` | `@JNT(L.Sh:IR=25,Flex=90)` |
| Resistance vector | `[Vec:H:Mid,A:0°,Src:Cable]` | `@VEC(Ht=Mid,Ang=0°,Src=Cable)` |
| Compensation | `[Comp:Dlt.A for Pec.S]` | `@COMP(Dlt.A/Pec.S)` |
| Nerve status | `[Nerve:C5-C6]` | `@NERV(C5-C6)` |
| Morph override | `[Morph:Bic:0.8]` | `@MORPH(Bic=0.8)` |
| Body baseline | `[Body:Mass:80kg]` | `@BODY(Mass=80kg)` |

Activation levels change from `+/++/+++` to numeric `:1/:2/:3`:

| v1.x | v2.0 | Meaning |
|------|------|---------|
| `+` | `:1` | Low — stabilizer, light assist |
| `++` | `:2` | Moderate — synergist, secondary mover |
| `+++` | `:3` | High — prime mover |
| *(new)* | `:4` | Maximum voluntary contraction |

v1.x strings remain valid as a legacy format. Compliant v2.0 parsers MUST accept both syntaxes. The `@` prefix is the unambiguous MNN identifier — no other notation system uses this prefix convention for biomechanical tagging.

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

MNN is a protocol within the **Human Movement Notation (HMN)** family, published by AIUNITES LLC. HMN is the umbrella standard for all open notation systems for human movement; MNN covers the body (muscles, nerves, joints, resistance vectors), VRN (Voice Resonance Notation) covers vocal production, and VNN (Voice Neural Notation) covers AI voice synthesis. All three are applications of the same underlying principle: encode human movement as portable, human-readable, machine-parseable text.

MNN is a notation for **human movement**, not just exercise. The same MNN string is valid and useful across three domains:

| Domain | Use Case | Example |
|--------|----------|---------|
| **Exercise & Rehabilitation** | Gym logging, physical therapy, clinical documentation, personal training | Track which angle clears the acromion, log nerve flare-ups alongside sets, document compensation patterns over time |
| **Virtual Worlds & Avatars** | Virtual worlds, VR training, Second Life / OpenSim, digital twins, animation | Pose an avatar precisely using joint angles, animate contraction sequences, build training simulations |
| **Remote Control & Robotics** | Cable rigs, exoskeletons, robotic rehabilitation, isokinetic machines, teleoperation | Drive a pulley to the exact height and angle, set joint limits on an exoskeleton, reproduce a therapist's prescribed position |

A single MNN string like:
```
@MOV(Pull.H) @ACT(Pec.S:3, Dlt.A:1) >> MedPec/Axil
@JNT(L.Sh:IR=25,Flex=90) @VEC(Ht=Mid,Ang=0°,Src=Cable)
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
@MOV(Pattern) @ACT(Muscles) >> Nerves
@JNT(Side.Joint:Axis=value,...) @VEC(Ht=height,Ang=angle,Src=source)
@COMP(Compensator/Target)
```

All components are optional. The minimum valid MNN string is a single tag.

**Identifying MNN strings:** Every MNN tag begins with `@`. A string containing at least one `@MOV`, `@ACT`, `@JNT`, `@VEC`, `@COMP`, `@NERV`, `@MORPH`, or `@BODY` tag is an MNN string. The `>>` nerve arrow is MNN-exclusive and may appear without an `@MOV` tag in nerve-only annotations.

---

## 3. Movement Pattern Tags

Movement patterns describe the kinematic category of the exercise.

### Format
```
@MOV(Pattern.Direction)
```

### Defined Values

| Tag | Meaning |
|-----|---------|
| `@MOV(Push.H)` | Horizontal push (bench press, push-up) |
| `@MOV(Push.V)` | Vertical push (overhead press) |
| `@MOV(Pull.H)` | Horizontal pull (row, cable fly) |
| `@MOV(Pull.V)` | Vertical pull (pull-up, lat pulldown) |
| `@MOV(Squat)` | Squat pattern |
| `@MOV(Hinge)` | Hip hinge (deadlift, RDL) |
| `@MOV(Lunge)` | Lunge / split stance |
| `@MOV(Carry)` | Loaded carry |
| `@MOV(Iso)` | Isolation / single-joint |
| `@MOV(Rotate)` | Rotational (woodchop, Pallof) |

### Grammar
```ebnf
MovementTag := "@MOV(" Pattern ["." Direction] ")"
Pattern     := "Push" | "Pull" | "Squat" | "Hinge" | "Lunge" | "Carry" | "Iso" | "Rotate"
Direction   := "H" | "V"
```

---

## 4. Contraction Tags

Contraction tags list which muscles fired and at what activation level.

### Format
```
@ACT(Muscle:level, Muscle:level, ...)
```

### Activation Levels
| Symbol | Level | Meaning |
|--------|-------|---------|
| `:1` | 1 | Low — stabilizer, light assist |
| `:2` | 2 | Moderate — synergist, secondary mover |
| `:3` | 3 | High — prime mover |
| `:4` | 4 | Maximum voluntary contraction |

### Muscle Symbols

All muscle symbols are unchanged from v1.x. Symbols are anatomically grounded abbreviations — not proprietary. The complete symbol table below is an original compilation including spinal root mapping and nerve assignment for each muscle, which is the creative IP of this specification.

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

#### Face (Facial Expression)
| Symbol | Full Name | Nerve | Notes |
|--------|-----------|-------|-------|
| `Zyg.Mj` | Zygomaticus Major | CNVII | Draws corner of mouth up/back — smile |
| `Zyg.Mn` | Zygomaticus Minor | CNVII | Elevates upper lip — mild smile/sneer |
| `Orb.Oc` | Orbicularis Oculi | CNVII | Closes eyelid — blink, squint, wink |
| `Orb.Or` | Orbicularis Oris | CNVII | Closes/purses lips |
| `Front` | Frontalis | CNVII | Raises eyebrows — surprise, attention |
| `Corr` | Corrugator Supercilii | CNVII | Draws brows together/down — frown, concentration |
| `Dep.Ang` | Depressor Anguli Oris | CNVII | Pulls corner of mouth down — sadness, disgust |
| `Lev.Lab` | Levator Labii Superioris | CNVII | Raises upper lip — disgust, sneer |
| `Ment` | Mentalis | CNVII | Raises/wrinkles chin — pout, doubt |
| `Bucc` | Buccinator | CNVII | Compresses cheek — chewing, sucking, blowing |
| `Nas` | Nasalis | CNVII | Flares nostrils — exertion, disgust |
| `Dep.Lab` | Depressor Labii Inferioris | CNVII | Pulls lower lip down — irony, lower lip reveal |
| `Riso` | Risorius | CNVII | Pulls corner of mouth laterally — grin |
| `Pro.Lab` | Procerus | CNVII | Pulls medial brow down — intensity, anger |

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

#### Pelvic Floor & Perineum
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `PF.PC` | Pubococcygeus | Pud | S2–S4 | Medial levator ani — core pelvic floor lifter |
| `PF.IC` | Iliococcygeus | Pud | S2–S4 | Lateral levator ani — pelvic shelf |
| `PF.PR` | Puborectalis | Pud | S2–S4 | Anorectal sling — maintains anorectal angle |
| `Cocc` | Coccygeus | Pud | S3–S4 | Posterior pelvic floor — coccyx stabilizer |
| `PF.TP.S` | Superficial Transverse Perineal | Pud | S2–S4 | Stabilizes perineal body |
| `PF.TP.D` | Deep Transverse Perineal | Pud | S2–S4 | Urogenital triangle support |
| `Sph.EA` | External Anal Sphincter | InfRec | S2–S4 | Voluntary anal closure — striated muscle |
| `Sph.IA` | Internal Anal Sphincter | PelSpl | L1–L2 | Involuntary anal tone — smooth muscle, autonomic |
| `Sph.EU` | External Urethral Sphincter | Pud | S2–S4 | Voluntary urethral closure |
| `Bulb` | Bulbospongiosus | Pud | S2–S4 | Perineal compression — expulsion/erection support |
| `Ischio` | Ischiocavernosus | Pud | S2–S4 | Perineal arch — engorgement maintenance |

### Grammar
```ebnf
ConTag      := "@ACT(" MuscleEntry ("," MuscleEntry)* ")"
MuscleEntry := MuscleSymbol ":" ActivationLevel
ActivationLevel := "1" | "2" | "3" | "4"
```

---

## 4.1 Muscle Detail Levels (LOD)

MNN muscles are organized into four **Levels of Detail**. Implementations declare which LOD they support. A compliant LOD 2 parser must accept all LOD 1 and LOD 2 symbols. Higher LOD symbols in a lower-LOD string must be preserved without error (forward compatibility rule, Section 13).

| LOD | Name | Muscle Count | Use Case |
|-----|------|-------------|----------|
| **LOD 1** | Functional | ~55 | Gym logging, basic avatar posing, exercise prescription, rehab |
| **LOD 2** | Anatomical | +32 | Clinical documentation, realistic skin deformation, forearm/hip/leg detail |
| **LOD 3** | High-Fidelity | +38 | Hand animation, gait analysis, exoskeleton control, surgical sim |
| **LOD 4** | Research | +24 | Full clinical/research — every named muscle |

> **LOD 1** = all muscles defined in Section 4 above this point.

The LOD tag is optional metadata for implementations. It does not appear in MNN strings. A string is valid regardless of LOD level as long as all symbols used are defined.

---

## 4.2 LOD 2 — Anatomical Fidelity

Adds forearm, deep hip rotators, lower leg, and neck accessory muscles. Required for accurate wrist/ankle biomechanics and clinical-grade documentation.

#### Forearm
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Pron.T` | Pronator Teres | Median | C6–C7 | Primary forearm pronator |
| `Pron.Q` | Pronator Quadratus | Median (AIN) | C8–T1 | Deep pronator — distal forearm |
| `Sup.M` | Supinator | Rad | C5–C6 | Forearm supination without elbow flexion |
| `Brachiorad` | Brachioradialis | Rad | C5–C6 | Elbow flexor — neutral forearm position |
| `FCR` | Flexor Carpi Radialis | Median | C6–C7 | Wrist flexion + radial deviation |
| `FCU` | Flexor Carpi Ulnaris | Ulnar | C8–T1 | Wrist flexion + ulnar deviation |
| `ECR.L` | Extensor Carpi Radialis Longus | Rad | C6–C7 | Wrist extension + radial deviation |
| `ECR.B` | Extensor Carpi Radialis Brevis | Rad | C7–C8 | Wrist extension — tennis elbow insertion |
| `ECU` | Extensor Carpi Ulnaris | Rad (PIN) | C7–C8 | Wrist extension + ulnar deviation |
| `FPL` | Flexor Pollicis Longus | Median (AIN) | C8–T1 | Thumb IP flexion — extrinsic |
| `EPL` | Extensor Pollicis Longus | Rad (PIN) | C7–C8 | Thumb IP extension — extrinsic |
| `EPB` | Extensor Pollicis Brevis | Rad (PIN) | C7–C8 | Thumb MCP extension — anatomical snuffbox |
| `AbdPol.L` | Abductor Pollicis Longus | Rad (PIN) | C7–C8 | Thumb abduction + wrist radial deviation |

#### Finger Extrinsics
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `FDS` | Flexor Digitorum Superficialis | Median | C7–T1 | PIP flexion, digits 2–5 |
| `FDP` | Flexor Digitorum Profundus | Median/Ulnar | C8–T1 | DIP flexion, digits 2–5 — split innervation |
| `EDC` | Extensor Digitorum Communis | Rad (PIN) | C7–C8 | MCP extension, digits 2–5 |
| `EDM` | Extensor Digiti Minimi | Rad (PIN) | C7–C8 | Little finger extension |
| `EIP` | Extensor Indicis Proprius | Rad (PIN) | C7–C8 | Index finger independent extension |

#### Deep Hip Rotators
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Pirif` | Piriformis | Sci/Pir | S1–S2 | External hip rotator — sciatic relationship |
| `ObInt` | Obturator Internus | Pud/ObInt | L5–S2 | Deep external rotator |
| `GemSup` | Gemellus Superior | ObInt | L5–S2 | Assists obturator internus |
| `GemInf` | Gemellus Inferior | QuadFem | L4–S1 | Assists quadratus femoris |
| `QuadFem` | Quadratus Femoris | QuadFemN | L4–S1 | External rotator + adductor |
| `TFL` | Tensor Fasciae Latae | SupGlu | L4–S1 | Hip flexion + abduction + IT band tension |
| `Iliopsoas` | Iliopsoas (Iliacus + Psoas Major) | Fem/L1–L3 | L1–L4 | Primary hip flexor |
| `Sart` | Sartorius | Fem | L2–L3 | Hip flexion + ER + knee flexion |

#### Lower Leg Detail
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Per.L` | Peroneus (Fibularis) Longus | Sci.P | L4–S1 | Plantarflexion + eversion — spans sole |
| `Per.B` | Peroneus (Fibularis) Brevis | Sci.P | L4–S1 | Eversion — inserts 5th metatarsal |
| `Tib.P` | Tibialis Posterior | Sci.T | L4–L5 | Inversion + plantarflexion — arch support |
| `FHL` | Flexor Hallucis Longus | Sci.T | S1–S2 | Big toe flexion — push-off power |
| `FDL` | Flexor Digitorum Longus | Sci.T | L5–S1 | Toes 2–5 flexion — grip/propulsion |
| `EDL` | Extensor Digitorum Longus | Sci.P | L4–S1 | Toes 2–5 extension + dorsiflexion assist |
| `EHL` | Extensor Hallucis Longus | Sci.P | L4–S1 | Big toe extension + ankle dorsiflexion |
| `Pop` | Popliteus | Sci.T | L4–S1 | Knee unlock — internal tibial rotation |

#### Neck Accessory
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Scal.A` | Anterior Scalene | Cerv | C4–C6 | Neck flexion + 1st rib elevation — breathing |
| `Scal.M` | Middle Scalene | Cerv | C3–C8 | Neck lateral flexion + 1st rib |
| `Scal.P` | Posterior Scalene | Cerv | C6–C8 | Neck lateral flexion + 2nd rib |
| `Lev.Scap` | Levator Scapulae | DorsScap/Cerv | C3–C5 | Scapular elevation + neck lateral flexion |
| `Spl.Cap` | Splenius Capitis | DorsRami | C3–C6 | Head extension + rotation |
| `Spl.Cerv` | Splenius Cervicis | DorsRami | C4–C8 | Cervical extension + rotation |

#### Additional Nerve Symbols (LOD 2)
| Symbol | Full Name |
|--------|----------|
| `Ulnar` | Ulnar Nerve |
| `Median` | Median Nerve |
| `PIN` | Posterior Interosseous Nerve (deep branch of radial) |
| `AIN` | Anterior Interosseous Nerve (branch of median) |
| `Pir` | Nerve to Piriformis |
| `ObIntN` | Nerve to Obturator Internus |
| `QuadFemN` | Nerve to Quadratus Femoris |
| `Cerv` | Cervical Plexus |

---

## 4.3 LOD 3 — High-Fidelity Simulation

Adds intrinsic hand muscles, foot intrinsics, and deep spinal stabilizers.

#### Thenar (Thumb Intrinsics)
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `AbdPol.Br` | Abductor Pollicis Brevis | Median | C8–T1 | Thumb palmar abduction — intrinsic |
| `FlexPol.Br` | Flexor Pollicis Brevis | Median/Ulnar | C8–T1 | Thumb MCP flexion — dual innervation |
| `OppPol` | Opponens Pollicis | Median | C8–T1 | Thumb opposition — pad-to-pad contact |
| `AddPol` | Adductor Pollicis | Ulnar | C8–T1 | Thumb adduction — pinch strength |

#### Hypothenar (Little Finger Intrinsics)
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `AbdDig.Mn` | Abductor Digiti Minimi | Ulnar | C8–T1 | Little finger abduction |
| `FlexDig.Mn` | Flexor Digiti Minimi Brevis | Ulnar | C8–T1 | Little finger MCP flexion |
| `OppDig.Mn` | Opponens Digiti Minimi | Ulnar | C8–T1 | Little finger cupping — hollow palm |

#### Hand Intrinsics — Lumbricals and Interossei
Digit suffix: F1 = thumb, F2 = index, F3 = middle, F4 = ring, F5 = little.

| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Lumb.F2` | Lumbrical 1 (index) | Median | C8–T1 | MCP flex + IP extend — intrinsic plus |
| `Lumb.F3` | Lumbrical 2 (middle) | Median | C8–T1 | MCP flex + IP extend |
| `Lumb.F4` | Lumbrical 3 (ring) | Ulnar | C8–T1 | MCP flex + IP extend |
| `Lumb.F5` | Lumbrical 4 (little) | Ulnar | C8–T1 | MCP flex + IP extend |
| `DI.F1` | First Dorsal Interosseous | Ulnar | C8–T1 | Index abduction — largest interosseous |
| `DI.F2` | Second Dorsal Interosseous | Ulnar | C8–T1 | Middle finger radial abduction |
| `DI.F3` | Third Dorsal Interosseous | Ulnar | C8–T1 | Middle finger ulnar abduction |
| `DI.F4` | Fourth Dorsal Interosseous | Ulnar | C8–T1 | Ring abduction |
| `PI.F2` | First Palmar Interosseous | Ulnar | C8–T1 | Index adduction |
| `PI.F3` | Second Palmar Interosseous | Ulnar | C8–T1 | Ring adduction |
| `PI.F4` | Third Palmar Interosseous | Ulnar | C8–T1 | Little finger adduction |

#### Foot Intrinsics
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Abd.Hall` | Abductor Hallucis | Plantmed | S1–S2 | Big toe abduction + arch support |
| `Add.Hall` | Adductor Hallucis | Plantlat | S2–S3 | Big toe adduction + transverse arch |
| `FlexHall.Br` | Flexor Hallucis Brevis | Plantmed | S1–S2 | Big toe MTP flexion — intrinsic |
| `FDB` | Flexor Digitorum Brevis | Plantmed | S1–S2 | Toes 2–5 PIP flexion — central plantar |
| `Abd.Dig.Mn.F` | Abductor Digiti Minimi (foot) | Plantlat | S2–S3 | Little toe abduction + lateral arch |
| `Lumb.T1` | Foot Lumbrical 1 | Plantmed | S2–S3 | Toe 2 MTP flex + IP extend |
| `Lumb.T2` | Foot Lumbrical 2 | Plantlat | S2–S3 | Toe 3 MTP flex + IP extend |
| `Lumb.T3` | Foot Lumbrical 3 | Plantlat | S2–S3 | Toe 4 MTP flex + IP extend |
| `Lumb.T4` | Foot Lumbrical 4 | Plantlat | S2–S3 | Toe 5 MTP flex + IP extend |
| `DI.T1` | First Dorsal Interosseous (foot) | Plantlat | S2–S3 | 2nd toe abduction |
| `DI.T2` | Second Dorsal Interosseous (foot) | Plantlat | S2–S3 | 3rd toe abduction |

#### Deep Spinal Stabilizers
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Multi` | Multifidus | DorsRami | C2–S5 | Deepest spinal extensor — segmental control |
| `Rot.Br` | Rotatores Brevis | DorsRami | T1–T12 | Short rotators — proprioception dominant |
| `Rot.Lg` | Rotatores Longus | DorsRami | T1–T12 | Long rotators — thoracic extension |
| `Semispin` | Semispinalis | DorsRami | C2–T12 | Spans 5–6 segments — extension + rotation |
| `Intertrans` | Intertransversarii | DorsRami/Vent | C2–L5 | Lateral stabilizers between vertebrae |
| `Interspinal` | Interspinales | DorsRami | C2–L5 | Short extensors between spinous processes |
| `Longi.Cap` | Longus Capitis | Cerv | C1–C3 | Deep cervical flexor — head on neck |
| `Longi.Col` | Longus Colli | Cerv | C2–C6 | Deep cervical flexor — cervical on thoracic |

#### Additional Nerve Symbols (LOD 3)
| Symbol | Full Name |
|--------|----------|
| `Plantmed` | Medial Plantar Nerve |
| `Plantlat` | Lateral Plantar Nerve |

---

## 4.4 LOD 4 — Research / Full Clinical

Adds remaining named muscles for complete anatomical coverage.

#### Remaining Hip / Thigh
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `ObExt` | Obturator Externus | Obturator | L3–L4 | External hip rotator — deep posterior |
| `Pectin` | Pectineus | Fem/Obturator | L2–L3 | Hip flexion + adduction |
| `GracilisM` | Gracilis | Obturator | L2–L3 | Adduction + knee flexion + IR |
| `Add.Lg` | Adductor Longus | Obturator | L2–L4 | Anterior adductor — most palpable |
| `Add.Br` | Adductor Brevis | Obturator | L2–L4 | Short adductor |
| `Add.Mx` | Adductor Magnus | Obturator/Sci.T | L2–S1 | Large — split innervation, two portions |

#### Remaining Lower Leg
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Per.T` | Peroneus (Fibularis) Tertius | Sci.P | L4–S1 | Weak dorsiflexor + eversion |
| `Plant` | Plantaris | Sci.T | S1–S2 | Vestigial — knee flexion + plantarflexion |

#### Deep Back (Remaining)
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Iliocos.Cerv` | Iliocostalis Cervicis | DorsRami | C4–C8 | Cervical portion of iliocostalis |
| `Iliocos.Thor` | Iliocostalis Thoracis | DorsRami | T1–T12 | Thoracic portion |
| `Iliocos.Lumb` | Iliocostalis Lumborum | DorsRami | L1–L5 | Lumbar portion — lateral erector |
| `Longi.Cap` | Longissimus Capitis | DorsRami | C1–C8 | Head extension + rotation |
| `Longi.Thor` | Longissimus Thoracis | DorsRami | T1–L5 | Largest erector component |
| `Spin.Thor` | Spinalis Thoracis | DorsRami | T2–T12 | Medial erector — spinous process to spinous |

#### Chest / Trunk (Remaining)
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Intercost.E` | External Intercostals | Intercostal | T1–T12 | Inspiration — rib elevation |
| `Intercost.I` | Internal Intercostals | Intercostal | T1–T12 | Expiration — rib depression |
| `Diaphragm` | Diaphragm | Phrenic | C3–C5 | Primary breathing muscle |
| `SubCost` | Subcostales | Intercostal | T8–T12 | Deep expiratory |

#### Additional Nerve Symbols (LOD 4)
| Symbol | Full Name |
|--------|----------|
| `Phrenic` | Phrenic Nerve |

---

## 4.5 LOD Quick Reference

```
LOD 1 — 55 muscles  (chest, shoulder, arm, back, neck, face, cuff, quad, ham/glute, leg, core, pelvic floor)
LOD 2 — +32 muscles (forearm x13, finger extrinsics x5, deep hip x8, lower leg detail x8, neck accessory x6)
LOD 3 — +38 muscles (thenar x4, hypothenar x3, lumbricals/interossei x11, foot intrinsics x11, deep spinal x8)
LOD 4 — +24 muscles (adductor detail x6, remaining lower leg x2, erector components x6, trunk/breathing x4, misc x6)
Total at LOD 4: ~149 named muscles
```

---

## 4.6 Avatar Surface Layer

> **Summary:** This section defines two optional tags — `@MORPH(...)` and `@BODY(...)` — that allow MNN strings to carry explicit surface rendering hints for avatar implementations. Both tags are always optional. Omitting them is fully valid MNN.

### 4.6.1 Default Activation-to-Morph Mapping

Compliant avatar renderers MUST derive morph target weights from `@ACT(...)` activation level as follows when no `@MORPH(...)` override is present:

| Activation | Morph Weight |
|---|---|
| *(absent)* | 0.0 |
| `:1` | 0.25 |
| `:2` | 0.50 |
| `:3` | 0.75 |
| `:4` | 1.00 |

The morph target identifier is the MNN muscle symbol. `@ACT(Bic:3)` → engine sets morph target `Bic` to 0.75.

### 4.6.2 The `@MORPH(...)` Tag

Optional override for explicit morph target weights. Use when the visible surface should differ from activation-level defaults.

```
@MORPH(Target=weight, Target=weight, ...)
```

Weights are floats 0.0–1.0. Targets are MNN muscle symbols with optional descriptor suffixes:

| Descriptor suffix | Description |
|---|---|
| *(none)* | Default overall morph |
| `.Long` / `.Short` | Muscle head specificity (LOD 2+) |
| `.Vasc` | Vascular surface response (pump) |
| `.Atr` | Atrophy — reduces surface below `@BODY(...)` baseline |
| `.Str` | Striation visibility |

Use `@MORPH(...)` for:
- **Isometric contractions**: `@ACT(Quad.VL:4) @JNT(L.Kn:Flex=0) @MORPH(Quad.VL=1.0)`
- **Muscle head specificity**: `@MORPH(Bic.Long=0.95,Bic.Short=0.4)`
- **Vascular response**: `@MORPH(Bic.Vasc=0.6)`
- **Clinical atrophy**: `@MORPH(Quad.VM.Atr=0.7)`

### 4.6.3 The `@BODY(...)` Tag

Declares the avatar's baseline body composition. Place once at session or record level.

```
@BODY(Mass=Nkg,BF=N%,Frame=X,Height=Ncm)
```

| Parameter | Values |
|---|---|
| `Mass` | number + `kg` or `lb` |
| `BF` | percentage (affects surface visibility scaling) |
| `Frame` | `XS`, `S`, `M`, `L`, `XL` |
| `Height` | number + `cm` or `in` |

### 4.6.4 Grammar

```ebnf
MorphTag    := "@MORPH(" MorphEntry ("," MorphEntry)* ")"
MorphEntry  := MorphTarget "=" MorphWeight
MorphTarget := Identifier ("." Identifier)*
MorphWeight := Float

BodyTag     := "@BODY(" BodyParam ("," BodyParam)* ")"
BodyParam   := BodyKey "=" BodyValue
BodyKey     := "Mass" | "BF" | "Frame" | "Height" | Identifier
BodyValue   := (Digit+ (".")? Digit* ("kg" | "lb" | "%" | "cm" | "in" | ""))
             | "XS" | "S" | "M" | "L" | "XL"
```

---

## 5. Nerve Output Tags

Nerve tags identify which peripheral nerves were active, and where peak contraction sensation targets.

### Format
```
>> Nerve/Nerve/Region
```

The `>>` double-arrow is MNN's nerve output marker. It differs visually from the Unicode right arrow used in clinical shorthand and other notation systems, and is ASCII-safe.

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
| `CNVII` | Cranial Nerve VII (Facial Nerve) — motor branch |
| `Pud` | Pudendal Nerve |
| `InfRec` | Inferior Rectal Nerve (branch of pudendal) |
| `PelSpl` | Pelvic Splanchnic Nerves (parasympathetic S2–S4) |

### Grammar
```ebnf
NerveTag := ">>" NerveSymbol ("/" NerveSymbol)*
```

---

## 6. Joint Taxonomy

This section defines the complete inventory of joints recognized by MNN — their symbols, anatomical hierarchy, degrees of freedom, and axis names.

### 6.1 Design Principles

- **Every joint has a symbol.** Symbols are short, consistent, and anatomically grounded.
- **Degrees of freedom (DOF) are explicit.** Each joint lists exactly which axes are valid.
- **Hierarchy is tracked.** Motion at a proximal joint propagates to all distal joints in the chain.
- **Side is always specified for paired joints.** Omitting side is only valid for midline joints.
- **Range limits are hard constraints.** Values outside physiological range MUST be rejected.

### 6.2 Kinematic Chain Hierarchy

```
Pelvis (root)
+-- Spine
|   +-- Lumbar (L1-L5)
|   +-- Thoracic (T1-T12)
|   +-- Cervical (C1-C7)
|   |   +-- Atlantoaxial (C1-C2)
|   +-- Head
|       +-- Temporomandibular (jaw)
+-- Sternoclavicular (L/R)
|   +-- Acromioclavicular (L/R)
|       +-- Scapulothoracic / Scapula (L/R)
|           +-- Glenohumeral / Shoulder (L/R)
|               +-- Elbow (L/R)
|                   +-- Radioulnar / Forearm (L/R)
|                       +-- Wrist (L/R)
|                           +-- Fingers (L/R) -- MCP -> PIP -> DIP (digits 1-5)
+-- Hip (L/R)
    +-- Knee (L/R)
        +-- Ankle (L/R)
            +-- Midfoot / Subtalar (L/R)
                +-- Toes (L/R) -- MTP -> PIP -> DIP (digits 1-5)
```

### 6.3 Joint Reference Table

#### Axial Skeleton — Midline Joints

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `Sp.L` | Lumbar Spine | 3 | Flex, Lat, Rot | Flex: -30 to 80; Lat: 0-35; Rot: 0-25 | Aggregated lumbar segment |
| `Sp.T` | Thoracic Spine | 3 | Flex, Lat, Rot | Flex: -30 to 45; Lat: 0-30; Rot: 0-55 | Aggregated thoracic segment |
| `Sp.C` | Cervical Spine | 3 | Flex, Lat, Rot | Flex: -60 to 80; Lat: 0-45; Rot: 0-80 | Aggregated C3-C7 |
| `AA` | Atlantoaxial (C1-C2) | 1 | Rot | Rot: 0-45 each side | |
| `TMJ` | Temporomandibular (Jaw) | 2 | Open, Lat | Open: 0-50mm; Lat: 0-12mm | Values in mm |

#### Shoulder Girdle (paired)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `SC` | Sternoclavicular | 3 | Elev, Pro, Rot | Elev: -5 to 45; Pro: -15 to 30; Rot: 0-50 | |
| `AC` | Acromioclavicular | 3 | UpRot, Tilt, Rot | UpRot: 0-30; Tilt: 0-30; Rot: 0-30 | |
| `Scap` | Scapulothoracic | 3 | Pro, Elev, UpRot | Pro: -15 to 15; Elev: -10 to 12; UpRot: 0-60 | |
| `Sh` | Glenohumeral (Shoulder) | 3 | Flex, Abd, IR, ER | Flex: -45 to 180; Abd: 0-180; IR: 0-90; ER: 0-90 | Primary limb joint |

#### Upper Limb (paired)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `El` | Elbow (Humeroulnar) | 1 | Flex | Flex: 0-145 | |
| `RU` | Radioulnar / Forearm | 1 | Pro, Sup | Pro: 0-90; Sup: 0-90 | |
| `Wr` | Wrist (Radiocarpal) | 2 | Flex, Rad, Uln | Flex: -70 to 80; Rad: 0-20; Uln: 0-35 | |

#### Hand — Fingers (paired, digits 1-5)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `MCP.F2-F5` | Metacarpophalangeal | 2 | Flex, Abd | Flex: -15 to 90; Abd: 0-30 | |
| `MCP.F1` | Thumb MCP | 1 | Flex | Flex: 0-80 | |
| `CMC.F1` | Thumb Carpometacarpal | 2 | Abd, Opp | Abd: 0-60; Opp: 0-70 | |
| `PIP.F2-F5` | Proximal Interphalangeal | 1 | Flex | Flex: 0-110 | |
| `DIP.F2-F5` | Distal Interphalangeal | 1 | Flex | Flex: 0-90 | |
| `IP.F1` | Thumb Interphalangeal | 1 | Flex | Flex: 0-80 | |

**Compact finger notation:**
```
@JNT(R.MCP.F2:Flex=70,Abd=5) @JNT(R.PIP.F2:Flex=90) @JNT(R.DIP.F2:Flex=45)
```

#### Lower Limb (paired)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `Hip` | Hip (Femoroacetabular) | 3 | Flex, Abd, IR, ER | Flex: -30 to 125; Abd: 0-45; IR: 0-45; ER: 0-45 | |
| `Kn` | Knee (Tibiofemoral) | 1 | Flex | Flex: 0-140 | |
| `Ank` | Ankle (Talocrural) | 1 | Dors, Plan | Dors: 0-20; Plan: 0-50 | |
| `Sub` | Subtalar | 1 | Inv, Ev | Inv: 0-35; Ev: 0-25 | |

#### Foot — Toes (paired, digits 1-5)

| Symbol | Joint Name | DOF | Axes | Range |
|--------|-----------|-----|------|-------|
| `MTP.T1-T5` | Metatarsophalangeal | 1 | Flex | Flex: -30 to 70 |
| `PIP.T2-T5` | Proximal Interphalangeal (toes) | 1 | Flex | Flex: 0-50 |
| `DIP.T2-T5` | Distal Interphalangeal (toes) | 1 | Flex | Flex: 0-40 |
| `IP.T1` | Hallux Interphalangeal | 1 | Flex | Flex: 0-60 |

### 6.4 DOF Summary by Region

| Region | Joints | Total DOF |
|--------|--------|----------|
| Axial (spine + jaw) | 5 | 13 |
| Shoulder girdle (x2) | 6 | 18 |
| Upper limb (x2) | 6 | 12 |
| Hand / fingers (x2) | 12 per hand | 48 |
| Lower limb (x2) | 4 | 16 |
| Foot / toes (x2) | 8 per foot | 32 |
| **Total (full body)** | | **~139+** |

### 6.5 Axis Naming Conventions

All axis names in MNN follow ISB Joint Coordinate System conventions (Wu et al., 2002/2005).

| Anatomical Motion | MNN Axis Symbol | Sign Convention |
|------------------|-----------------|----------------|
| Flexion | `Flex` | Positive = flexion; negative = extension |
| Abduction | `Abd` | Positive = abduction |
| Internal Rotation | `IR` | Positive = internal |
| External Rotation | `ER` | Positive = external |
| Pronation | `Pro` | Positive = pronation |
| Supination | `Sup` | Positive = supination |
| Radial Deviation | `Rad` | Positive = radial |
| Ulnar Deviation | `Uln` | Positive = ulnar |
| Dorsiflexion | `Dors` | Positive = dorsiflexion |
| Plantarflexion | `Plan` | Positive = plantarflexion |
| Inversion | `Inv` | Positive = inversion |
| Eversion | `Ev` | Positive = eversion |
| Lateral Flexion | `Lat` | Positive = right lateral flexion |
| Rotation | `Rot` | Positive = right rotation |
| Elevation | `Elev` | Positive = elevation |
| Upward Rotation | `UpRot` | Positive = upward |
| Opposition | `Opp` | Positive = opposition |

---

## 7. Joint Position Tags

Position tags define the angular state of each joint using anatomical degrees of freedom.

### Format
```
@JNT(Side.Joint:Axis=value,Axis=value,...)
```

The colon separates the joint identifier from its axis assignments. Axes use `=` for value assignment. Multiple joints in one tag are space-separated:

```
@JNT(L.Sh:IR=25,Flex=90 L.El:Flex=15)
```

### Side Identifiers
| Symbol | Meaning |
|--------|---------|
| `L` | Left |
| `R` | Right |
| `Bi` | Bilateral |
| *(omitted)* | Unspecified / midline |

### Joint Axis Reference

#### Shoulder (Sh) — 3 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Flex` | Flexion (+) / Extension (-) | -45 to 180 |
| `Abd` | Abduction / Adduction | 0 to 180 |
| `IR` | Internal Rotation | 0 to 90 |
| `ER` | External Rotation | 0 to 90 |

#### Elbow (El) — 2 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Flex` | Flexion | 0 to 145 |
| `Pro` | Pronation | 0 to 90 |
| `Sup` | Supination | 0 to 90 |

#### Wrist (Wr) — 2 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Flex` | Flexion (+) / Extension (-) | -70 to 80 |
| `Rad` | Radial Deviation | 0 to 20 |
| `Uln` | Ulnar Deviation | 0 to 35 |

#### Hip (Hip) — 3 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Flex` | Flexion (+) / Extension (-) | -30 to 125 |
| `Abd` | Abduction / Adduction | 0 to 45 |
| `IR` | Internal Rotation | 0 to 45 |
| `ER` | External Rotation | 0 to 45 |

#### Knee (Kn) — 1 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Flex` | Flexion | 0 to 140 |

#### Ankle (Ank) — 2 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Dors` | Dorsiflexion | 0 to 20 |
| `Plan` | Plantarflexion | 0 to 50 |
| `Inv` | Inversion | 0 to 35 |
| `Ev` | Eversion | 0 to 25 |

#### Spine (Sp) — 3 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Flex` | Flexion (+) / Extension (-) | -30 to 80 |
| `Lat` | Lateral Flexion | 0 to 35 |
| `Rot` | Rotation | 0 to 55 |

#### Scapula (Scap) — 3 DOF
| Axis | Full Name | Range (degrees) |
|------|-----------|----------------|
| `Pro` | Protraction (+) / Retraction (-) | -15 to 15 |
| `Elev` | Elevation (+) / Depression (-) | -10 to 12 |
| `UpRot` | Upward Rotation | 0 to 60 |

### Mapping to Euler Rotations

| Anatomical Axis | Euler Equivalent | SL/VW Equivalent |
|-----------------|-----------------|-------------------|
| Flexion/Extension | Pitch (X-axis rotation) | llSetLocalRot X |
| Abduction/Adduction | Roll (Z-axis rotation) | llSetLocalRot Z |
| Internal/External Rotation | Yaw (Y-axis rotation) | llSetLocalRot Y |

### Grammar
```ebnf
PosTag     := "@JNT(" [Side "."] JointEntry (" " JointEntry)* ")"
Side       := "L" | "R" | "Bi"
JointEntry := JointSymbol ":" AxisEntry ("," AxisEntry)*
AxisEntry  := AxisId "=" Integer
```

---

## 8. Resistance Vector Tags

Vector tags describe the external force applied to the body during the exercise.

### Format
```
@VEC(Ht=height,Ang=angle,Src=source)
```

### Height Values
| Value | Meaning | Approximate Position |
|-------|---------|---------------------|
| `Floor` | Floor level | 0-6 inches |
| `Low` | Low position | Knee height |
| `Mid` | Mid position | Chest / sternum height |
| `High` | High position | Head / above shoulder |
| `Over` | Overhead | Above head |

### Angle
- **0°** = Force vector directly ahead (sagittal plane)
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

For automated equipment, the vector tag can be extended:

```
@VEC(Ht=Mid,Ang=0°,Src=Cable,Load=20lb,Pulley=48in)
```

| Extension | Type | Meaning |
|-----------|------|---------|
| `Load` | String | Resistance magnitude with unit |
| `Pulley` | String | Exact pulley height from floor |
| `Speed` | String | Cable speed (for isokinetic modes) |
| `Accom` | String | Accommodating resistance curve ID |

### Grammar
```ebnf
VecTag    := "@VEC(" VecEntry ("," VecEntry)* ")"
VecEntry  := "Ht=" HeightVal | "Ang=" Integer "deg" | "Src=" SourceVal | ExtKey "=" Value
HeightVal := "Floor" | "Low" | "Mid" | "High" | "Over"
SourceVal := "Cable" | "Band" | "Gravity" | "Machine" | "Manual"
```

Note: `°` and `deg` are both accepted for angle values.

---

## 9. Compensation Tags

Compensation tags flag when the wrong muscle dominated the movement.

### Format
```
@COMP(Compensator/Target)
```

Where `Compensator` is the muscle that took over and `Target` is the muscle that should have been the prime mover. The `/` separator reads as "instead of."

### Common Compensations
| Tag | Meaning |
|-----|---------|
| `@COMP(Dlt.A/Pec.S)` | Anterior deltoid took over for sternal pec |
| `@COMP(Trp.U/Dlt.L)` | Shrugging instead of lateral raise |
| `@COMP(Bic/Lat)` | Biceps pulling instead of back |
| `@COMP(Ers/Glu.Mx)` | Low back extending instead of glutes |
| `@COMP(Trp.U/Trp.L)` | Upper trap compensating for weak lower trap |

### Grammar
```ebnf
CompTag := "@COMP(" MuscleSymbol "/" MuscleSymbol ")"
```

---

## 10. Nerve Status Tags

Nerve status tags record which spinal levels were symptomatic at the time of the exercise.

### Format
```
@NERV(C5-C6,T8-T9)
```

### Spinal Level Format
- **Cervical:** C1-C2, C2-C3, C3-C4, C4-C5, C5-C6, C6-C7, C7-C8
- **Thoracic:** T1-T2 through T11-T12 (11 levels)
- **Lumbar:** L1-L2, L2-L3, L3-L4, L4-L5
- **Lumbosacral:** L5-S1
- **Sacral:** S1-S2

### Grammar
```ebnf
NervStatusTag := "@NERV(" Level ("," Level)* ")"
Level         := SpineSegment "-" SpineSegment
SpineSegment  := ("C" | "T" | "L" | "S") Integer
```

---

## 11. Facial Expression Examples

Facial expression tags use the same `@ACT(...)` format as body muscles.

```
@ACT(Zyg.Mj:3, Orb.Oc:2) >> CNVII           // Duchenne smile
@ACT(Corr:3, Front:1) >> CNVII               // concentrated frown
@ACT(Orb.Or:2, Bucc:1) >> CNVII              // lips pursed
@ACT(Dep.Ang:3, Lev.Lab:2, Nas:1) >> CNVII  // disgust
@ACT(Front:3) >> CNVII                        // brow raise — surprise
```

Combined body + face:
```
@ACT(Corr:3, Dep.Ang:2, Orb.Or:1) >> CNVII
@JNT(Sp.C:Flex=15,Lat=8 Scap:Pro=-10,Elev=-8)
```

FACS Mapping (informational):

| MNN Symbol | FACS AU | Description |
|------------|---------|-------------|
| `Front` | AU1+AU2 | Brow raiser |
| `Corr` | AU4 | Brow lowerer |
| `Orb.Oc` | AU5 / AU46 | Lid tightener / wink |
| `Zyg.Mj` | AU12 | Lip corner puller |
| `Zyg.Mn` | AU6 | Cheek raiser |
| `Dep.Ang` | AU15 | Lip corner depressor |
| `Lev.Lab` | AU9 | Nose wrinkler |
| `Orb.Or` | AU20 / AU22 | Lip stretcher / funneler |
| `Ment` | AU17 | Chin raiser |
| `Nas` | AU38 | Nostril dilator |

---

## 12. Complete Example

A single-arm cable fly, left side, with shoulder at 25 degrees internal rotation, cable at mid height, using the sternal pec as prime mover, on a day when C5-C6 was flared:

```
@NERV(C5-C6)
@MOV(Pull.H) @ACT(Pec.S:3, Dlt.A:1) >> MedPec/Axil
@JNT(L.Sh:IR=25,Flex=90,Abd=10) @VEC(Ht=Mid,Ang=0°,Src=Cable)
```

This string is simultaneously:
- A gym log entry a human can read
- A machine instruction set that could drive a cable rig to reproduce the position
- A clinical record of neuromuscular activation pattern with joint angles
- A VR/game engine command for avatar posing with force application

**Legacy v1.x equivalent (still accepted by v2.0 parsers):**
```
[Nerve:C5-C6]
{Pull.H} [Con:Pec.S+++, Dlt.A+] → MedPec/Axil
[Pos:L.Sh(IR:25,Flex:90,Abd:10)] [Vec:H:Mid,A:0°,Src:Cable]
```

---

## 13. Formal Grammar (EBNF)

```ebnf
MNNString     := [MovTag] [ActTag] [NerveTag] [PosTag] [VecTag] [CompTag] [NervStatusTag]

MovTag        := "@MOV(" Identifier ["." Identifier] ")"
ActTag        := "@ACT(" MuscleEntry ("," MuscleEntry)* ")"
MuscleEntry   := Identifier ":" ActivationLevel
ActivationLevel := "1" | "2" | "3" | "4"
NerveTag      := ">>" Identifier ("/" Identifier)*
PosTag        := "@JNT(" [Side "."] JointEntry (" " JointEntry)* ")"
Side          := "L" | "R" | "Bi"
JointEntry    := Identifier ":" AxisEntry ("," AxisEntry)*
AxisEntry     := Identifier "=" Integer
VecTag        := "@VEC(" KVPair ("," KVPair)* ")"
KVPair        := Identifier "=" Value
CompTag       := "@COMP(" Identifier "/" Identifier ")"
NervStatusTag := "@NERV(" Level ("," Level)* ")"
Level         := Segment "-" Segment
Segment       := Letter Digits
MorphTag      := "@MORPH(" MorphEntry ("," MorphEntry)* ")"
MorphEntry    := MorphTarget "=" Float
BodyTag       := "@BODY(" BodyParam ("," BodyParam)* ")"
BodyParam     := Identifier "=" Value

Identifier    := Letter (Letter | Digit | ".")*
Value         := (Letter | Digit | "°" | "." | "-" | "%")+
Integer       := ["-"] Digits
Float         := Digit+ ["." Digit+]
Digits        := Digit+
Letter        := "A"-"Z" | "a"-"z"
Digit         := "0"-"9"
```

### Legacy v1.x Grammar (accepted for backward compatibility)

```ebnf
LegacyMovTag  := "{" Identifier ["." Identifier] "}"
LegacyActTag  := "[Con:" LegacyMuscle ("," LegacyMuscle)* "]"
LegacyMuscle  := Identifier ("+" | "++" | "+++" | "++++")
LegacyNerve   := ("-->" | Unicode_Arrow) Identifier ("/" Identifier)*
LegacyPosTag  := "[Pos:" [Side "."] Identifier "(" LegacyAxis ("," LegacyAxis)* ")" "]"
LegacyAxis    := Identifier ":" Integer
LegacyVecTag  := "[Vec:" LegacyKV ("," LegacyKV)* "]"
LegacyKV      := Identifier ":" Value
Unicode_Arrow := U+2192
```

---

## 14. Implementation Notes

### Parser Requirements
Any MNN v2.0 parser MUST:
1. Accept `@` tags in any order within a string
2. Treat all tags as optional
3. Preserve unknown tags without error (forward compatibility)
4. Parse muscle symbols case-sensitively (`Pec.S` != `pec.s`)
5. Accept `>>` as the v2.0 nerve arrow
6. Accept both `→` (U+2192) and `->` as legacy nerve arrows (v1.x compatibility)
7. Accept both v2.0 `@TAG(...)` syntax and v1.x `[TAG:...]` / `{...}` syntax

**MNN string identifier:** A string is identifiable as MNN if it contains at least one `@MOV`, `@ACT`, `@JNT`, `@VEC`, `@COMP`, `@NERV`, `@MORPH`, or `@BODY` tag, or contains the `>>` nerve arrow. This is the unambiguous MNN fingerprint.

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

## 15. Clinical Anatomy Extension — Genital Structures

> **Web access:** This section is restricted to authenticated users on bodspas-site. The full content is committed to this repository for copyright prior art purposes.

### 15.1 Genital Muscle Symbols

#### Male
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Corp.Cav` | Corpus Cavernosum | CavN | S2-S4 | Erectile tissue column — bilateral paired |
| `Corp.Sp` | Corpus Spongiosum | CavN | S2-S4 | Surrounds urethra, forms glans |
| `Glan.P` | Glans Penis | DorsN.P | S2-S4 | Sensory end-organ |
| `Prep` | Prepuce | DorsN.P | S2-S4 | Retractile skin fold |

#### Female
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Glan.C` | Glans Clitoris | DorsN.C | S2-S4 | Primary sensory end-organ |
| `Corp.C` | Clitoral Body / Crura | CavN.C | S2-S4 | Bilateral erectile tissue |
| `Bulb.V` | Vestibular Bulbs | PelSpl | S2-S4 | Paired erectile tissue flanking vaginal opening |
| `Lab.Mj` | Labia Majora | IlioIng/Pud | L1/S2-S4 | Outer labial fold |
| `Lab.Mn` | Labia Minora | Pud | S2-S4 | Inner labial fold |
| `Vag.Or` | Vaginal Orifice / Introitus | Pud | S2-S4 | Opening; tone via surrounding pelvic floor |
| `Hymen` | Hymenal Remnants | Pud | S2-S4 | Vestigial tissue ring at introitus |

#### Anal Canal
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Anod` | Anoderm | InfRec | S2-S4 | Highly sensory anal canal skin |
| `AV.Cush` | Anal Vascular Cushions | InfRec/PelSpl | S2-S4 | Hemorrhoidal plexus |
| `Anococ` | Anococcygeal Body | Pud | S3-S4 | Fibromuscular raphe between anus and coccyx |

### 15.2 Additional Nerves

| Symbol | Full Name | Notes |
|--------|-----------|-------|
| `CavN` | Cavernous Nerve (male) | Parasympathetic — erection |
| `CavN.C` | Cavernous Nerve (female) | Clitoral erection |
| `DorsN.P` | Dorsal Nerve of Penis | Somatic sensory |
| `DorsN.C` | Dorsal Nerve of Clitoris | Somatic sensory |
| `IlioIng` | Ilioinguinal Nerve | Sensory to anterior labia majora / upper scrotum |

### 15.3 Notation Examples

```
// Anal canal resting tone
@ACT(Sph.EA:1, Sph.IA:1, AV.Cush:1) >> InfRec/PelSpl

// Post-prostatectomy rehab
@ACT(Sph.EU:1, PF.PC:1) >> Pud
@COMP(Trans.Ab/Sph.EU)

// Female avatar pelvic floor + genital neutral
@ACT(PF.PC:2, Sph.EA:1, Glan.C:1) >> Pud/InfRec/DorsN.C
```

### 15.4 Avatar Default States

| Symbol | Default | Rationale |
|--------|---------|----------|
| `Corp.Cav` / `Corp.C` | `0` | Fully relaxed unless explicitly set |
| `AV.Cush` | `:1` | Vascular cushions provide baseline closure |
| `Sph.IA` | `:1` | Involuntary resting tone always present |

Activation level `0` is valid for genital structures only and means fully relaxed / no tone.

---

## 16. Prior Art and Related Standards

MNN exists at the intersection of several established fields, each with its own standards and notation systems. None of them combine neuromuscular targeting, joint position, resistance vector, and compensation tracking into a single notation. MNN bridges this gap.

### 16.1 Biomechanics — ISB Joint Coordinate System (JCS)

The International Society of Biomechanics (ISB) published joint coordinate system definitions in two papers:
- **Part I** (Wu et al., 2002): Ankle, hip, and spine — *Journal of Biomechanics* 35, 543-548
- **Part II** (Wu et al., 2005): Shoulder, elbow, wrist, and hand — *Journal of Biomechanics* 38, 981-992

ISB JCS defines local coordinate systems on proximal and distal bone segments, with joint rotations expressed as Euler/Cardan angles. It is a research reporting convention — not a compact text notation, does not encode muscle activation or nerve involvement, and is not designed for real-time logging.

MNN's `@JNT(...)` tag is compatible with ISB joint axis conventions. The anatomical axes map directly to ISB's recommended decomposition sequences.

### 16.2 Motion Capture — C3D, BVH, OpenSim

| Format | Origin | Type | Content |
|--------|--------|------|--------|
| **C3D** | NIH, mid-1980s | Binary | 3D marker positions, analog data, parameters |
| **BVH** | Biovision, 1990s | ASCII | Skeletal hierarchy + per-frame joint rotations |
| **OpenSim .trc/.mot** | Stanford/NIH | ASCII | Marker trajectories and motion files |
| **FBX** | Autodesk | Binary | Animation data including mesh, skeleton, motion |
| **MVNX** | Xsens | XML | IMU-based motion capture with joint angles |

These are sensor data formats — time-series from motion capture hardware. Not designed for human authoring, do not encode muscle/nerve activity, do not capture training intent.

### 16.3 Electromyography — SENIAM and ISEK

SENIAM (Surface EMG for Non-Invasive Assessment of Muscles) developed electrode placement recommendations for 30 muscles. EMG output is voltage waveforms normalized to %MVC. Research papers use informal muscle abbreviations but there is no formal standardized symbol table.

MNN's `@ACT(...)` tag provides what EMG lacks: a standardized symbol table with defined abbreviations, explicit nerve innervation mapping, and qualitative activation levels (:1/:2/:3/:4) that approximate low/moderate/high/max MVC categories without requiring sensor hardware.

### 16.4 Exercise Prescription — ACSM FITT and NSCA

The ACSM FITT principle (Frequency, Intensity, Time, Type) and NSCA sets x reps x load shorthand capture dose but encode zero information about joint position, nerve involvement, muscle targeting, or compensation patterns.

MNN is complementary to FITT/NSCA notation:
```
Session: Upper Push -- 3x12x20lb RPE:6
@MOV(Push.H) @ACT(Pec.S:3, Dlt.A:1) >> MedPec/Axil
@JNT(L.Sh:IR=25,Flex=90) @VEC(Ht=Mid,Src=Cable)
```

### 16.5 Dance and Movement — Labanotation, Eshkol-Wachman, and HamNoSys

**Labanotation** (Rudolf Laban, 1920s) uses a vertical staff with symbols for direction, level, timing, body part, and effort quality. It has no concept of which nerve fired, which muscle contracted, what the resistance vector was, or whether compensation occurred.

**Eshkol-Wachman Movement Notation (EWMN)** uses a spherical coordinate system to describe the position of each body segment. It is closer to MNN's `@JNT(...)` tag in concept — both use per-joint angular values — but uses a proprietary symbol/number staff notation, requires specialist training, has no concept of muscle activation or nerve involvement, and has never been adapted to machine-parseable plain text.

**HamNoSys / SiGML** was developed for sign language transcription and extended into SiGML (Signing Gesture Markup Language), an XML format that can drive avatar hand and arm animations. HamNoSys is the closest existing system to MNN's avatar control use case. It operates on hands and arms only, has no muscle activation semantics, no lower body, no resistance vectors, and no neuromuscular data.

MNN's `@JNT(...)` system covers all joints that HamNoSys covers and extends to the full body, face, and lower limbs, while adding the neuromuscular layer that no movement notation has previously encoded.

### 16.6 Why No Unified Notation Exists

Every field that touches human movement built its own silo. A biomechanics lab uses C3D files that only their software can read. A gym equipment manufacturer stores joint angles in proprietary firmware. A physical therapy clinic documents exercises in prose. A game studio uses BVH files that encode skeleton motion but nothing about which muscles fired or why.

The practical effect: when your movement data lives inside a vendor's format, taking it with you is expensive and painful. The patient who got a detailed movement analysis at one clinic starts from zero at another. The athlete whose gym tracked their joint angles on brand-name machines loses all that data when they switch facilities.

MNN exists because this sentence:

*"This person's left shoulder was at 25 degrees internal rotation and 90 degrees flexion while contracting the sternal pec via the medial pectoral nerve using a mid-height cable"*

should be writable as:

```
@ACT(Pec.S:3) >> MedPec @JNT(L.Sh:IR=25,Flex=90) @VEC(Ht=Mid,Src=Cable)
```

...and that string should work in a gym log, a clinical record, a game engine, a cable rig controller, and a research paper without conversion, without proprietary software, and without paying anyone for the privilege of reading your own movement data.

MNN is an open notation. It is plain text. It requires no special software to read. It requires no license to write.

### 16.7 Summary — The MNN Gap

| Domain | Standard | What It Captures | What It Lacks |
|--------|----------|-----------------|---------------|
| Joint angles | ISB JCS | Per-joint rotations via Euler angles | No muscle/nerve data, no compact text format |
| Motion data | C3D/BVH/OpenSim | Full-body time-series from sensors | No semantic layer, no human authoring |
| Muscle activity | EMG + SENIAM | Voltage waveforms, electrode standards | No standardized symbol table, no nerve mapping |
| Exercise dose | ACSM FITT / NSCA | Frequency, intensity, sets x reps x load | No joint position, no muscle targeting |
| Choreography | Labanotation | Spatial path, timing, effort quality | No neuromuscular data, no resistance vector |
| Body movement research | Eshkol-Wachman | Per-joint spherical coordinates | Proprietary staff notation, no muscle/nerve, not machine-parseable |
| Sign language / avatar gestures | HamNoSys / SiGML | Avatar-ready hand/arm gesture control | Hands and arms only, no muscle activation, not human-readable |
| **All of the above** | **MNN** | **Muscle + nerve + joint + vector + compensation** | **--** |

---

## 17. Intellectual Property

Muscular Neuro Notation (MNN) is an original notation system created by Tom and published by AIUNITES LLC under the BODWAVE product line. This specification document serves as timestamped prior art establishing authorship and publication date.

The MNN v2.0 notation format — specifically the `@TAG(...)` annotation syntax, `>>` nerve output arrow, numeric activation levels (`:1/:2/:3/:4`), `=` axis assignment within joint tags, and `/` compensation separator — constitutes the original creative expression of this specification and is the intellectual property of AIUNITES LLC.

The underlying concepts (muscle abbreviations, joint angles, nerve innervation) are grounded in established clinical anatomy and are not proprietary. The MNN contribution is the specific combination, syntax design, three-domain architecture (exercise/avatar/remote control), and unified human-readable/machine-parseable format.

### Trademark Strategy

**BODWAVE(TM)** is the primary consumer-facing trademark for the MNN product line and is the mark planned for federal trademark registration.

**MNN(TM), VRN(TM), VNN(TM), HMN(TM)** are acronym marks planned for registration as word marks in software/technology services classes.

Reference implementation: https://aiunites.github.io/bodspas-site/log.html

---

## 18. Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.0.0 | April 3, 2026 | Complete syntax redesign. All tags migrated from `[TAG:...]` / `{...}` / `+` style to `@TAG(...)` / `>>` / `:N` annotation style. Movement tags: `{Pattern}` to `@MOV(Pattern)`. Contraction tags: `[Con:Muscle+++]` to `@ACT(Muscle:3)`. Nerve arrow: Unicode right-arrow / `->` to `>>`. Joint position: `[Pos:Side.Joint(Axis:val)]` to `@JNT(Side.Joint:Axis=val)`. Vector: `[Vec:H:height,A:angle,Src:src]` to `@VEC(Ht=height,Ang=angle,Src=src)`. Compensation: `[Comp:A for B]` to `@COMP(A/B)`. Nerve status: `[Nerve:C5-C6]` to `@NERV(C5-C6)`. Morph: `[Morph:M:w]` to `@MORPH(M=w)`. Body: `[Body:K:V]` to `@BODY(K=V)`. v1.x backward-compatibility grammar added. Formal MNN string identifier defined (`@` prefix). Activation level 4 added (maximum voluntary contraction). |
| 1.6.0 | March 18, 2026 | Added Section 4.6 -- Avatar Surface Layer: `[Morph:]` and `[Body:]` tags. |
| 1.5.1 | March 15, 2026 | Added Eshkol-Wachman and HamNoSys/SiGML to prior art. |
| 1.5.0 | March 15, 2026 | Added HMN umbrella relationship. Added LOD 1-4 muscle framework. |
| 1.4.0 | March 14, 2026 | Added Clinical Anatomy Extension (genital structures). |
| 1.3.0 | March 14, 2026 | Added pelvic floor and perineum muscle symbols. |
| 1.2.0 | March 14, 2026 | Added facial expression muscle symbols and FACS mapping. |
| 1.1.0 | March 12, 2026 | Added complete joint taxonomy with hierarchy and DOF table. |
| 1.0.0 | March 1, 2026 | Initial specification. |

---

*MNN Specification v2.0.0 -- (C) 2026 AIUNITES LLC / BODWAVE*
*This document constitutes original creative expression and is submitted for copyright registration.*
*GitHub commit history establishes continuous authorship from March 1, 2026.*
