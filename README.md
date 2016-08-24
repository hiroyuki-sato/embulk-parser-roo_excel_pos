# Roo Excel Pos parser plugin for Embulk

Read excel data file form specific position.

## Overview

* **Plugin type**: parser
* **Guess supported**: no

## Configuration

- **columns**: description (array, required)
  - **name**: Column name (string, default: `"myvalue"`)
  - **type**: Column type (string, `string`,`timestamp`,`long`...)
  - **pos**: Sheet position (string, `A1`)
  - **format**: Timestamp format

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
```

```
$ embulk gem install embulk-parser-roo_excel_pos
```

## Build

```
$ rake
```
