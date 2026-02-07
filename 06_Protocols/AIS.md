# AIS — Automatic Identification System

> Maritime vessel tracking protocol on VHF frequencies, decodable with any RTL-SDR dongle.

---

## 1. What Is AIS?

AIS is a **self-reporting transponder system** carried by ships for collision avoidance
and maritime traffic monitoring. Vessels broadcast identity, position, course, and speed
over two dedicated VHF channels.

```
┌─────────────┐    162.025 MHz (Ch 87B)    ┌──────────────┐
│  Ship AIS    │ ─────────────────────────► │  SDR Receiver │
│  Transponder │    161.975 MHz (Ch 88B)    │  + Decoder    │
└─────────────┘                             └──────┬───────┘
                                                   │
                                            ┌──────▼───────┐
                                            │  Map Display  │
                                            │  (OpenCPN)    │
                                            └──────────────┘
```

## 2. AIS Frequencies

| Channel | Frequency   | Use                  |
|---------|-------------|----------------------|
| 87B     | 161.975 MHz | AIS 1 (primary)      |
| 88B     | 162.025 MHz | AIS 2 (secondary)    |

Both channels use **GMSK modulation** at 9600 bps with HDLC framing.

## 3. Message Types

| Type | Description               | Interval        |
|------|---------------------------|-----------------|
| 1–3  | Position report (Class A) | 2–10 s          |
| 5    | Static/voyage data        | Every 6 min     |
| 18   | Position report (Class B) | Every 30 s      |
| 21   | Aids to navigation        | Every 3 min     |
| 24   | Class B static data       | Every 6 min     |

## 4. Decoding with RTL-SDR

### Using rtl_ais (dedicated decoder)

```bash
# Install
sudo apt install rtl-ais    # or build from github.com/dgiardini/rtl-ais

# Run — outputs NMEA sentences to stdout
rtl_ais -p 0
```

### Using AIS-catcher (modern, recommended)

```bash
# Build from source
git clone https://github.com/jvde-github/AIS-catcher.git
cd AIS-catcher && mkdir build && cd build
cmake .. && make -j$(nproc)

# Run with RTL-SDR
./AIS-catcher -d 0
```

### Using GNU Radio

A GMSK demodulator → HDLC deframer → NMEA parser chain works but
`AIS-catcher` is far more performant and simpler.

## 5. Feeding NMEA to a Map

| Software     | Platform     | Notes                        |
|-------------|-------------|------------------------------|
| **OpenCPN** | Linux/Win   | Full chart plotter           |
| **MarineTraffic** | Web   | Upload via sharing station   |
| **AISHub**  | Web         | Community sharing network    |

```bash
# Pipe to OpenCPN via TCP
AIS-catcher -d 0 -u 127.0.0.1 10110
# OpenCPN → Options → Connections → Network → TCP, port 10110
```

## 6. Antenna Considerations

- **Frequency**: ~162 MHz → quarter-wave whip ≈ 46 cm
- **Polarisation**: Vertical
- **Placement**: Outdoor, elevated, with line-of-sight to water
- Typical range: 20–40 nm with a good antenna setup

## 7. India-Specific Notes

- Indian ports (Mumbai, Chennai, JNPT) have heavy AIS traffic
- Coastal vessel tracking integrates with ISRO's NavIC satellite AIS
- Indian Navy Class A mandate applies to commercial vessels >300 GT

---

**See also**: [ADS-B Decoding](ADS-B_Decoding.md) | [Project: AIS Receiver](../08_Practical_Projects/Project_AIS_Receiver.md)
