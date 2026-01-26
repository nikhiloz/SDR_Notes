# GNU Radio

> **GNU Radio** - The premier open-source SDR development toolkit and DSP framework.

---

## 1. Overview

### 1.1 What is GNU Radio?

GNU Radio is a free, open-source software development toolkit that provides signal processing blocks to implement software-defined radios and signal processing systems. It can be used with external RF hardware or in a simulation environment.

The following diagram shows the GNU Radio ecosystem:

```
┌────────────────────────────────────────────────────────────────────────────┐
│                         GNU RADIO ECOSYSTEM                                 │
├────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    GNU RADIO COMPANION (GRC)                         │   │
│  │                    Visual Flowgraph Editor                           │   │
│  └──────────────────────────────┬──────────────────────────────────────┘   │
│                                 │                                           │
│                                 ▼                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      GNU RADIO CORE                                  │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐       │   │
│  │  │ Sources │ │ Filters │ │ Demod   │ │ Sinks   │ │ Custom  │       │   │
│  │  │         │ │         │ │         │ │         │ │ Blocks  │       │   │
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘       │   │
│  └──────────────────────────────┬──────────────────────────────────────┘   │
│                                 │                                           │
│                                 ▼                                           │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                    HARDWARE INTERFACE                                │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐       │   │
│  │  │RTL-SDR  │ │HackRF   │ │USRP     │ │PlutoSDR │ │SoapySDR │       │   │
│  │  │(osmosdr)│ │         │ │(UHD)    │ │(IIO)    │ │         │       │   │
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘       │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                                                                             │
└────────────────────────────────────────────────────────────────────────────┘
```

### 1.2 Key Features

The following table summarizes GNU Radio's capabilities:

| Feature | Description |
|---------|-------------|
| **Visual Editor** | GNU Radio Companion for drag-and-drop flowgraph design |
| **Signal Blocks** | Hundreds of built-in DSP blocks |
| **Python/C++** | Write custom blocks in Python or C++ |
| **Hardware Support** | Works with most SDR hardware |
| **Real-time** | Process signals in real-time |
| **Simulation** | Test without hardware |
| **Cross-platform** | Linux, Windows, macOS |
| **Community** | Large user community, many examples |

---

## 2. Installation

### 2.1 Linux (Ubuntu/Debian)

```bash
# From package manager (may be older version)
sudo apt install gnuradio gnuradio-dev

# Add RTL-SDR support
sudo apt install gr-osmosdr

# Add USRP support
sudo apt install gr-uhd libuhd-dev

# Launch GNU Radio Companion
gnuradio-companion
```

### 2.2 Windows

For Windows, use **Radioconda** (recommended):

1. Download radioconda from https://github.com/ryanvolz/radioconda
2. Install to default location
3. Launch "GNU Radio Companion" from Start menu

### 2.3 Verify Installation

```bash
# Check GNU Radio version
gnuradio-config-info --version

# List available blocks
gnuradio-companion --help

# Test with a simple flowgraph
python3 -c "import gnuradio; print(gnuradio.version())"
```

---

## 3. GNU Radio Companion (GRC)

### 3.1 Interface Overview

The following diagram shows the GRC interface layout:

```
┌────────────────────────────────────────────────────────────────────────────┐
│  File  Edit  View  Run  Tools  Help                                        │
├────────────┬───────────────────────────────────────────────────────────────┤
│            │                                                                │
│  BLOCK     │              FLOWGRAPH CANVAS                                  │
│  LIBRARY   │                                                                │
│            │    ┌──────────┐      ┌──────────┐      ┌──────────┐           │
│  ▼ Sources │    │  Source  │─────▶│  Filter  │─────▶│   Sink   │           │
│  ▼ Filters │    └──────────┘      └──────────┘      └──────────┘           │
│  ▼ Demod   │                                                                │
│  ▼ Sinks   │                                                                │
│  ▼ ...     │                                                                │
│            │                                                                │
│            │                                                                │
├────────────┴───────────────────────────────────────────────────────────────┤
│  Console Output / Variables / Documentation                                 │
└────────────────────────────────────────────────────────────────────────────┘
```

### 3.2 Building a Flowgraph

The following table describes the basic workflow:

| Step | Action | Description |
|------|--------|-------------|
| 1 | Add Source | Drag source block (e.g., RTL-SDR Source) |
| 2 | Add Processing | Add filter, demodulator blocks |
| 3 | Add Sink | Add output (Audio Sink, File Sink, GUI) |
| 4 | Connect | Click and drag between block ports |
| 5 | Configure | Double-click blocks to set parameters |
| 6 | Run | Press F6 or click Play button |

---

## 4. Data Types

### 4.1 GNU Radio Port Types

The following table shows GNU Radio data types (indicated by port color):

| Type | Color | Description | Use Case |
|------|-------|-------------|----------|
| **Complex** | Blue | I/Q samples (complex float) | RF signals |
| **Float** | Orange | Real-valued samples | Audio, demodulated |
| **Integer** | Magenta | Discrete values | Digital data |
| **Short** | Light Blue | 16-bit integer | Compact storage |
| **Byte** | Purple | 8-bit unsigned | Raw bytes |
| **Message** | Gray | Async messages | Control, metadata |

### 4.2 Data Type Diagram

```
    GNU RADIO DATA FLOW TYPES
    
    ┌─────────────────┐              ┌─────────────────┐
    │   SDR Source    │──── Blue ───▶│     Filter      │
    │   (Complex)     │   Complex    │   (Complex)     │
    └─────────────────┘              └────────┬────────┘
                                              │
                                              │ Blue (Complex)
                                              ▼
                                     ┌─────────────────┐
                                     │   Demodulator   │
                                     │  (FM, AM, etc)  │
                                     └────────┬────────┘
                                              │
                                              │ Orange (Float)
                                              ▼
                                     ┌─────────────────┐
                                     │   Audio Sink    │
                                     │    (Float)      │
                                     └─────────────────┘
```

---

## 5. Essential Blocks

### 5.1 Source Blocks

The following table lists common source blocks:

| Block | Purpose | Parameters |
|-------|---------|------------|
| **RTL-SDR Source** | RTL-SDR hardware | Freq, Sample Rate, Gain |
| **UHD: USRP Source** | USRP hardware | Freq, Sample Rate, Gain |
| **Soapy Source** | SoapySDR devices | Driver, Freq, Rate |
| **File Source** | Read from file | Filename, Type |
| **Signal Source** | Generate test signals | Waveform, Freq, Amplitude |
| **Noise Source** | Generate noise | Amplitude, Type |

### 5.2 Processing Blocks

The following table lists common processing blocks:

| Block | Purpose | Use Case |
|-------|---------|----------|
| **Low Pass Filter** | Remove high frequencies | Channel selection |
| **Band Pass Filter** | Keep frequency range | Signal isolation |
| **Rational Resampler** | Change sample rate | Rate matching |
| **Multiply Const** | Adjust amplitude | Gain control |
| **AGC** | Automatic gain | Level normalization |
| **Frequency Xlating FIR** | Tune + filter | Channel selection |
| **FFT** | Frequency analysis | Spectrum display |

### 5.3 Demodulator Blocks

The following table lists demodulation blocks:

| Block | Demodulates | Output Type |
|-------|-------------|-------------|
| **WBFM Receive** | Wideband FM | Float (audio) |
| **NBFM Receive** | Narrowband FM | Float (audio) |
| **AM Demod** | AM | Float (audio) |
| **Quadrature Demod** | FM to frequency | Float |
| **PSK Demod** | BPSK/QPSK | Bytes |
| **FSK Demod** | FSK | Bytes |

### 5.4 Sink Blocks

The following table lists output (sink) blocks:

| Block | Purpose | Notes |
|-------|---------|-------|
| **Audio Sink** | Play audio | Set sample rate (48k) |
| **File Sink** | Save to file | Raw or WAV |
| **QT GUI Sink** | Spectrum display | FFT visualization |
| **QT GUI Time Sink** | Oscilloscope | Time domain |
| **QT GUI Waterfall** | Spectrogram | Time-frequency |
| **UDP Sink** | Network output | Streaming |

---

## 6. Example Flowgraphs

### 6.1 FM Radio Receiver

The following diagram shows a basic FM receiver flowgraph:

```
    FM RADIO RECEIVER FLOWGRAPH
    
    ┌──────────────┐     ┌─────────────────┐     ┌──────────────┐
    │  RTL-SDR     │────▶│ Low Pass Filter │────▶│  WBFM        │
    │  Source      │     │ (200 kHz)       │     │  Receive     │
    │              │     │                 │     │              │
    │ Freq: 100M   │     │ Decimation: 10  │     │ Audio: 48k   │
    │ Rate: 2M     │     │                 │     │              │
    └──────────────┘     └─────────────────┘     └──────┬───────┘
                                                        │
                                                        ▼
                         ┌─────────────────┐     ┌──────────────┐
                         │ QT GUI Freq     │◀────│ Audio Sink   │
                         │ Sink (display)  │     │ Rate: 48k    │
                         └─────────────────┘     └──────────────┘
```

### 6.2 Block Parameters

The following table shows parameters for the FM receiver:

| Block | Parameter | Value |
|-------|-----------|-------|
| **RTL-SDR Source** | Sample Rate | 2e6 (2 MSPS) |
| | Frequency | 100e6 (100 MHz) |
| | RF Gain | 40 |
| **Low Pass Filter** | Cutoff | 100e3 (100 kHz) |
| | Decimation | 10 |
| **WBFM Receive** | Audio Rate | 48000 |
| **Audio Sink** | Sample Rate | 48000 |

---

## 7. Variables and Parameters

### 7.1 Using Variables

Variables make flowgraphs flexible and reusable:

```
    VARIABLE USAGE
    
    ┌─────────────────┐
    │ Variable:       │
    │ samp_rate       │
    │ Value: 2000000  │
    └────────┬────────┘
             │
             │ Referenced as: samp_rate
             │
    ┌────────┴────────┐     ┌─────────────────┐
    │  RTL-SDR        │     │  Low Pass       │
    │  Sample Rate:   │     │  Sample Rate:   │
    │  samp_rate      │     │  samp_rate      │
    └─────────────────┘     └─────────────────┘
```

### 7.2 Common Variables

| Variable | Typical Value | Purpose |
|----------|---------------|---------|
| `samp_rate` | 2e6 | Sample rate |
| `center_freq` | 100e6 | Tuning frequency |
| `rf_gain` | 40 | Hardware gain |
| `audio_rate` | 48000 | Audio sample rate |
| `channel_width` | 200e3 | Channel bandwidth |

---

## 8. Python Integration

### 8.1 Embedded Python Block

Add custom Python code in a flowgraph:

```python
# Embedded Python Block example
import numpy as np
from gnuradio import gr

class my_block(gr.sync_block):
    def __init__(self):
        gr.sync_block.__init__(
            self,
            name='My Block',
            in_sig=[np.complex64],
            out_sig=[np.complex64]
        )
    
    def work(self, input_items, output_items):
        # Process samples
        output_items[0][:] = input_items[0] * 2.0
        return len(output_items[0])
```

### 8.2 Running from Python

Generated Python code can be run directly:

```bash
# Generate Python from GRC
# (GRC does this automatically on save)

# Run the generated flowgraph
python3 fm_receiver.py

# Or import as module
python3 -c "from fm_receiver import fm_receiver; tb = fm_receiver(); tb.run()"
```

---

## 9. Tips and Best Practices

### 9.1 Common Issues

The following table lists common problems and solutions:

| Issue | Cause | Solution |
|-------|-------|----------|
| **Underrun (U)** | CPU can't keep up | Reduce sample rate, simplify flowgraph |
| **Overflow (O)** | Buffer overflow | Increase buffer size |
| **No audio** | Sample rate mismatch | Match audio sink to resampled rate |
| **Choppy audio** | Underruns | Reduce decimation stages |
| **Block not found** | Missing OOT module | Install gr-osmosdr, etc. |

### 9.2 Performance Tips

| Tip | Description |
|-----|-------------|
| **Use Frequency Xlating FIR** | Combines tuning + filtering efficiently |
| **Minimize decimation stages** | Each stage adds latency |
| **Use rational resampler** | More efficient than separate up/down |
| **Disable GUI during record** | GUI consumes CPU |
| **Use throttle in simulation** | Prevents 100% CPU usage |

---

## 10. Resources

The following table lists GNU Radio learning resources:

| Resource | Description | Link |
|----------|-------------|------|
| **GNU Radio Wiki** | Official documentation | wiki.gnuradio.org |
| **Tutorials** | Official tutorials | wiki.gnuradio.org/tutorials |
| **PySDR** | Great textbook | pysdr.org |
| **GRCon** | Annual conference | gnuradio.org/grcon |
| **Mailing List** | Community support | lists.gnu.org |

---

*See also: [SDRSharp.md](SDRSharp.md) for a simpler receiver application*
