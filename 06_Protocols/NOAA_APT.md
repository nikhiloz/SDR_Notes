# NOAA APT — Weather Satellite Image Reception

> Receive real-time weather images from NOAA polar-orbiting satellites using a simple V-dipole antenna and RTL-SDR.

---

## 1. NOAA APT Overview

NOAA-15, NOAA-18, and NOAA-19 broadcast **Automatic Picture Transmission (APT)** — an analog image format transmitted on VHF during every overhead pass (~10 minutes per pass).

```
┌──────────────┐   137 MHz VHF   ┌─────────────┐
│  NOAA Sat    │ ──────────────► │  SDR + Ant   │
│  (polar orbit)│   APT analog   │  V-dipole    │
└──────────────┘                 └──────┬───────┘
                                        │
                                 ┌──────▼───────┐
                                 │  Decoder      │
                                 │  (noaa-apt /  │
                                 │   WXtoImg)    │
                                 └──────┬───────┘
                                        │
                                 ┌──────▼───────┐
                                 │  Weather      │
                                 │  Image        │
                                 └──────────────┘
```

## 2. Satellite Frequencies

| Satellite | Frequency   | Status              |
|-----------|-------------|---------------------|
| NOAA-15   | 137.620 MHz | Active              |
| NOAA-18   | 137.9125 MHz| Active              |
| NOAA-19   | 137.100 MHz | Active (primary)    |

**Modulation**: AM with 2400 Hz subcarrier, 256 grey levels

**Bandwidth**: ~34 kHz

## 3. Required Equipment

| Item           | Recommendation          | Cost     |
|----------------|-------------------------|----------|
| SDR            | RTL-SDR Blog V3/V4      | ~$30     |
| Antenna        | V-dipole (137 MHz)      | ~$10 DIY |
| LNA (optional) | Nooelec SAWbird+ NOAA   | ~$35     |
| Software       | GQRX/SDR++ + noaa-apt   | Free     |

### V-Dipole Antenna

```
       ←── 53.4 cm ──→       ←── 53.4 cm ──→
       ╲                                    ╱
        ╲          120° angle              ╱
         ╲                                ╱
          ╲──────── coax ───────────────╱
                     │
                  to SDR
```

Each element = λ/4 at 137 MHz ≈ **53.4 cm**

## 4. Reception Workflow

### Step 1: Track Passes

```bash
# Use gpredict or https://www.n2yo.com/
# Passes above 30° elevation work best
sudo apt install gpredict
```

### Step 2: Record the Pass

```bash
# Record raw audio at 137.100 MHz (NOAA-19)
rtl_fm -f 137100000 -M fm -s 60000 -r 11025 -g 48 -E deemp - | \
    sox -t raw -r 11025 -e signed -b 16 -c 1 - noaa19_pass.wav
```

### Step 3: Decode the Image

```bash
# Using noaa-apt (Rust-based, recommended)
# Install from https://noaa-apt.mbernardi.com.ar/
noaa-apt noaa19_pass.wav -o weather_image.png

# Or using WXtoImg (legacy, Windows/Wine)
```

## 5. Tips for Better Images

- **Elevation**: Passes above **40°** give the clearest images
- **Doppler**: Not critical for APT (wide FM), but some software auto-corrects
- **LNA**: A filtered LNA at 137 MHz dramatically improves SNR
- **Location**: Avoid buildings; open sky is ideal
- **Recording**: Use 48 kHz sample rate for best quality with noaa-apt

## 6. LRPT (Meteor-M2)

Russian Meteor-M N2 satellites broadcast **LRPT** (Low Rate Picture Transmission) — a digital format with colour images:

| Parameter      | APT (NOAA)    | LRPT (Meteor) |
|----------------|---------------|----------------|
| Format         | Analog        | Digital (QPSK) |
| Frequency      | 137.x MHz     | 137.100 MHz    |
| Resolution     | 4 km/pixel    | 1 km/pixel     |
| Colour         | B&W (2 ch)    | Full colour    |
| Decoder        | noaa-apt      | MeteorDemod    |

## 7. India-Specific Notes

- Passes are frequent over the Indian subcontinent (equator-crossing orbits)
- ISRO's Resourcesat and Oceansat also transmit but require larger dishes
- Best reception season: October–February (clearer skies, less convective noise)

---

**See also**: [Project: Weather Satellite](../08_Practical_Projects/Project_Weather_Satellite.md) | [Antenna Basics](../01_Fundamentals/Antenna_Basics.md)
