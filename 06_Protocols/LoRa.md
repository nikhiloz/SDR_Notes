# LoRa — Long Range IoT Protocol

> Decode LoRa chirp-spread-spectrum signals on ISM bands using SDR tools.

---

## 1. What Is LoRa?

**LoRa** (Long Range) is a proprietary chirp-spread-spectrum (CSS) modulation
developed by Semtech for low-power, long-range IoT communication. **LoRaWAN** is
the MAC-layer protocol built on top of LoRa PHY.

```
┌──────────────┐   ISM Band (868/915 MHz)  ┌──────────────┐
│  LoRa Sensor  │ ────────────────────────► │  LoRa Gateway │
│  (mW power)   │   CSS modulation          │  or SDR + Decoder
└──────────────┘   up to 15 km LOS          └──────────────┘
```

## 2. LoRa PHY Parameters

| Parameter        | Value                              |
|------------------|------------------------------------|
| Modulation       | Chirp Spread Spectrum (CSS)        |
| Frequencies      | 433, 868, 915 MHz (region-dep.)    |
| Bandwidth        | 125, 250, or 500 kHz               |
| Spreading Factor | SF7–SF12                           |
| Coding Rate      | 4/5, 4/6, 4/7, 4/8                 |
| Max data rate    | ~50 kbps (SF7, 500 kHz)            |
| Min data rate    | ~293 bps (SF12, 125 kHz)           |

### Spreading Factor Trade-offs

| SF  | Bit Rate (125k BW) | Sensitivity | Range     | Airtime |
|-----|--------------------:|-------------|-----------|---------|
| SF7 |           5468 bps  | −123 dBm    | Short     | Fast    |
| SF8 |           3125 bps  | −126 dBm    | ↓         | ↓       |
| SF9 |           1758 bps  | −129 dBm    | ↓         | ↓       |
| SF10|            977 bps  | −132 dBm    | ↓         | ↓       |
| SF11|            537 bps  | −134.5 dBm  | ↓         | ↓       |
| SF12|            293 bps  | −137 dBm    | Long      | Slow    |

## 3. Chirp Spread Spectrum

```
Frequency
    ▲
    │   ╱│  ╱│  ╱│
    │  ╱ │ ╱ │ ╱ │    ← Up-chirp (data = 0)
    │ ╱  │╱  │╱  │
    │╱   │   │   │
    └────┴───┴───┴──► Time

    ▲
    │╲   │╲  │╲  │
    │ ╲  │ ╲ │ ╲ │    ← Down-chirp (sync word)
    │  ╲ │  ╲│  ╲│
    │   ╲│   │   │
    └────┴───┴───┴──► Time
```

The **starting frequency** of each chirp symbol encodes the data. Higher SF =
more chips per symbol = better sensitivity but slower data rate.

## 4. LoRaWAN Architecture

```
┌─────────┐     LoRa RF      ┌──────────┐    IP/ETH    ┌──────────┐
│  End     │ ───────────────► │  Gateway  │ ──────────► │  Network  │
│  Device  │                  │  (8-ch)   │             │  Server   │
└─────────┘                  └──────────┘             └────┬─────┘
                                                           │
                                                    ┌──────▼─────┐
                                                    │ Application │
                                                    │ Server      │
                                                    └────────────┘
```

| Class | Behaviour                  | Latency | Battery |
|-------|----------------------------|---------|---------|
| A     | Uplink-triggered Rx window | High    | Best    |
| B     | Scheduled Rx beacons       | Medium  | Good    |
| C     | Continuous Rx              | Low     | Worst   |

## 5. Decoding LoRa with SDR

### gr-lora (GNU Radio)

```bash
# Install
git clone https://github.com/rpp0/gr-lora.git
cd gr-lora && mkdir build && cd build
cmake .. && make -j$(nproc) && sudo make install
sudo ldconfig

# Use GNU Radio Companion to build a LoRa receiver flowgraph
```

### LoRa SDR Decoder (Python)

```bash
git clone https://github.com/tapparelj/gr-lora_sdr.git
# Follow build instructions in README
# Supports decoding + encoding for research
```

### Inspectrum (visual analysis)

```bash
# Record the signal first
rtl_sdr -f 868000000 -s 1000000 -g 40 lora_capture.raw

# View in Inspectrum
inspectrum lora_capture.raw
# Chirps are clearly visible as diagonal lines in the spectrogram
```

## 6. LoRa Frequencies by Region

| Region      | Frequency Band | Channels        |
|-------------|---------------|-----------------|
| Europe      | 868 MHz       | 868.1–868.5     |
| Americas    | 915 MHz       | 902–928         |
| **India**   | **865 MHz**   | **865–867 MHz** |
| Asia-Pac    | 923 MHz       | 920–925         |
| China       | 470 MHz       | 470–510         |

### India ISM Band

India's Department of Telecommunications allocated **865–867 MHz** for
LoRa/IoT devices with:
- Max EIRP: **1 W (30 dBm)** per WPC notification
- No license required for LoRa devices
- Growing deployments: smart metering, agriculture, smart cities

## 7. Security

| Layer    | Mechanism              |
|----------|------------------------|
| Network  | AES-128-CTR (NwkSKey)  |
| App      | AES-128-CTR (AppSKey)  |
| Join     | AES-128-CMAC           |

LoRaWAN 1.1 added improved key derivation and replay protection.

---

**See also**: [ISM 433 MHz](ISM_433MHz.md) | [OFDM](../05_Modulation/OFDM.md) | [Project: 433 MHz Decoder](../08_Practical_Projects/Project_433MHz_Decoder.md)
