# DMR — Digital Mobile Radio

> Decode trunked digital voice (DMR/MotoTRBO) using RTL-SDR and DSD+.

---

## 1. What Is DMR?

**DMR** (Digital Mobile Radio) is a TDMA-based digital voice standard defined by ETSI.
It is the most widely deployed digital trunked radio system worldwide, used by
commercial, public safety, and amateur radio operators.

```
┌───────────────┐    UHF 400-470 MHz     ┌─────────────┐
│  DMR Repeater  │ ────────────────────► │  RTL-SDR     │
│  (2-slot TDMA) │    4FSK 9.6 kbps      │  + DSD+      │
└───────────────┘                        └──────┬──────┘
                                                │
                                         ┌──────▼──────┐
                                         │  Voice/Data  │
                                         │  Output      │
                                         └─────────────┘
```

## 2. DMR Tiers

| Tier   | Mode    | Use Case                       |
|--------|---------|--------------------------------|
| Tier I | FDMA    | Unlicensed (dPMR446)           |
| Tier II| TDMA    | Licensed conventional/trunked  |
| Tier III| TDMA   | Trunked with infrastructure    |

## 3. Technical Parameters

| Parameter       | Value                           |
|-----------------|--------------------------------|
| Modulation      | 4-level FSK (4FSK)              |
| Symbol rate     | 4800 symbols/s                  |
| Bit rate        | 9600 bps (2 bits/symbol)        |
| Channel spacing | 12.5 kHz                        |
| TDMA slots      | 2 per channel                   |
| Voice codec     | AMBE+2 (proprietary)            |
| Bandwidth       | ~12.5 kHz                       |

### TDMA Frame

```
 ──────────────── 30 ms ────────────────
│  Slot 1 (15 ms)  │  Slot 2 (15 ms)  │
│  Voice/Data       │  Voice/Data       │
│  + Sync + EMB     │  + Sync + EMB     │
└───────────────────┴──────────────────┘
```

## 4. Decoding DMR

### DSD+ (recommended)

```
1. Download DSD+ from https://www.dsdplus.com/
2. Pipe audio from SDR software to DSD+ via virtual audio cable
3. DSD+ auto-detects DMR and decodes voice
```

### On Linux with DSDcc

```bash
# Build DSDcc
git clone https://github.com/f4exb/dsdcc.git
cd dsdcc && mkdir build && cd build
cmake .. && make -j$(nproc)

# Pipe from rtl_fm
rtl_fm -f 438500000 -M fm -s 48000 -g 40 - | \
    ./dsdcc -i - -f1 -o audio_out.raw
```

### With SDRTrunk (Java-based, GUI)

```bash
# Most user-friendly option for trunked DMR
# Download from https://github.com/DSheirer/sdrtrunk
java -jar sdrtrunk.jar
```

SDRTrunk can:
- Follow trunked DMR Tier III control channels
- Decode multiple simultaneous calls
- Display radio IDs and talkgroups
- Record audio per talkgroup

## 5. Encryption

| Type         | Crackable? | Notes                         |
|-------------|-----------|-------------------------------|
| None         | N/A       | ~60% of DMR is unencrypted    |
| Basic (XOR)  | Yes       | 40-bit, easily broken         |
| Enhanced     | No        | AES-256, cannot be decoded    |
| Hytera EP    | No        | Proprietary, cannot decode    |

> Many public safety systems have migrated to AES-256, rendering passive
> monitoring impossible.

## 6. Talkgroup & Radio ID Databases

| Resource              | URL                               |
|----------------------|-----------------------------------|
| RadioReference       | radioreference.com                |
| DMR-MARC             | radioid.net                       |
| Brandmeister         | brandmeister.network              |

## 7. Amateur Radio DMR

- Requires amateur radio license
- Uses **Brandmeister** and **TGIF** networks
- Hotspots (MMDVM Pi-Star) allow home DMR access
- Common amateur DMR frequencies: 438.x MHz, 445.x MHz

## 8. India-Specific Notes

- Indian Police and Railways use DMR systems in major cities
- Frequencies typically in 400–470 MHz UHF band
- Many systems are migrating to encrypted DMR Tier III
- Amateur DMR is growing via Brandmeister TG 4400 (India)

---

**See also**: [FSK Modulation](../05_Modulation/FSK.md) | [Project: Trunked Radio](../08_Practical_Projects/Project_Trunked_Radio.md)
