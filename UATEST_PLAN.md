# BodSpas - UA Test Plan

## Site Information
| Field | Value |
|-------|-------|
| **Site Name** | BodSpas |
| **Repository** | bodspas-site |
| **Live URL** | https://bodspas.com/ |
| **Local Path** | C:/Users/Tom/Documents/GitHub/bodspas-site |
| **Last Updated** | February 28, 2026 |
| **Version** | 1.5.0 |
| **Based On** | Custom Landing |

---

## Pages Inventory

| Page | File | Description | Status |
|------|------|-------------|--------|
| Landing/Home | index.html | Main landing page | ✅ |
| BodWave | bodwave.html | Mind-Neuro-Muscle Notation (MNN) — 11 notation categories across 3 complexity tiers (🟢 Gym Floor / 🟡 Coach / 🔴 Clinical/BCI). BodWave Scale BW1–BW4. 4-Stage Training Progression. Sister system to VNN at VoiceStry. | ✅ |
| Press | press.html | Technical brief: what bodybuilders use now vs MNN, muscle focus/joint protection, "The Machine That Doesn't Exist Yet" (cable chest press worked example, PT comparison, episodic vs continuous care, 3-layer tech table, real-time correction vision), MNN for virtual worlds & game engines, who needs MNN, disclaimer, references (18 citations), IP/DMCA notice. | ✅ Updated |
| Gallery | gallery.html | Photo slideshow gallery | ✅ |

---

## Core Features

### 🎨 UI/UX Features
| Feature | Status | Notes |
|---------|--------|-------|
| Dark Theme | ✅ | Red/orange gradient accents |
| Responsive Design | ✅ | Mobile-first approach |
| Smooth Scroll | ✅ | Anchor link navigation |
| Fixed Navigation | ✅ | Scrolled state with blur |
| Mobile Menu | ✅ | Slide-in hamburger menu |
| AIUNITES Webring | ✅ | Top bar + Footer link |

### 📊 SEO & Analytics
| Feature | Status | Notes |
|---------|--------|-------|
| Meta Title | ✅ | Optimized for search |
| Meta Description | ✅ | |
| Open Graph Tags | ✅ | Facebook/social sharing |
| Twitter Cards | ✅ | |
| Canonical URL | ✅ | bodspas.com |
| Google Analytics 4 | ✅ | G-VP15KRLV6P |
| JSON-LD Schema | ⬜ | TODO: Add structured data |

### 📄 Content Sections
| Section | Status | Notes |
|---------|--------|-------|
| Hero | ✅ | Stats, CTAs, badge |
| Features Grid | ✅ | 6 feature cards |
| Programs | ✅ | 3 program cards |
| Nutrition | ✅ | Macro visualization |
| Recovery | ✅ | 4 recovery cards |
| Results/Testimonials | ✅ | 3 result cards |
| CTA/Signup | ✅ | Email form |
| Footer | ✅ | 4-column layout |

---

## Site-Specific Features

### 💪 Fitness Content
| Feature | Status | Notes |
|---------|--------|-------|
| Program Cards | ✅ | Foundation, Hypertrophy, Shred |
| Macro Calculator Visual | ✅ | Protein/Carbs/Fats rings |
| Before/After Stats | ✅ | In results section |
| Recovery Tips | ✅ | Sleep, mobility, cold/heat, massage |

### 📧 Lead Capture
| Feature | Status | Notes |
|---------|--------|-------|
| Email Signup Form | ✅ | Hero and CTA sections |
| Form Validation | ✅ | Required email |
| Success Message | ✅ | Alert on submit |

---

### 📷 Images
| Location | Filename | Status |
|----------|----------|--------|
| Hero | sport-6820867_1280.jpg | ✅ |
| Program 1 | man-5883500_1280.jpg | ✅ |
| Program 2 | muscles-7877929_1280.jpg | ✅ |
| Program 3 | abs-6349095_1280.jpg | ✅ |
| Nutrition | athlete-6232790_1280.jpg | ✅ |
| Social | og-image.png | 🔲 TODO |

---

### 🎨 Gallery Page
| Feature | Status | Notes |
|---------|--------|-------|
| Auto-start slideshow | ✅ | 5 second intervals |
| Play/Pause button | ✅ | Spacebar shortcut |
| Previous/Next buttons | ✅ | Arrow key shortcuts |
| Progress bar | ✅ | Visual timer |
| Navigation dots | ✅ | Click to jump |
| Thumbnail grid | ✅ | All 12 photos |
| Slide captions | ✅ | Title + description |
| Responsive design | ✅ | Mobile friendly |

---

## Test Scenarios

### UI Tests
- [x] Navigation links scroll smoothly
- [x] Mobile menu opens/closes
- [x] Navbar changes on scroll
- [x] All buttons have hover states
- [x] Responsive at 768px breakpoint
- [x] Responsive at 480px breakpoint

### Content Tests
- [x] All sections render correctly
- [x] Images/icons display
- [x] Typography hierarchy clear
- [x] Color scheme consistent

### Form Tests
- [x] Email validation works
- [x] Submit triggers alert
- [x] Form resets after submit

---

## Known Issues / TODO

| Issue | Priority | Status |
|-------|----------|--------|
| Add JSON-LD structured data | Medium | 🔲 TODO |
| Create og-image.png | High | 🔲 TODO |
| Add blog section | Low | 🔲 TODO |
| Add actual programs pages | Medium | 🔲 TODO |
| Connect signup to backend | High | 🔲 TODO |
| Add favicon.ico | Low | 🔲 TODO |

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | Feb 1, 2026 | Initial release - landing page |

---

## Status Legend
- ✅ Implemented and tested
- ⬜ Not implemented
- 🔲 TODO
- ⚠️ Partial/Issues
- ❌ Removed/Deprecated

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | Feb 1, 2026 | Initial site creation |
| 1.0.1 | Feb 22, 2026 | Webring highlight fix: standardized to .aiunites-bar-active class with white (#fff) + underline styling |
| 1.1.0 | Feb 24, 2026 | BodWave page: complete nerve→muscle mapping for all major groups, BodWave Scale (BW1–BW4), clinical nerve tests, VNN cross-link. Nav updated on all pages. Sitemap updated. |
| 1.2.0 | Feb 24, 2026 | Press page: "What Bodybuilders Use Now" comparison (sets×reps, RPE, tempo, EMG vs MNN), "Muscle Focus: More Gains, Less Joint Damage" (wrong pathway problem, shoulder-dominant vs pec-dominant bench in MNN, muscle control artists = joint protection, joint protection table for 7 exercises), "MNN for Virtual Worlds" (skeletal animation, blend shapes, mocap, procedural anim vs neural control layer), "Who Needs MNN" audience cards, IP section. Nav updated on all pages. Sitemap updated. |
| 1.3.0 | Feb 27, 2026 | MNN rebrand: "Muscular Neuro Notation" → "Mind-Neuro-Muscle Notation" (Mind→Neuro→Muscle chain). Category 9: Directional Axis & Force Vector (laterality L:/R:/Bi:, 16 joint action codes, 6 force vectors ⇢Med/Lat/Sup/Inf/Ant/Post, 3 movement planes #Sag/#Fro/#Trn). Oblique rotation, rotator cuff, BCI gait worked examples. Hero stat 8→9 categories. h4 CSS. IP notice updated. |
| 1.4.0 | Feb 27, 2026 | MNN Complexity Tiers (🟢 Gym Floor / 🟡 Coach / 🔴 Clinical/BCI). Tier badges on all 11 category headings. Category 10: Range of Motion (ROM:Full, ROM:X°–Y°, ROM:Short/Mid/Long, ROM:Limited, ROM:Δ+). Category 11: Antagonist & Synergist Pairing (Ag:/Ant:/Syn:/Stb:, Ant:CoC, Ant:❌) with bicep curl + BCI elbow extension examples. Hero stat 9→11 categories. NEW SECTION: "How to Train Mind-Muscle Connection" — neuroscience of touch during training, GTO insertion point targeting, Graston/IASTM sensory amplification method (original contribution), 4-Stage Training Progression (Tactile Guided → Tool Amplified → Proprioceptive Only → Isolated Voluntary), 4-week practical protocol table. IP notice updated with training methodology + all new notation layers. |
| 1.5.0 | Feb 28, 2026 | Press page: NEW SECTION "The Machine That Doesn't Exist Yet" — cable chest press worked example (perpendicular grinding vs 25° IR clean) fully notated in MNN. PT comparison (current assessment vs MNN-equipped future). 3-layer technology table (Mind/EEG, Neuro/EMG, Muscle/IMU). Real-time angle correction, nerve pathway verification, personal neural profile vision. "PT + MNN Machine = Complete" side-by-side. NEW SUBSECTION "The Moment You Walk Out the Door" — episodic care vs continuous monitoring, 45-min/week retention window problem, posture drift in MNN (office correction vs parking lot reversion), wearable haptic correction vision, PT sets target pattern / machine enforces between visits. MNN positioned as middleware protocol for future integrated biofeedback systems. NEW SECTIONS: Disclaimer (not medical advice, consult professionals, anatomical generalizations, technology claims, PT characterization caveat) and References (18 peer-reviewed citations across 5 categories: mind-muscle connection/attentional focus, IMU wearable joint angle measurement, EEG/BCI motor intention detection, anatomy/biomechanics textbooks, shoulder impingement mechanics). |

---

*AIUNITES Network Site*
*Created: February 1, 2026*
*Last tested: February 28, 2026*
