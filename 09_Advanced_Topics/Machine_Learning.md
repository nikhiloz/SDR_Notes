# Machine Learning for SDR

> Applying ML/DL techniques to automatic modulation recognition, signal classification, and anomaly detection.

---

## 1. Why ML for SDR?

Traditional signal processing relies on hand-crafted algorithms for each protocol.
**Machine learning** can automatically learn signal features, enabling:

- Automatic modulation classification (AMC)
- Signal detection in low SNR
- Anomaly / interference detection
- Spectrum occupancy prediction
- Protocol identification without manual rules

```
┌──────────┐     IQ data     ┌──────────┐     class     ┌──────────┐
│  SDR      │ ──────────────►│  ML Model │ ────────────►│  "QPSK"  │
│  Receiver │   [I, Q] × N  │  (CNN/    │  confidence  │  98.5%   │
└──────────┘                 │   LSTM)   │              └──────────┘
                             └──────────┘
```

## 2. Common ML Tasks in SDR

| Task                    | Input          | Output          | Approach         |
|-------------------------|----------------|-----------------|------------------|
| Modulation recognition  | IQ samples     | Mod type        | CNN, ResNet      |
| Signal detection        | Spectrum       | Signal/noise    | YOLO, threshold  |
| Spectrum prediction     | Time-series    | Occupancy map   | LSTM, GRU        |
| Emitter identification  | RF fingerprint | Device ID       | CNN, Siamese     |
| Anomaly detection       | Spectrum       | Normal/anomaly  | Autoencoder      |

## 3. Datasets

### RadioML (DeepSig)

The standard benchmark for modulation classification:

| Dataset        | Modulations | SNR Range   | Samples      |
|----------------|------------|-------------|-------------|
| RadioML 2016.10| 11         | −20 to +18  | 220,000      |
| RadioML 2018.01| 24         | −20 to +30  | 2.5 million  |

```python
# Load RadioML 2016.10
import h5py
import numpy as np

f = h5py.File('RML2016.10a_dict.pkl', 'r')
# Data shape: (N, 2, 128) — [I, Q] channels × 128 samples
```

### Custom Dataset from SDR

```python
import numpy as np
from rtlsdr import RtlSdr

sdr = RtlSdr()
sdr.sample_rate = 2.4e6
sdr.center_freq = 433.92e6
sdr.gain = 40

# Capture IQ samples
samples = sdr.read_samples(256*1024)
# samples is complex64: I = real, Q = imag
iq_data = np.stack([samples.real, samples.imag], axis=0)
```

## 4. Model Architectures

### CNN for Modulation Classification

```python
import torch
import torch.nn as nn

class ModClassCNN(nn.Module):
    def __init__(self, num_classes=11):
        super().__init__()
        self.features = nn.Sequential(
            nn.Conv1d(2, 64, 8, padding=4),    # IQ → 64 filters
            nn.ReLU(), nn.MaxPool1d(2),
            nn.Conv1d(64, 128, 8, padding=4),
            nn.ReLU(), nn.MaxPool1d(2),
            nn.Conv1d(128, 256, 8, padding=4),
            nn.ReLU(), nn.AdaptiveAvgPool1d(1),
        )
        self.classifier = nn.Sequential(
            nn.Flatten(),
            nn.Linear(256, 128), nn.ReLU(), nn.Dropout(0.5),
            nn.Linear(128, num_classes),
        )

    def forward(self, x):
        return self.classifier(self.features(x))

# x shape: (batch, 2, 128) — 2 channels (I, Q), 128 time samples
```

### ResNet Approach (higher accuracy)

```python
# Use torchvision ResNet with modified input:
# - Change first conv layer to accept 2 channels instead of 3
# - Reshape IQ to 2D: (2, 128) → (2, 16, 8) or use spectrogram
```

### LSTM for Temporal Patterns

```python
class ModClassLSTM(nn.Module):
    def __init__(self, num_classes=11):
        super().__init__()
        self.lstm = nn.LSTM(2, 128, num_layers=2, batch_first=True)
        self.fc = nn.Linear(128, num_classes)

    def forward(self, x):
        # x: (batch, 128, 2) — time steps × IQ features
        out, _ = self.lstm(x.transpose(1, 2))
        return self.fc(out[:, -1, :])
```

## 5. Feature Engineering

Beyond raw IQ, these features improve classification:

| Feature              | Description                      |
|----------------------|----------------------------------|
| **Constellation**    | I vs Q scatter plot              |
| **Cyclostationary**  | Spectral correlation function    |
| **Higher-order stats** | Kurtosis, skewness of IQ       |
| **Spectrogram**      | Time-frequency representation    |
| **Eye diagram**      | Symbol-rate aligned overlay      |
| **Instantaneous**    | Amplitude, phase, frequency      |

## 6. Tools & Frameworks

| Tool              | Description                        |
|-------------------|------------------------------------|
| **PyTorch**       | Primary DL framework               |
| **TensorFlow**    | Alternative DL framework           |
| **SigMF**        | Standard metadata format for IQ    |
| **GNU Radio + ML**| Embedded inference blocks          |
| **TorchSig**     | RF signal processing + ML toolkit  |
| **rfml**         | RF Machine Learning library        |

## 7. Deployment on Edge

| Platform           | Framework      | Latency  |
|-------------------|----------------|----------|
| Raspberry Pi 4    | PyTorch Lite   | ~50 ms   |
| NVIDIA Jetson Nano| TensorRT       | ~5 ms    |
| FPGA (Xilinx)    | Vitis AI       | ~1 ms    |
| CPU (x86)        | ONNX Runtime   | ~10 ms   |

---

**See also**: [DSP Overview](../04_DSP_Fundamentals/DSP_Overview.md) | [Signal Identification](../07_Spectrum_Analysis/Signal_Identification.md)
