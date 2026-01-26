# RTL-SDR

> **RTL-SDR** - The most popular entry-level SDR, based on the RTL2832U DVB-T tuner chip.

---

## 1. Overview

### 1.1 What is RTL-SDR?

The RTL-SDR is a USB dongle originally designed for receiving DVB-T television, repurposed as a wideband SDR receiver. It's the most affordable way to get into software defined radio.

The following diagram shows the RTL-SDR architecture:

```
┌────────────────────────────────────────────────────────────────────────────┐
│                         RTL-SDR BLOCK DIAGRAM                               │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────┐   ┌──────────┐   ┌────────────┐   ┌──────────┐   ┌─────────┐  │
│  │ Antenna │──▶│  R820T2  │──▶│  RTL2832U  │──▶│   USB    │──▶│Computer │  │
│  │  Input  │   │  Tuner   │   │   ADC/USB  │   │Interface │   │         │  │
│  └─────────┘   └────┬─────┘   └──────┬─────┘   └──────────┘   └─────────┘  │
│                     │                │                                      │
│                     │                │                                      │
│              ┌──────┴──────┐   ┌─────┴─────┐                               │
│              │ Tuner Range │   │ 8-bit ADC │                               │
│              │ 24-1766 MHz │   │ 28.8 MSPS │                               │
│              └─────────────┘   │ (2.4 MSPS │                               │
│                                │  usable)  │                               │
│                                └───────────┘                               │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Versions

The following table compares RTL-SDR versions:

| Version | Features | Price |
|---------|----------|-------|
| **Generic** | Basic RTL2832U + R820T/R820T2 | ~$10-15 |
| **RTL-SDR v3** | TCXO, bias-T, direct sampling, aluminum case | ~$30 |
| **RTL-SDR v4** | New tuner (R828D), improved HF, better filtering | ~$40 |

---

## 2. Specifications

### 2.1 RTL-SDR v3 Specifications

The following table lists RTL-SDR v3 specifications:

| Parameter | Value | Notes |
|-----------|-------|-------|
| **Tuner Chip** | R820T2 | Determines frequency range |
| **ADC Chip** | RTL2832U | 8-bit |
| **Frequency Range** | 24 - 1766 MHz | Tuner mode |
| **HF Range (Direct)** | 500 kHz - 24 MHz | Direct sampling mode |
| **Sample Rate** | Up to 2.4 MSPS | Higher rates may drop samples |
| **ADC Resolution** | 8-bit | ~48 dB dynamic range |
| **Frequency Stability** | 1 PPM | TCXO equipped |
| **Connector** | SMA Female | 50Ω |
| **Bias-T** | 4.5V, ~180mA | Software enabled |
| **Interface** | USB 2.0 | ~3 MB/s data rate |
| **Power** | USB powered | ~300 mA |

### 2.2 RTL-SDR v4 Improvements

The following table shows v4 improvements over v3:

| Feature | v3 | v4 |
|---------|----|----|
| **Tuner** | R820T2 | R828D |
| **HF Performance** | Direct sampling (Q-branch) | Improved upconverter-free HF |
| **LNA** | None | Built-in LNA |
| **Filtering** | Basic | Improved filters |
| **Notch Filter** | None | Broadcast FM notch |
| **Noise Figure** | ~3.5 dB | ~2.5 dB |

---

## 3. Frequency Coverage

### 3.1 Frequency Ranges

The following diagram shows RTL-SDR frequency coverage:

```
    RTL-SDR FREQUENCY COVERAGE
    
    ├─────────────────────────────────────────────────────────────────────▶ MHz
    0         24        100       500       1000      1500      1766
    │          │          │         │          │         │         │
    │◀── HF ──▶│◀──────── Tuner Mode (R820T2/R828D) ─────────────▶│
    │ Direct   │          │         │          │         │         │
    │ Sampling │          │         │          │         │         │
    │(v3/v4)   │          │         │          │         │         │
    │          │          │         │          │         │         │
    └──────────┴──────────┴─────────┴──────────┴─────────┴─────────┘
    
    Common Signals:
    ├─AM─┤    ├FM─┤  ├Air┤  ├──AIS──┤  ├───ADS-B───┤  ├GPS┤
    530k-    88-108 118-137  162      1090 MHz       1575
    1.7MHz   MHz    MHz      MHz                     MHz
```

### 3.2 Band Coverage

The following table shows what signals RTL-SDR can receive:

| Band | Frequency | Signals | RTL-SDR Mode |
|------|-----------|---------|--------------|
| **HF** | 0.5-30 MHz | Shortwave, amateur, marine | Direct sampling |
| **VHF Low** | 30-88 MHz | Public safety, NOAA satellites | Tuner |
| **FM Broadcast** | 88-108 MHz | Commercial FM radio | Tuner |
| **Airband** | 118-137 MHz | Aircraft comms | Tuner |
| **VHF High** | 137-174 MHz | NOAA APT, 2m amateur, marine | Tuner |
| **UHF** | 400-512 MHz | 70cm amateur, FRS, GMRS | Tuner |
| **ISM 433** | 433 MHz | Remotes, sensors, LoRa | Tuner |
| **Cellular** | 700-900 MHz | Downlink (encrypted) | Tuner |
| **ADS-B** | 1090 MHz | Aircraft tracking | Tuner |
| **GPS L1** | 1575 MHz | GPS signals | Tuner |

---

## 4. Setup Guide

### 4.1 Windows Setup

1. **Download SDR#** from airspy.com/download
2. **Run install-rtlsdr.bat** to get drivers
3. **Run zadig.exe** to install WinUSB driver
4. **Start SDR#** and select RTL-SDR (USB)

### 4.2 Linux Setup

```bash
# Install librtlsdr
sudo apt install rtl-sdr librtlsdr-dev

# Add udev rules (avoid running as root)
sudo cp rtl-sdr.rules /etc/udev/rules.d/

# Test device
rtl_test -t

# Install GQRX
sudo apt install gqrx-sdr
```

### 4.3 Common Software

The following table lists software compatible with RTL-SDR:

| Software | Platform | Purpose |
|----------|----------|---------|
| **SDR#** | Windows | General receiver |
| **GQRX** | Linux/Mac | General receiver |
| **CubicSDR** | All | Cross-platform |
| **GNU Radio** | All | DSP framework |
| **rtl_433** | All | ISM band decoder |
| **dump1090** | All | ADS-B decoder |
| **rtl_fm** | All | Command-line FM |

---

## 5. Direct Sampling Mode

### 5.1 How It Works

For HF reception (below 24 MHz), RTL-SDR can bypass the tuner and sample RF directly:

```
    DIRECT SAMPLING MODE
    
    Normal Mode (VHF/UHF):
    Antenna ──▶ R820T2 Tuner ──▶ RTL2832U ──▶ USB
                    │
              Frequency set by tuner
              
    Direct Sampling Mode (HF):
    Antenna ──────────────────▶ RTL2832U ──▶ USB
                                    │
                         Samples RF directly
                         ADC clock = 28.8 MHz
                         Usable: ~0.5-14 MHz (Q-branch)
                                 ~0.5-28 MHz (with aliases)
```

### 5.2 Enabling Direct Sampling

| Software | Setting |
|----------|---------|
| **SDR#** | RTL-SDR Controller → Sampling Mode → Q-branch |
| **GQRX** | Device string: `rtl=0,direct_samp=2` |
| **GNU Radio** | Direct sampling = Q-branch (2) |

---

## 6. Bias-T

### 6.1 What is Bias-T?

The Bias-T provides DC power through the antenna connector to power external devices:

```
    BIAS-T OPERATION
    
    ┌─────────────────────────────────────────────────────┐
    │                    RTL-SDR                          │
    │                                                     │
    │   RF Input ─────┬───────────▶ Tuner                │
    │                 │                                   │
    │                 │                                   │
    │            ┌────┴────┐                              │
    │            │ Bias-T  │◀──── 4.5V DC (when enabled) │
    │            └─────────┘                              │
    │                                                     │
    └─────────────────────────────────────────────────────┘
                  │
                  │ SMA Cable
                  ▼
    ┌─────────────────────────────────────────────────────┐
    │  External Device (powered by Bias-T)                │
    │  - LNA (Low Noise Amplifier)                        │
    │  - Active Antenna                                   │
    │  - Filtered Preamp                                  │
    └─────────────────────────────────────────────────────┘
```

### 6.2 Bias-T Specifications

| Parameter | Value |
|-----------|-------|
| Voltage | 4.5V DC |
| Current | Up to 180 mA |
| Control | Software enabled |

### 6.3 Enabling Bias-T

| Software | Method |
|----------|--------|
| **SDR#** | Checkbox in RTL-SDR Controller |
| **rtl_biast** | Command: `rtl_biast -b 1` |
| **GQRX** | Device string: `rtl=0,bias=1` |

> ⚠️ **Warning:** Only enable Bias-T when connected to a device that requires it. Connecting to a passive antenna with Bias-T enabled won't damage the RTL-SDR but wastes power.

---

## 7. Performance Optimization

### 7.1 Gain Settings

The following table shows RTL-SDR gain options:

| Setting | Use Case |
|---------|----------|
| **AGC (Auto)** | General use, varying signal levels |
| **Manual Gain** | Weak signals, avoiding overload |
| **Max Gain** | Very weak signals (adds noise) |
| **Low Gain** | Strong local signals |

### 7.2 Sample Rate Selection

| Sample Rate | Usable BW | CPU Load | Stability |
|-------------|-----------|----------|-----------|
| 0.25 MSPS | ~200 kHz | Very Low | Excellent |
| 1.0 MSPS | ~800 kHz | Low | Excellent |
| 2.0 MSPS | ~1.6 MHz | Medium | Good |
| 2.4 MSPS | ~2 MHz | Medium | Fair |
| 2.88 MSPS | ~2.3 MHz | High | May drop samples |

### 7.3 Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| **Sample drops** | CPU/USB can't keep up | Lower sample rate |
| **DC spike** | LO leakage | Enable DC offset correction |
| **Strong signal overload** | Too much gain | Reduce gain, add attenuator |
| **No signal** | Wrong freq, antenna | Check antenna, try FM broadcast |
| **Frequency drift** | Temperature changes | Wait for warmup, use TCXO version |

---

## 8. Antennas

### 8.1 Included Antenna

Most RTL-SDR kits include a simple dipole antenna:

| Antenna | Frequency Range | Notes |
|---------|-----------------|-------|
| **Telescopic Dipole** | ~70-900 MHz | Adjust length for frequency |
| **Magnetic Whip** | VHF/UHF | Mount on metal surface |

### 8.2 Recommended Upgrades

The following table suggests antennas for specific applications:

| Application | Antenna Type | Example |
|-------------|--------------|---------|
| **General VHF/UHF** | Discone | Diamond D130J |
| **ADS-B (1090 MHz)** | Collinear | FlightAware antenna |
| **Weather Satellite** | V-Dipole, QFH | Homebrew V-dipole |
| **HF** | Long wire, Loop | Random wire + upconverter |
| **FM DX** | Directional Yagi | FM Yagi |

---

## 9. Applications

### 9.1 Popular RTL-SDR Projects

The following table lists common RTL-SDR applications:

| Application | Software | Frequency |
|-------------|----------|-----------|
| **FM Radio** | SDR#, GQRX | 88-108 MHz |
| **ADS-B Aircraft** | dump1090, tar1090 | 1090 MHz |
| **Weather Satellites** | WXtoImg, satdump | 137 MHz |
| **Trunked Radio** | OP25, SDRTrunk | Various |
| **Pager Decoding** | PDW, multimon-ng | 152, 454 MHz |
| **ISM Sensors** | rtl_433 | 433/915 MHz |
| **AIS Ships** | AISdeco, OpenCPN | 162 MHz |
| **Ham Radio** | Various | Various |

---

## 10. Summary

The following table summarizes RTL-SDR key points:

| Aspect | Summary |
|--------|---------|
| **Best For** | Learning, experimentation, budget projects |
| **Price** | $10-40 depending on version |
| **Frequency** | 24-1766 MHz (HF with direct sampling) |
| **Bandwidth** | ~2 MHz usable |
| **Limitations** | 8-bit, RX only, no full duplex |
| **Upgrade Path** | Airspy, SDRPlay, HackRF |

---

*See also: [Hardware_Comparison.md](Hardware_Comparison.md) for comparison with other SDRs*
