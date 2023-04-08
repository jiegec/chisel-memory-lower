# chisel-memory-lower

Lower chisel3 memory Blackbox to macros.

Targets:

- Xilinx
- ARM Memory IP

Usage:

```shell
python3 -m chisel_memory_lower.generate xilinx example.conf --tb
python3 -m chisel_memory_lower.generate arm example.conf --arm-config arm.yaml --tb
```

## Read under Write

Chisel allows three read under write behaviors, `Undefined`, `ReadFirst` or `WriteFirst`. For 1R1W RAM, The behavior is:

- `SyncReadMem()`: unspecified in FIRRTL, `WriteFirst` in behavior model
- `SyncReadMem(Undefined)`: unspecified in FIRRTL, `WriteFirst` in behavior model
- `SyncReadMem(ReadFirst)`: `old` in FIRRTL, `ReadFirst` in behavior model
- `SyncReadMem(WriteFirst)`: `new` in FIRRTL, `WriteFirst` in behavior model

However, XPM only supports `Undefined`(NO_CHANGE & WRITE_FIRST, generates `x`) and `ReadFirst`(READ_FIRST). ARM Memory IP only supports `Undefined`(generates `x`). Thus the behavior is not guaranteed when lowering.
