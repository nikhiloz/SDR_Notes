# Signal Identification Guide

> How to identify unknown signals by their spectral signature, bandwidth, and modulation characteristics.

---

## 1. Signal Identification Workflow

```
┌──────────────┐     ┌───────────────┐     ┌────────────────┐
│ 1. Observe   │ ──► │ 2. Measure    │ ──► │ 3. Classify    │
│  waterfall + │     │  frequency    │     │  by signature  │
│  spectrum    │     │  bandwidth    │     │  + bandwidth   │
└──────────────┘     │  periodicity  │     └───────┬────────┘
                     └───────────────┘             │
                                            ┌──────▼────────┐
                                            │ 4. Confirm    │
                                            │  with decoder │
                                            │  or sigidwiki │
                                            └───────────────┘
```

## 2. Quick Identification Table

| Bandwidth  | Modulation  | Sound in NFM       | Likely Signal           |
|------------|-------------|--------------------| -----------------------|
| ~200 kHz   | WFM         | Music/voice        | FM broadcast            |
| ~16 kHz    | NFM         | Voice              | Two-way radio           |
| ~3 kHz     | AM/SSB      | Voice              | Aviation / HF amateur   |
| ~12.5 kHz  | 4FSK burst  | Digital chirping   | DMR                     |
| ~12.5 kHz  | FSK burst   | Warbling           | POCSAG pager            |
| ~2 MHz     | PPM burst   | Clicks             | ADS-B (1090 MHz)        |
| ~125 kHz   | CSS chirp   | —                  | LoRa                    |
| ~10 kHz    | OOK pulse   | Clicks             | 433 MHz remote/sensor   |
| ~34 kHz    | AM/FM       | Fax tones          | NOAA APT satellite      |
| ~20 MHz    | OFDM        | Noise              | WiFi                    |

## 3. Identification by Waterfall Signature

### Continuous Signals

```
FM Broadcast (~200 kHz)        AM Broadcast (~10 kHz)
████████████████████████       ██████████
████████████████████████       ██████████
████████████████████████       ██████████

NFM Voice (~12.5 kHz)          CW/Beacon (< 1 kHz)
    ██████                          █
    ██████                          █
    ░░░░░░  (silence)               █
    ██████                          █
```

### Burst/Pulsed Signals

```
POCSAG (bursts)                ADS-B (micro-bursts)
    ████████                       █
    ░░░░░░░░                       ░
    ░░░░░░░░                       █
    ████████                       ░
    ████████                       ░
                                   █
```

### Spread/Hopping Signals

```
LoRa Chirp                     Frequency Hopping (Bluetooth)
   ╱│  ╱│  ╱│                  █  ░  ░  █  ░
  ╱ │ ╱ │ ╱ │                  ░  █  ░  ░  █
 ╱  │╱  │╱  │                  ░  ░  █  ░  ░
```

## 4. Signal Databases

| Resource           | URL                              | Type        |
|-------------------|----------------------------------|-------------|
| **SigIDWiki**     | sigidwiki.com                    | Community   |
| **Signal ID Guide** | signalidentificationguide.com | Reference   |
| **RadioReference** | radioreference.com              | Database    |
| **HFCC**          | hfcc.org                         | HF schedule |

### Using SigIDWiki

1. Note observed **frequency**, **bandwidth**, **modulation type**
2. Visit sigidwiki.com → search by frequency or characteristics
3. Compare waterfall screenshots with your observation
4. Each entry includes audio samples for aural comparison

## 5. Measurement Techniques

### Centre Frequency

- Place cursor on signal peak
- Read frequency from SDR software display
- Account for LO offset / PPM error

### Bandwidth

```
      ▲ Power
      │     ┌────────┐
 −3dB │─ ─ ─│─ ─ ─ ─ │─ ─ ─   ← −3 dB bandwidth
      │    ╱│         │╲         (most common)
−20dB │───╱─┼─────────┼─╲───   ← −20 dB bandwidth
      │  ╱  │         │  ╲       (occupied BW)
      └──┴──┴─────────┴──┴──► f
         ←── −3dB BW ──→
         ←──── −20dB BW ────→
```

### Periodicity

- Continuous: broadcast, beacons
- Periodic bursts: pagers, telemetry, TDMA
- Irregular bursts: voice PTT, sensor triggers
- Timing reveals protocol (DMR = 30 ms frames, GSM = 4.6 ms)

## 6. Common Confusion Signals

| Looks Like       | Actually Is                      | How to Tell            |
|------------------|----------------------------------|------------------------|
| Narrowband FM    | P25 digital voice                | Digital "grinding" sound|
| Wide FM          | HD Radio (IBOC)                  | Digital sidebands      |
| Random noise     | WiFi / Bluetooth                 | Very wide, >20 MHz     |
| Steady carrier   | LO leakage / DC spike           | Always at centre freq  |
| Multiple carriers| OFDM (DVB-T, LTE)               | Even spacing           |

## 7. Signal Identification Checklist

- [ ] Note frequency (with PPM correction)
- [ ] Measure bandwidth (−3 dB and −20 dB)
- [ ] Observe timing pattern (continuous / burst / periodic)
- [ ] Listen in NFM and AM modes
- [ ] Check SigIDWiki for matching signatures
- [ ] Try appropriate decoder (rtl_433, multimon-ng, DSD+)
- [ ] Document findings

---

**See also**: [Spectrum Basics](Spectrum_Basics.md) | [Waterfall Display](Waterfall_Display.md) | [Noise Floor](Noise_Floor.md)
