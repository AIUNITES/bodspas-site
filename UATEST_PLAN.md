# BodSpas - UA Test Plan

## Site Information
| Field | Value |
|-------|-------|
| **Site Name** | BodSpas |
| **Repository** | bodspas-site |
| **Live URL** | https://bodspas.com/ |
| **Local Path** | C:/Users/Tom/Documents/GitHub/bodspas-site |
| **Last Updated** | February 1, 2026 |
| **Version** | 1.0.0 |
| **Based On** | Custom Landing |

---

## Pages Inventory

| Page | File | Description | Status |
|------|------|-------------|--------|
| Landing/Home | index.html | Main landing page | ✅ |
| BodWave | bodwave.html | Muscular Neuro Notation (MNN) — maps every muscle to its nerve, spinal root, and exercises. BodWave is the training brand, MNN is the formal notation. BodWave Scale BW1–BW4. Sister system to VNN at VoiceStry. | ✅ New |
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

---

*AIUNITES Network Site*
*Created: February 1, 2026*
*Last tested: February 22, 2026*
