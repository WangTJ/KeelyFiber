# KeelyFiber

1. The repository store some useful scripts to combine RAW lab data from Trentham Lab data to well formatted Rdata files.

2. The repository store some useful scripts to analysis the data for several specific targets. (No result will be presented in the repo.)

## Data Structure

### Lab Level

- z=1.5 or z=1
- $50\mu m$ or $100\mu m$ radius

### Patient Level

- **Patient ID (pid)**
- PHI Information
- **Survival Outcome**

### Duct/Lesion Level

- **Lesion/Duct ID (sid)**
- **Tumor/Normal (TN) categorical: T N**
- **TACS-3 present (TACS3) Y/N**
- **number of red, yellow, green pixels**

### Fiber Level

- Fiber ID: fid
- end point row: epr
- end point col: epc
- fiber abs angle: faa
- fiber weight: fw
- **total length: tl**
- end to end length: eel
- **curvature: c**
- **width: w**
- dist to nearest 2: dn2
- dist to nearest 4: dn4
- dist to nearest 8: dn8
- dist to nearest 16: dn16
- **mean nearest dist: mnd**
- std nearest dist: sdnd
- box density 32: bd32
- box density 64: bd64
- box density 128: bd128
- alignment of nearest 2: an2
- alignment of nearest 4: an4
- alignment of nearest 8: an8
- alignment of nearest 16: an16
- mean nearest alignment: mna
- std nearest alignment: sdna
- box alignment 32: ba32
- box alignment 64: ba64
- box alignment 128: ba128
- Remark: above listed in raw feature files column A to AB.
- AB1
- AB2
- Remark: AB1 and AB2 listed in raw value files column A to AB.
