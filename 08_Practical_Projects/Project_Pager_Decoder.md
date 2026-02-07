# Project: Pager Decoder

> Decode POCSAG pager messages on VHF/UHF frequencies using multimon-ng.

---

## 1. Project Overview

| Item          | Details                               |
|---------------|---------------------------------------|
| Difficulty    | Beginner                              |
| SDR required  | RTL-SDR (any)                         |
| Antenna       | Stock antenna or VHF/UHF whip         |
| Software      | rtl_fm + multimon-ng                  |
| Frequency     | 148–174 MHz or 450–470 MHz (varies)   |
| Cost          | ~$25 (RTL-SDR only)                   |

## 2. Finding Pager Frequencies

Pager frequencies vary by city and operator. To find active frequencies:

1. Open **SDR++** or **GQRX**
2. Tune to **148–174 MHz** (VHF paging band)
3. Set NFM mode, 12.5 kHz bandwidth
4. Look for **periodic bursts** of FSK signal
5. Listen: POCSAG has a distinctive "warbling" sound

```
Waterfall view of POCSAG:
  ████████░░░░░░░░░░████████░░░░████████
  ████████░░░░░░░░░░████████░░░░████████
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ████████████████████████████░░░░░░░░░░
     ↑ bursts of ~12.5 kHz wide FSK
```

## 3. Setup & Decode

### Install

```bash
sudo apt install rtl-sdr multimon-ng sox
```

### Decode

```bash
# Replace FREQ with your discovered frequency
rtl_fm -f 148800000 -s 22050 -g 40 - | \
    multimon-ng -t raw -a POCSAG512 -a POCSAG1200 -a POCSAG2400 -f alpha -
```

### Sample Output

```
POCSAG1200: Address: 0012345  Function: 0  Alpha: STATION 5 - RESPOND CODE 3
POCSAG1200: Address: 0067890  Function: 3  Numeric: 5551234567
POCSAG512:  Address: 1234567  Function: 0  Alpha: TEST PAGE FROM DISPATCH
```

## 4. Logging & Filtering

```bash
# Log all pages to file
rtl_fm -f 148800000 -s 22050 -g 40 - | \
    multimon-ng -t raw -a POCSAG1200 -f alpha - | \
    tee -a pager_log_$(date +%Y%m%d).txt

# Filter for specific address
... | grep "Address: 0012345"

# Timestamp each message
... | while IFS= read -r line; do echo "$(date '+%Y-%m-%d %H:%M:%S') $line"; done
```

## 5. Multi-Frequency Monitoring

```bash
# Use rtl_fm with scanner mode (requires rtl_fm fork)
# Or use SDRTrunk for multi-channel monitoring

# SDRTrunk setup:
# 1. Download from github.com/DSheirer/sdrtrunk
# 2. Add RTL-SDR as source
# 3. Add POCSAG channels
# 4. Monitor multiple frequencies simultaneously
```

## 6. Legal Notes

- **Receiving** pager signals is generally legal (passive reception)
- **Disclosing** intercepted content may violate telecommunications privacy laws
- Many pager messages contain **sensitive medical/emergency information**
- Use for RF education and signal analysis purposes only
- Check your local laws regarding interception of communications

## 7. Technical Details

| Parameter    | POCSAG512 | POCSAG1200 | POCSAG2400 |
|-------------|-----------|------------|------------|
| Baud rate   | 512       | 1200       | 2400       |
| Deviation   | ±4.5 kHz  | ±4.5 kHz   | ±4.5 kHz   |
| Encoding    | BCH(31,21)| BCH(31,21) | BCH(31,21) |
| Sensitivity | Best      | Good       | Fair       |

---

**See also**: [POCSAG Protocol](../06_Protocols/POCSAG.md) | [FSK Modulation](../05_Modulation/FSK.md) | [Signal Identification](../07_Spectrum_Analysis/Signal_Identification.md)
