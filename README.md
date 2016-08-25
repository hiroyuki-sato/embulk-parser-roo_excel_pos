# Roo Excel Pos parser plugin for Embulk

Read excel data file from specific cells.

## Overview

* **Plugin type**: parser
* **Guess supported**: no

## Configuration

- **columns**: Column definitions (array, required)
  - **name**: Column name (string, default: `"myvalue"`)
  - **type**: Column type (string, `string`,`timestamp`,`long`...)
  - **pos**: Cell position (string, `A1`,`Sheet_name!Z1`)
  - **format**: Timestamp format
- **default_sheet_name**: default sheet name (string, optional)

## Limitation

`Embulk preview` does not work properly if input Excel file is big.
This is because `embulk preview` read up to 32KB data only.
http://www.embulk.org/docs/release/release-0.8.10.html

## Example

```yaml
in:
  type: file
  path_prefix: example/test.xlsx
  parser:
    type: roo_excel_pos
    columns:
    - { name: cell_a, type: string, pos: A1 }
    - { name: cell_b, type: string, pos: A2 }
    - { name: cell_c, type: timestamp, pos: A6 }
    - { name: cell_d, type: long, pos: A5 }
    - { name: cell_e, type: double, pos: A5 }
    - { name: cell_f, type: timestamp, pos: A7, format: "%Y/%m/%d" }
    - { name: cell_g, type: boolean, pos: A8 }
    - { name: cell_h, type: boolean, pos: A9 }
    - { name: cell_i, type: string, pos: "Sheet2!A1" }
```

```
$ embulk gem install embulk-parser-roo_excel_pos
```

## Build

```
$ rake
```
