# Project: Weather Satellite Image Receiver

> Receive NOAA APT and Meteor LRPT weather images using RTL-SDR and a V-dipole antenna.

---

## 1. Project Overview

| Item          | Details                               |
|---------------|---------------------------------------|
| Difficulty    | Beginner–Intermediate                 |
| SDR required  | RTL-SDR (any)                         |
| Antenna       | V-dipole (137 MHz) or QFH            |
| Software      | GQRX/SDR++ + noaa-apt / SatDump      |
| Frequency     | 137.x MHz (NOAA), 137.9 MHz (Meteor) |
| Cost          | ~$30–50 (SDR + DIY antenna)           |

## 2. Satellites & Frequencies

| Satellite     | Frequency    | Protocol | Resolution | Status |
|---------------|-------------|----------|------------|--------|
| NOAA-15       | 137.620 MHz | APT      | 4 km/px    | Active |
| NOAA-18       | 137.9125 MHz| APT      | 4 km/px    | Active |
| NOAA-19       | 137.100 MHz | APT      | 4 km/px    | Active |
| Meteor-M N2-3 | 137.900 MHz | LRPT     | 1 km/px    | Active |

## 3. Antenna Options

### V-Dipole (simplest)

```
     ←── 53.4 cm ──→       ←── 53.4 cm ──→
     ╲                                    ╱
      ╲          120° between            ╱
       ╲           elements             ╱
        ╲                              ╱
         ╲────── coax to SDR ────────╱
```

- Each element = λ/4 at 137 MHz = **53.4 cm**
- Angle between elements: **120°**
- Point up (zenith-facing)
- Cost: <$5 in wire

### QFH — Quadrifilar Helix (better)

- Circular polarisation matches satellite TX
- 3–6 dB gain improvement over V-dipole
- More complex to build (precise dimensions required)
- Patterns available at jcoppens.com/ant/qfh

## 4. Pass Prediction

### Using Gpredict

```bash
sudo apt install gpredict
# Add NOAA 15/18/19 and Meteor M2-3 from Celestrak TLEs
# Set your ground station coordinates
# Predict passes — target >30° max elevation
```

### Using command line (predict)

```bash
sudo apt install predict
predict -t noaa.tle -q "NOAA 19" -o pass_times.txt
```

### Web Tools

- n2yo.com — real-time tracking
- heavens-above.com — visual pass predictions

## 5. Recording & Decoding

### Step 1: Record the Pass

```bash
#!/bin/bash
# Record NOAA-19 pass (modify frequency for other satellites)
FREQ=137100000
DURATION=900  # 15 minutes max pass

timeout $DURATION rtl_fm \
    -f $FREQ \
    -M fm \
    -s 60000 \
    -r 11025 \
    -g 48 \
    -p 0 \
    -E deemp \
    - | sox -t raw -r 11025 -e signed -b 16 -c 1 - "noaa19_$(date +%Y%m%d_%H%M).wav"
```

### Step 2: Decode APT

```bash
# Using noaa-apt (recommended)
# Download from https://noaa-apt.mbernardi.com.ar/
noaa-apt recording.wav -o weather_image.png

# Options:
#   --false-colour    Apply false colour palette
#   --contrast auto   Auto-adjust contrast
#   --rotate          Auto-rotate based on satellite direction
```

### Step 3: Decode Meteor LRPT

```bash
# Using SatDump (modern all-in-one decoder)
# Install from https://github.com/SatDump/SatDump
satdump live meteor_m2_lrpt . \
    --source rtlsdr \
    --samplerate 1000000 \
    --frequency 137900000 \
    --gain 40
```

## 6. Automated Reception

```bash
# Use autowx2 for fully automated satellite reception
git clone https://github.com/filipsPL/autowx2.git
cd autowx2
# Configure satellites, SDR, and output directory
# Runs as daemon, auto-records and decodes passes
```

## 7. Expected Results

| Setup                | Image Quality         | Range              |
|---------------------|-----------------------|--------------------|
| V-dipole, no LNA    | Fair (some noise)     | 30°+ passes only   |
| V-dipole + LNA      | Good                  | 15°+ passes        |
| QFH + LNA           | Excellent             | Horizon to horizon  |
| Turnstile + LNA     | Very good             | 10°+ passes         |

## 8. Tips

- **LNA**: A filtered 137 MHz LNA (Nooelec SAWbird+ NOAA, ~$35) is highly recommended
- **FM interference**: Strong FM broadcast stations can overload the receiver; a 137 MHz bandpass filter helps
- **Timing**: Start recording 1 minute before AOS (acquisition of signal)
- **Night passes**: NOAA IR channels work at night (thermal images)
- **Best season in India**: Post-monsoon (Oct–Feb) for clear skies

---

**See also**: [NOAA APT Protocol](../06_Protocols/NOAA_APT.md) | [Antenna Basics](../01_Fundamentals/Antenna_Basics.md) | [FM Broadcast Receiver](FM_Broadcast_Receiver.md)
