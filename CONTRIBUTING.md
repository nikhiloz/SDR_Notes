# Contributing to SDR_Notes

Thank you for your interest in contributing to SDR_Notes! This document provides guidelines to maintain consistency across the documentation.

---

## 📝 Documentation Philosophy

All contributions must follow these principles:

### 1. Tables Before Code

Present information in tables whenever possible:

```markdown
| Parameter | Value | Description |
|-----------|-------|-------------|
| frequency | MHz | Center frequency |
| sample_rate | MSPS | Sample rate |
```

### 2. Context Before Visuals

Always write 1-2 sentences before any table, diagram, or code block:

```markdown
The following table shows common frequency allocations:

| Band | Frequency | Usage |
|------|-----------|-------|
| VHF | 30-300 MHz | FM, TV |
```

### 3. ASCII Diagrams Required

Use ASCII art for diagrams instead of images:

```markdown
    ┌──────────┐     ┌──────────┐
    │  Input   │────▶│  Output  │
    └──────────┘     └──────────┘
```

---

## 📂 File Structure

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Folders | NN_Topic_Name | 01_Fundamentals |
| README | README.md | README.md |
| Content | Title_Case.md | What_Is_SDR.md |

### Required Elements

Every content file should include:

1. **Title** - H1 heading with file name
2. **Description** - Brief overview in blockquote
3. **Contents table** - For files with sections
4. **ASCII diagram** - Visual representation
5. **Tables** - Structured information
6. **References** - Where applicable

---

## 🔧 Markdown Standards

### Headers

```markdown
# Main Title (H1) - one per file
## Major Section (H2)
### Subsection (H3)
#### Detail (H4)
```

### Code Blocks

Always specify language:

```python
# Python example
import numpy as np
```

```bash
# Shell command
rtl_fm -f 100.3M -M wbfm -s 200000 - | aplay -r 48000 -f S16_LE
```

### Tables

Align columns for readability:

```markdown
| Short | Longer Header | Description                |
|-------|---------------|----------------------------|
| A     | Value         | Brief description here    |
| B     | Another       | Another description here  |
```

---

## ✅ Checklist Before Submitting

- [ ] Tables used for structured data
- [ ] Context sentences before tables/diagrams
- [ ] ASCII diagrams (no external images)
- [ ] Consistent formatting
- [ ] Spell-checked content
- [ ] Links work correctly
- [ ] Follows folder structure

---

## 🏷️ Topics to Contribute

### Needed Documentation

| Priority | Topic | Location |
|----------|-------|----------|
| High | HackRF One guide | 02_Hardware/ |
| High | PlutoSDR guide | 02_Hardware/ |
| High | SDR++ guide | 03_Software/ |
| Medium | QPSK demodulation | 05_Modulation/ |
| Medium | DMR decoding | 06_Protocols/ |
| Low | RADAR basics | 09_Advanced_Topics/ |

---

Thank you for helping make SDR_Notes better!
