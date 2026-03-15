# Muscular Neuro Notation (MNN) — Formal Specification

**Version:** 1.5.0  
**Date:** March 15, 2026  
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

MNN is a protocol within the **Human Movement Notation (HMN)** family, published by AIUNITES LLC. HMN is the umbrella standard for all open notation systems for human movement; MNN covers the body (muscles, nerves, joints, resistance vectors), VRN (Voice Resonance Notation) covers vocal production, and VNN (Voice Neural Notation) covers AI voice synthesis. All three are applications of the same underlying principle: encode human movement as portable, human-readable, machine-parseable text.

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
```
ConTag := "[Con:" MuscleEntry ("," MuscleEntry)* "]"
MuscleEntry := MuscleSymbol ActivationLevel
ActivationLevel := "+" | "++" | "+++"
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

> **LOD 1** = all muscles defined in Section 4 above this point (chest, shoulders, arms, back, neck, face, rotator cuff, quadriceps, hamstrings/glutes, legs, core, pelvic floor — v1.0.0 through v1.4.0).

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

Adds intrinsic hand muscles, foot intrinsics, and deep spinal stabilizers. Required for realistic hand animation, barefoot gait, exoskeleton fine motor control, and full spine model.

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

Adds remaining named muscles for complete anatomical coverage. Primarily relevant for surgical simulation, full-body musculoskeletal modeling, and research-grade biomechanics.

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

When declaring LOD support in an implementation, use the following summary to determine which symbols must be recognized:

```
LOD 1 — 55 muscles  (v1.0–v1.4 symbols: chest, shoulder, arm, back, neck, face, cuff, quad, ham/glute, leg, core, pelvic floor)
LOD 2 — +32 muscles (forearm ×13, finger extrinsics ×5, deep hip ×8, lower leg detail ×8, neck accessory ×6)
LOD 3 — +38 muscles (thenar ×4, hypothenar ×3, lumbricals/interossei ×11, foot intrinsics ×11, deep spinal ×8, deep cervical ×1)
LOD 4 — +24 muscles (adductor detail ×6, remaining lower leg ×2, erector components ×6, trunk/breathing ×4, misc ×6)
```

**Total at LOD 4: ~149 named muscles** across all body regions.

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
| `CNVII` | Cranial Nerve VII (Facial Nerve) — motor branch |
| `Pud` | Pudendal Nerve |
| `InfRec` | Inferior Rectal Nerve (branch of pudendal) |
| `PelSpl` | Pelvic Splanchnic Nerves (parasympathetic S2–S4) |

### Grammar
```
NerveTag := "→" NerveSymbol ("/" NerveSymbol)*
```

---

## 6. Joint Taxonomy

This section defines the complete inventory of joints recognized by MNN — their symbols, anatomical hierarchy, degrees of freedom, and axis names. This is the reference table. The notation format for encoding joint angles in an MNN string is defined in Section 7.

### 6.1 Design Principles

- **Every joint has a symbol.** Symbols are short, consistent, and anatomically grounded.
- **Degrees of freedom (DOF) are explicit.** Each joint lists exactly which axes are valid for that joint — you cannot express wrist rotation in a joint that has no rotation axis.
- **Hierarchy is tracked.** Joints are organized by kinematic chain. Motion at a proximal joint propagates to all distal joints in the chain. Parsers and avatar rigs MUST respect this hierarchy when computing global pose.
- **Side is always specified for paired joints.** Any joint that exists on both left and right sides requires a side prefix (`L.` / `R.`) in the notation. Omitting side is only valid for midline joints (spine, jaw, sternum).
- **Range limits are hard constraints.** Values outside the physiological range listed for each axis MUST be rejected by compliant parsers and machine controllers.

---

### 6.2 Kinematic Chain Hierarchy

The body is modeled as a tree of rigid segments connected at joints. The root is the **pelvis**. All other joints are children of their proximal neighbor.

```
Pelvis (root)
├── Spine
│   ├── Lumbar (L1–L5)
│   ├── Thoracic (T1–T12)
│   ├── Cervical (C1–C7)
│   │   └── Atlantoaxial (C1–C2)
│   └── Head
│       └── Temporomandibular (jaw)
├── Sternoclavicular (L/R)
│   └── Acromioclavicular (L/R)
│       └── Scapulothoracic / Scapula (L/R)
│           └── Glenohumeral / Shoulder (L/R)
│               └── Elbow (L/R)
│                   └── Radioulnar / Forearm (L/R)
│                       └── Wrist (L/R)
│                           └── Fingers (L/R) — MCP → PIP → DIP (digits 1–5)
├── Hip (L/R)
│   └── Knee (L/R)
│       └── Ankle (L/R)
│           └── Midfoot / Subtalar (L/R)
│               └── Toes (L/R) — MTP → PIP → DIP (digits 1–5)
```

---

### 6.3 Joint Reference Table

#### Axial Skeleton — Midline Joints

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `Sp.L` | Lumbar Spine | 3 | Flex, Lat, Rot | Flex: −30 to 80°; Lat: 0–35°; Rot: 0–25° | Aggregated lumbar segment |
| `Sp.T` | Thoracic Spine | 3 | Flex, Lat, Rot | Flex: −30 to 45°; Lat: 0–30°; Rot: 0–55° | Aggregated thoracic segment |
| `Sp.C` | Cervical Spine | 3 | Flex, Lat, Rot | Flex: −60 to 80°; Lat: 0–45°; Rot: 0–80° | Aggregated C3–C7 |
| `AA` | Atlantoaxial (C1–C2) | 1 | Rot | Rot: 0–45° each side | Nodding (C0–C1) + rotation (C1–C2) |
| `TMJ` | Temporomandibular (Jaw) | 2 | Open, Lat | Open: 0–50mm; Lat: 0–12mm | Value in mm, not degrees |

#### Shoulder Girdle (paired)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `SC` | Sternoclavicular | 3 | Elev, Pro, Rot | Elev: −5 to 45°; Pro: −15 to 30°; Rot: 0–50° | Often implicit in scapula motion |
| `AC` | Acromioclavicular | 3 | UpRot, Tilt, Rot | UpRot: 0–30°; Tilt: 0–30°; Rot: 0–30° | Often implicit in scapula motion |
| `Scap` | Scapulothoracic | 3 | Pro, Elev, UpRot | Pro: −15 to 15°; Elev: −10 to 12°; UpRot: 0–60° | Composite SC + AC motion |
| `Sh` | Glenohumeral (Shoulder) | 3 | Flex, Abd, IR, ER | Flex: −45 to 180°; Abd: 0–180°; IR: 0–90°; ER: 0–90° | Primary limb joint |

#### Upper Limb (paired)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `El` | Elbow (Humeroulnar) | 1 | Flex | Flex: 0–145° | Hinge only; carrying angle ~15° not encoded |
| `RU` | Radioulnar / Forearm | 1 | Pro, Sup | Pro: 0–90°; Sup: 0–90° | Forearm rotation — often grouped with elbow |
| `Wr` | Wrist (Radiocarpal) | 2 | Flex, Rad, Uln | Flex: −70 to 80°; Rad: 0–20°; Uln: 0–35° | Negative flex = extension |

#### Hand — Fingers (paired, digits 1–5)

Finger joints use a digit number suffix: `F1` = thumb, `F2` = index, `F3` = middle, `F4` = ring, `F5` = little.

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `MCP.F2–F5` | Metacarpophalangeal | 2 | Flex, Abd | Flex: −15 to 90°; Abd: 0–30° | Knuckle joint, fingers 2–5 |
| `MCP.F1` | Thumb MCP | 1 | Flex | Flex: 0–80° | Thumb knuckle |
| `CMC.F1` | Thumb Carpometacarpal | 2 | Abd, Opp | Abd: 0–60°; Opp: 0–70° | Saddle joint — thumb base |
| `PIP.F2–F5` | Proximal Interphalangeal | 1 | Flex | Flex: 0–110° | Middle finger joint |
| `DIP.F2–F5` | Distal Interphalangeal | 1 | Flex | Flex: 0–90° | Fingertip joint |
| `IP.F1` | Thumb Interphalangeal | 1 | Flex | Flex: 0–80° | Thumb tip joint |

**Compact finger notation:** When encoding a full hand pose, use bracket grouping:
```
[Pos:R.MCP.F2(Flex:70,Abd:5) PIP.F2(Flex:90) DIP.F2(Flex:45)]
```

#### Lower Limb (paired)

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `Hip` | Hip (Femoroacetabular) | 3 | Flex, Abd, IR, ER | Flex: −30 to 125°; Abd: 0–45°; IR: 0–45°; ER: 0–45° | Ball-and-socket |
| `Kn` | Knee (Tibiofemoral) | 1 | Flex | Flex: 0–140° | Hinge; small axial rotation not encoded |
| `Ank` | Ankle (Talocrural) | 1 | Dors, Plan | Dors: 0–20°; Plan: 0–50° | True ankle = dorsi/plantarflexion only |
| `Sub` | Subtalar | 1 | Inv, Ev | Inv: 0–35°; Ev: 0–25° | Inversion/eversion — separate from ankle |

#### Foot — Toes (paired, digits 1–5)

Toe joints use the same digit suffix convention as fingers. `T1` = hallux (big toe).

| Symbol | Joint Name | DOF | Axes | Range | Notes |
|--------|-----------|-----|------|-------|-------|
| `MTP.T1–T5` | Metatarsophalangeal | 1 | Flex | Flex: −30 to 70° | Negative = extension (toe-off phase) |
| `PIP.T2–T5` | Proximal Interphalangeal (toes) | 1 | Flex | Flex: 0–50° | |
| `DIP.T2–T5` | Distal Interphalangeal (toes) | 1 | Flex | Flex: 0–40° | |
| `IP.T1` | Hallux Interphalangeal | 1 | Flex | Flex: 0–60° | Big toe tip |

---

### 6.4 DOF Summary by Region

| Region | Joints | Total DOF |
|--------|--------|----------|
| Axial (spine + jaw) | 5 | 13 |
| Shoulder girdle (×2) | 6 | 18 |
| Upper limb (×2) | 6 | 12 |
| Hand / fingers (×2) | 12 per hand | 48 |
| Lower limb (×2) | 4 | 16 |
| Foot / toes (×2) | 8 per foot | 32 |
| Pelvic floor | muscles only | see Section 4 |
| **Total (full body)** | | **~139+** |

> **Note on pelvic floor:** Pelvic floor and perineal muscles are encoded via `[Con:]` tags only. They do not have dedicated `[Pos:]` joint entries because they operate as soft-tissue tensioners, not rigid-segment rotators. Activation level (+ / ++ / +++) encodes contraction state. This is consistent with how these structures are assessed clinically (MVC percentage, endurance holds) and in avatar rigs (blend shape or soft-body deformation, not skeletal rotation).

For most exercise and rehabilitation use cases, only the **primary joints** (spine, shoulder, elbow, wrist, hip, knee, ankle) are needed — approximately 25 DOF. Finger and toe joints are most relevant for hand therapy, gait analysis, avatar animation, and robotic hand control.

---

### 6.5 Axis Naming Conventions

All axis names in MNN follow the **ISB Joint Coordinate System** conventions (Wu et al., 2002/2005). Positive values always follow the right-hand rule with the local X-axis pointing along the bone's long axis distally.

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
| Protraction | `Pro` | Positive = protraction |
| Upward Rotation | `UpRot` | Positive = upward |
| Opposition | `Opp` | Positive = opposition |

---

## 7. Joint Position Tags

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

The following subsections define the notation format. For the full joint inventory including all axes and ranges, see Section 6.3.

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

## 10. Facial Expression Examples

Facial expression tags use the same `[Con:]` format as body muscles. Side prefix (`L.`/`R.`) is required for paired muscles (orbicularis oculi, zygomaticus), omitted for midline muscles (frontalis, procerus).

### Compact Notation
```
[Con:Zyg.Mj+++, Orb.Oc++] → CNVII          // smile with eye engagement (Duchenne smile)
[Con:Corr+++, Front+] → CNVII               // concentrated frown with slight brow raise
[Con:Orb.Or++, Bucc+] → CNVII               // lips pursed, cheeks engaged
[Con:Dep.Ang+++, Lev.Lab++, Nas+] → CNVII   // disgust expression
[Con:Front+++] → CNVII                       // brow raise only — surprise
```

### Combined Body + Face Example
Avatar receiving bad news — shoulders drop, head tilts, expression shifts:
```
[Con:Corr+++, Dep.Ang++, Orb.Or+] → CNVII
[Pos:Sp.C(Flex:15,Lat:8) Scap(Pro:-10,Elev:-8)]
```

### Full Anatomy Mode (display only)
```
[Con:Zygomaticus Major+++, Orbicularis Oculi++] → Facial Nerve
[Con:Corrugator Supercilii+++, Frontalis+] → Facial Nerve
```

### FACS Mapping (informational)
For interoperability with animation and emotion AI systems, MNN face symbols map to FACS Action Units:

| MNN Symbol | FACS AU | Description |
|------------|---------|-------------|
| `Front` | AU1+AU2 | Brow raiser |
| `Corr` | AU4 | Brow lowerer |
| `Orb.Oc` | AU5 (relax) / AU46 (wink) | Lid tightener / wink |
| `Zyg.Mj` | AU12 | Lip corner puller |
| `Zyg.Mn` | AU6 | Cheek raiser |
| `Dep.Ang` | AU15 | Lip corner depressor |
| `Lev.Lab` | AU9 | Nose wrinkler |
| `Orb.Or` | AU20 | Lip stretcher / AU22 lip funneler |
| `Ment` | AU17 | Chin raiser |
| `Nas` | AU38 | Nostril dilator |

MNN does not adopt FACS numbering internally. The mapping is provided for implementors building bridges to animation tools (Unreal MetaHuman, Apple ARKit blendshapes, etc.).

---

## 11. Complete Example

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

## 12. Formal Grammar (EBNF)

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

## 13. Implementation Notes

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
- **Compact:** Uses symbols (`Pec.S`, `MedPec`, `Sh`, `Zyg.Mj`, `CNVII`)
- **Full Anatomy:** Uses full names (`Sternal Pec`, `Medial Pectoral`, `Shoulder`, `Zygomaticus Major`, `Facial Nerve`)

---

## 14. Clinical Anatomy Extension — Genital Structures

> **Web access:** This section is restricted to authenticated users on bodspas-site. The full content is committed to this repository for DMCA prior art purposes. See `bodwave.html` for the gated web implementation.

### 14.1 Genital Muscle Symbols

#### Male
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Corp.Cav` | Corpus Cavernosum | CavN | S2–S4 | Erectile tissue column — bilateral paired |
| `Corp.Sp` | Corpus Spongiosum | CavN | S2–S4 | Surrounds urethra, forms glans |
| `Glan.P` | Glans Penis | DorsN.P | S2–S4 | Sensory end-organ |
| `Prep` | Prepuce | DorsN.P | S2–S4 | Retractile skin fold |

#### Female
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Glan.C` | Glans Clitoris | DorsN.C | S2–S4 | Primary sensory end-organ |
| `Corp.C` | Clitoral Body / Crura | CavN.C | S2–S4 | Bilateral erectile tissue |
| `Bulb.V` | Vestibular Bulbs | PelSpl | S2–S4 | Paired erectile tissue flanking vaginal opening |
| `Lab.Mj` | Labia Majora | IlioIng/Pud | L1/S2–S4 | Outer labial fold |
| `Lab.Mn` | Labia Minora | Pud | S2–S4 | Inner labial fold |
| `Vag.Or` | Vaginal Orifice / Introitus | Pud | S2–S4 | Opening; tone via surrounding pelvic floor |
| `Hymen` | Hymenal Remnants | Pud | S2–S4 | Vestigial tissue ring at introitus |

#### Anal Canal
| Symbol | Full Name | Nerve | Spinal Roots | Notes |
|--------|-----------|-------|-------------|-------|
| `Anod` | Anoderm | InfRec | S2–S4 | Highly sensory anal canal skin, proximal to verge |
| `AV.Cush` | Anal Vascular Cushions | InfRec/PelSpl | S2–S4 | Hemorrhoidal plexus — contributes to resting closure |
| `Anococ` | Anococcygeal Body | Pud | S3–S4 | Fibromuscular raphe between anus and coccyx |

### 14.2 Additional Nerves

| Symbol | Full Name | Notes |
|--------|-----------|-------|
| `CavN` | Cavernous Nerve (male) | Parasympathetic — erection; branch of pelvic splanchnic |
| `CavN.C` | Cavernous Nerve (female) | Clitoral erection; branch of pelvic splanchnic |
| `DorsN.P` | Dorsal Nerve of Penis | Somatic sensory — branch of pudendal |
| `DorsN.C` | Dorsal Nerve of Clitoris | Somatic sensory — branch of pudendal |
| `IlioIng` | Ilioinguinal Nerve | Sensory to anterior labia majora / upper scrotum |

### 14.3 Notation Examples

```
// Anal canal resting tone (avatar default)
[Con:Sph.EA+, Sph.IA+, AV.Cush+] → InfRec/PelSpl

// Post-prostatectomy rehab
[Con:Sph.EU+, PF.PC+] → Pud
[Comp:Trans.Ab for Sph.EU]

// Female avatar pelvic floor + genital neutral
[Con:PF.PC++, Sph.EA+, Glan.C+] → Pud/InfRec/DorsN.C
```

### 14.4 Avatar Default States

| Symbol | Default | Rationale |
|--------|---------|----------|
| `Corp.Cav` / `Corp.C` | `0` | Fully relaxed unless explicitly set |
| `AV.Cush` | `+` | Vascular cushions provide baseline closure |
| `Sph.IA` | `+` | Involuntary resting tone always present |

Activation level `0` is valid for genital structures only and means fully relaxed / no tone.

---

## 15. Prior Art and Related Standards

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

### 13.5 Dance and Movement — Labanotation, Eshkol-Wachman, and HamNoSys

Labanotation (Kinetography Laban), created by Rudolf Laban in the 1920s, is the most widely known notation system for human movement. It uses a vertical staff with symbols for direction, level, timing, body part, and effort quality. It is comprehensive for choreographic description and is used in dance, theater, and movement therapy.

Labanotation describes *where* the body goes through space and with what quality of effort (Float, Punch, Glide, Slash, Dab, Wring, Flick, Press). It has no concept of which nerve fired, which muscle contracted, what the resistance vector was, or whether compensation occurred. It is a visual notation requiring specialized training to read and write.

Birdwhistell's Kinesics system offers hundreds of codes for body part movements but is used in psychology for gesture analysis, not exercise.

**Eshkol-Wachman Movement Notation (EWMN)**, developed by Noa Eshkol and Abraham Wachman in the 1950s, uses a spherical coordinate system to describe the position of each body segment relative to its proximal joint. The body is modeled as a stick figure with segments and joints; positions are encoded as pairs of numbers on a spherical grid. EWMN has been applied in computer graphics, architecture, animal behavior analysis, Israeli Sign Language, and Tai Chi analysis. It is more mathematically rigorous than Labanotation and closer to MNN's `[Pos:]` tag in concept — both use per-joint angular values. However, EWMN uses a proprietary symbol/number system written on a staff, requires specialist training, has no concept of muscle activation or nerve involvement, and has never been adapted to machine-parseable plain text.

**HamNoSys (Hamburg Notation System)** was developed in the 1980s at the University of Hamburg specifically for sign language transcription. It encodes handshape, hand orientation, location, and movement using a visual symbol set. Unlike Labanotation, HamNoSys is explicitly designed to be avatar-independent — it describes gestures at a level of abstraction that any avatar rig can execute. HamNoSys has been extended into **SiGML (Signing Gesture Markup Language)**, an XML-based format that can drive avatar hand and arm animations in real time, and has been used to animate sign language avatars in virtual worlds.

HamNoSys/SiGML is the closest existing system to MNN's avatar control use case. It operates on hands and arms only, has no muscle activation semantics, no lower body, no face (beyond facial grammar markers in sign language), no resistance vectors, and no neuromuscular data. It is also not human-readable without specialist training in the symbol set.

MNN's `[Pos:]` tag system covers all joints that HamNoSys covers (hand, wrist, elbow, shoulder) and extends to the full body, face, and lower limbs, while adding the neuromuscular layer that no movement notation has previously encoded.

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
| Body movement research | Eshkol-Wachman | Per-joint spherical coordinates | Proprietary staff notation, no muscle/nerve, not machine-parseable |
| Sign language / avatar gestures | HamNoSys / SiGML | Avatar-ready hand/arm gesture control | Hands and arms only, no muscle activation, not human-readable |
| **All of the above** | **MNN** | **Muscle + nerve + joint + vector + compensation** | **—** |

MNN is the first notation system that combines neuromuscular targeting (which muscles, which nerves, from which spinal roots), joint position (ISB-compatible degrees per axis), resistance vector (source, height, angle), and compensation tracking into a single human-readable, machine-parseable string.

---

## 15. Intellectual Property

Muscular Neuro Notation (MNN) is an original notation system created by Tom and published by AIUNITES LLC under the BODWAVE product line. This specification document serves as timestamped prior art establishing authorship and publication date.

The notation format, symbol tables, tag grammar, three-domain architecture (exercise, avatar, remote control), and the concept of a unified human-readable/machine-parseable human movement notation system are the intellectual property of AIUNITES LLC.

### Trademark Strategy

**BODWAVE™** is the primary consumer-facing trademark for the MNN product line and is the mark planned for federal trademark registration. BODWAVE is an arbitrary coined mark with no descriptive meaning in the relevant class, making it the strongest trademark candidate in the AIUNITES IP portfolio.

**MNN™, VRN™, VNN™, HMN™** are acronym marks planned for registration as word marks in software/technology services classes. As acronyms they are arbitrary relative to their expanded forms and are registrable independent of the descriptive nature of the underlying phrases.

The phrase "Human Movement Notation" and its abbreviation "HMN" are used as descriptive names for the notation family. The prior art established by this specification and the dated GitHub commit history constitutes the primary IP protection for the system architecture and notation format.

All AIUNITES web applications (BodSpas, Gameatica, VideoBate, AIByJob, ERPize, and all other sites in the AIUNITES network) operate as part of AIUNITES LLC.

Reference implementation: https://aiunites.github.io/bodspas-site/log.html

---

## 16. Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.5.1 | March 15, 2026 | Added Eshkol-Wachman Movement Notation (EWMN) and HamNoSys/SiGML to Section 13.5 prior art; added both to Section 13.7 summary table. |
| 1.5.0 | March 15, 2026 | Added HMN umbrella relationship to Section 1.1 — MNN formally positioned as a protocol within Human Movement Notation (HMN) alongside VRN and VNN. Added Section 4.1–4.5 — Muscle Level of Detail (LOD) framework: LOD 1 (Functional, ~55 muscles, existing symbols), LOD 2 (Anatomical, +32: forearm ×13, finger extrinsics ×5, deep hip ×8, lower leg ×8, neck accessory ×6), LOD 3 (High-Fidelity, +38: thenar ×4, hypothenar ×3, lumbricals/interossei ×11, foot intrinsics ×11, deep spinal ×8), LOD 4 (Research, +24: adductor detail, erector components, breathing muscles); LOD quick reference table; additional nerve symbols per LOD (Median, Ulnar, PIN, AIN, Plantmed, Plantlat, Phrenic). Total at LOD 4: ~149 named muscles. |
| 1.4.0 | March 14, 2026 | Added Section 14 — Clinical Anatomy Extension (Genital Structures): male genital symbols (4), female genital symbols (7), anal canal symbols (3); 5 new nerve symbols (`CavN`, `CavN.C`, `DorsN.P`, `DorsN.C`, `IlioIng`); avatar default states table; activation level `0` defined for genital structures. Section marked as web-gated / login-required on bodspas-site. |
| 1.3.0 | March 14, 2026 | Added pelvic floor & perineum muscle symbols (11 muscles, Section 4); added `Pud`, `InfRec`, `PelSpl` to nerve table (Section 5); pelvic floor note added to DOF summary (Section 6.4); added Section 11 — Pelvic Floor & Sphincter Examples with clinical, avatar seated pose, relaxation, and rehab contexts. Section numbering shifted. |
| 1.2.0 | March 14, 2026 | Added facial expression muscle symbols (14 muscles, Section 4); added `CNVII` to nerve table (Section 5); added Section 10 — Facial Expression Examples with compact/full anatomy notation, combined body+face example, and FACS AU mapping table. Section numbering shifted accordingly. |
| 1.1.0 | March 12, 2026 | Added Section 6 — Joint Taxonomy: complete joint inventory with hierarchy, all DOF, axis naming conventions, finger/toe joints, TMJ, sternoclavicular, acromioclavicular, subtalar; DOF summary table; ISB axis sign convention table. Section 7 onwards renumbered. |
| 1.0.0 | March 1, 2026 | Initial specification — movement, contraction, nerve, position, vector, compensation, nerve status tags, joint position, resistance vector, prior art analysis |

---

*MNN Specification v1.0.0 — © 2026 AIUNITES LLC / BODWAVE*
