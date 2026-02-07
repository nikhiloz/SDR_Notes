# GNU Radio Out-of-Tree Modules

> Building custom GNU Radio blocks (OOT modules) for signal processing that doesn't exist in the standard library.

---

## 1. What Are OOT Modules?

**Out-of-Tree (OOT) modules** are custom GNU Radio components built outside the
main source tree. They let you add new signal processing blocks, decoders,
and protocol implementations to GNU Radio.

```
┌────────────────────────────────────────────┐
│  GNU Radio                                 │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐ │
│  │ Standard  │  │ Standard  │  │ OOT      │ │
│  │ Block     │─►│ Block     │─►│ Module   │ │
│  │ (FFT)     │  │ (Filter)  │  │ (custom) │ │
│  └──────────┘  └──────────┘  └──────────┘ │
└────────────────────────────────────────────┘
```

## 2. Creating a New OOT Module

### Use gr_modtool

```bash
# Create new module "mymod"
gr_modtool newmod mymod
cd gr-mymod

# Add a new block (Python)
gr_modtool add my_block_name
# Choose: Python, Sync Block, float input/output
```

### Module Structure

```
gr-mymod/
├── CMakeLists.txt
├── python/
│   └── mymod/
│       ├── __init__.py
│       └── my_block_name.py    ← Python block implementation
├── grc/
│   └── mymod_my_block_name.block.yml  ← GRC block definition
├── lib/
│   ├── my_block_name_impl.cc   ← C++ block implementation
│   └── my_block_name_impl.h
├── include/
│   └── mymod/
│       └── my_block_name.h     ← Public C++ header
└── examples/
    └── example_flowgraph.grc   ← Example usage
```

## 3. Python Block Example

### Simple Power Meter

```python
# python/mymod/power_meter.py
import numpy as np
from gnuradio import gr

class power_meter(gr.sync_block):
    """Compute average power of input signal in dBFS"""

    def __init__(self, avg_len=1024):
        gr.sync_block.__init__(
            self,
            name="Power Meter",
            in_sig=[np.complex64],
            out_sig=[np.float32]
        )
        self.avg_len = avg_len
        self.buffer = np.zeros(avg_len, dtype=np.float32)
        self.idx = 0

    def work(self, input_items, output_items):
        inp = input_items[0]
        out = output_items[0]

        for i in range(len(inp)):
            power = np.abs(inp[i])**2
            self.buffer[self.idx % self.avg_len] = power
            self.idx += 1
            avg_power = np.mean(self.buffer[:min(self.idx, self.avg_len)])
            out[i] = 10.0 * np.log10(avg_power + 1e-20)

        return len(out)
```

### GRC Block Definition

```yaml
# grc/mymod_power_meter.block.yml
id: mymod_power_meter
label: Power Meter
category: '[mymod]'
parameters:
- id: avg_len
  label: Averaging Length
  dtype: int
  default: 1024
inputs:
- domain: stream
  dtype: complex
outputs:
- domain: stream
  dtype: float
templates:
  imports: from mymod import power_meter
  make: mymod.power_meter(${avg_len})
```

## 4. C++ Block Example

For performance-critical blocks, use C++:

```cpp
// lib/fast_power_impl.cc
#include "fast_power_impl.h"
#include <volk/volk.h>

namespace gr {
namespace mymod {

int fast_power_impl::work(int noutput_items,
    gr_vector_const_void_star &input_items,
    gr_vector_void_star &output_items)
{
    const gr_complex *in = (const gr_complex *)input_items[0];
    float *out = (float *)output_items[0];

    // Use VOLK for SIMD-accelerated magnitude squared
    volk_32fc_magnitude_squared_32f(out, in, noutput_items);

    return noutput_items;
}

} // namespace mymod
} // namespace gr
```

## 5. Build & Install

```bash
cd gr-mymod
mkdir build && cd build
cmake ..
make -j$(nproc)
sudo make install
sudo ldconfig

# For Python-only modules, you can also:
cd gr-mymod
pip install -e .
```

## 6. Popular OOT Modules

| Module              | Purpose                          |
|---------------------|----------------------------------|
| **gr-osmosdr**      | SDR hardware source/sink blocks  |
| **gr-satellites**   | Amateur satellite decoders       |
| **gr-lora**         | LoRa PHY decoder                 |
| **gr-adsb**         | ADS-B decoder                    |
| **gr-dab**          | DAB/DAB+ digital radio           |
| **gr-iridium**      | Iridium satellite decoder        |
| **gr-inspector**    | Signal analysis toolbox          |
| **gr-rds**          | FM RDS decoder                   |

## 7. Testing

```python
# Unit test for your block
from gnuradio import gr, gr_unittest
from mymod import power_meter
import numpy as np

class test_power_meter(gr_unittest.TestCase):
    def test_known_power(self):
        # 0 dBFS signal (magnitude 1.0)
        src_data = np.ones(1024, dtype=np.complex64)
        src = gr.vector_source_c(src_data)
        blk = power_meter(avg_len=1024)
        snk = gr.vector_sink_f()

        tb = gr.top_block()
        tb.connect(src, blk, snk)
        tb.run()

        result = snk.data()
        self.assertAlmostEqual(result[-1], 0.0, places=1)

if __name__ == '__main__':
    gr_unittest.run(test_power_meter)
```

## 8. Tips

- Start with **Python blocks** for rapid prototyping
- Port to **C++ with VOLK** when performance matters
- Use `gr_modtool` — don't create files manually
- Test with `ctest` or `python -m pytest`
- Publish on CGRAN (Comprehensive GNU Radio Archive Network)

---

**See also**: [GNU Radio](../03_Software/GNU_Radio.md) | [DSP Overview](../04_DSP_Fundamentals/DSP_Overview.md) | [Filters](../04_DSP_Fundamentals/Filters.md)
