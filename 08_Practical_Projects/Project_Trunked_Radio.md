# Project: Trunked Radio Monitor

> Monitor DMR and P25 trunked radio systems using SDRTrunk.

---

## 1. Project Overview

| Item          | Details                               |
|---------------|---------------------------------------|
| Difficulty    | Intermediate                          |
| SDR required  | RTL-SDR (2 recommended for trunking)  |
| Antenna       | UHF broadband or tuned dipole         |
| Software      | SDRTrunk / DSD+ / OP25               |
| Frequency     | 400–470 MHz (UHF), 150–174 MHz (VHF) |
| Cost          | ~$50 (2× RTL-SDR)                    |

## 2. Trunked Radio Basics

Trunked systems dynamically assign channels from a pool. A **control channel**
manages assignments; **voice channels** carry conversations.

```
┌──────────────┐           ┌──────────────┐
│ Control Ch   │ ←─ SDR 1  │ SDRTrunk     │
│ (fixed freq) │           │              │
├──────────────┤           │  Follows     │
│ Voice Ch 1   │ ←─ SDR 2  │  talkgroup   │
│ Voice Ch 2   │           │  assignments │
│ Voice Ch 3   │           │              │
│ ...          │           │              │
└──────────────┘           └──────────────┘
```

## 3. Supported Protocols

| Protocol | Type     | Voice Codec | Decryptable?       |
|----------|----------|-------------|---------------------|
| DMR      | TDMA     | AMBE+2      | Unencrypted only    |
| P25 Ph1  | FDMA     | IMBE        | Unencrypted only    |
| P25 Ph2  | TDMA     | AMBE+2      | Unencrypted only    |
| NXDN     | FDMA     | AMBE+2      | Unencrypted only    |
| MPT1327  | FDMA     | Analog      | Yes (analog)        |

## 4. SDRTrunk Setup

### Install SDRTrunk

```bash
# Requires Java 17+
sudo apt install openjdk-17-jre
# Download latest release from:
# https://github.com/DSheirer/sdrtrunk/releases

# Run
java -jar sdrtrunk-linux-x86_64.jar
```

### Configure

1. **Tuner**: Add RTL-SDR(s) under Tuner tab
2. **Playlist**: Create new playlist
3. **System**: Add system (DMR, P25, etc.)
4. **Site**: Add site with control channel frequency
5. **Channel**: Add control channel
6. **Alias**: Map radio IDs to names

## 5. Finding Trunked Systems

### RadioReference.com Database

- Search by city/county/state
- Lists control channel frequencies, system type, talkgroups
- Premium subscription needed for some data

### Manual Discovery

```bash
# Scan UHF range for control channels (constant signal)
rtl_power -f 450M:470M:12.5k -g 40 -i 10 -e 120 uhf_scan.csv
python3 heatmap.py uhf_scan.csv uhf_scan.png

# Control channels appear as constant-strength signals
# (voice channels come and go)
```

## 6. Alternative Software

### DSD+ (Windows / Wine)

```
- Automatic protocol detection
- Supports DMR, P25, NXDN, dPMR, ProVoice
- GUI-based, uses virtual audio cable input
- Free version limited to 2 simultaneous decoders
```

### OP25 (Linux, P25 only)

```bash
git clone https://github.com/boatbod/op25.git
cd op25
./install.sh

# Run with control channel frequency
./rx.py --args "rtl" --frequency 460.1M -T trunk.tsv -V
```

## 7. Two-SDR Setup for Trunking

```
SDR 1 → Control channel (continuously monitored)
         │
         ├── Reads channel assignments
         │
SDR 2 → Voice channel (follows assignments)
         │
         └── Decodes AMBE/IMBE voice
```

With a single wide-bandwidth SDR (Airspy, SDRplay):
- One device can cover both control + voice channels
- If they're within the SDR's bandwidth (~6–10 MHz)

## 8. India Notes

- Indian Police in major cities use DMR (Motorola MOTOTRBO)
- Railways use UHF/VHF analog and some digital
- Many systems are migrating to encrypted channels
- Amateur DMR talkgroups (Brandmeister TG 4400) are available
- Legal to listen to unencrypted amateur radio communications

---

**See also**: [DMR Protocol](../06_Protocols/DMR.md) | [Signal Identification](../07_Spectrum_Analysis/Signal_Identification.md)
