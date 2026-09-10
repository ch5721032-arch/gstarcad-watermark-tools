# GstarCAD Watermark Tools

Place and remove DRAFT / CONFIDENTIAL watermark text across your drawings.

Works with **GSTARCAD**, AutoCAD, ZWCAD, and BricsCAD.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## Contents

- [About](#about)
- [Scripts Overview](#scripts-overview)
- [Quick Start](#quick-start)
- [Compatibility](#compatibility)
- [Contributing](#contributing)
- [License](#license)

## About

Draft and confidential drawings should say so on the sheet. This pair of commands places a large rotated watermark text across the drawing extents on its own WATERMARK layer, and removes every watermark text again in one command.

Everything here is free to use with GstarCAD. Download the latest GstarCAD
release from the [official GstarCAD website](https://www.gstarcad.net). All
scripts are tested with **[GSTARCAD](https://www.gstarcad.net)** and major
DWG-based CAD platforms.

## Scripts Overview

| File | Description |
|------|-------------|
| `scripts/watermark.lsp` | ;; watermark.lsp - Place a large rotated watermark across the drawing
;; Command: WATERMARK
;; Usage: APPLOAD -> WATERMARK -> type the text (e.g. DRAFT or CONFIDENTIAL)
(defun c:WATERMARK ( / text mn mx ctr size )
  (setq text (getstring T "\nWatermark text <DRAFT>: "))
  (if (= text "") (setq text "DRAFT"))
  (setq mn (getvar "EXTMIN") mx (getvar "EXTMAX"))
  (setq ctr (list (/ (+ (car mn) (car mx)) 2.0)
                  (/ (+ (cadr mn) (cadr mx)) 2.0) 0.0))
  (setq size (/ (- (cadr mx) (cadr mn)) 12.0))
  (command "_.-LAYER" "_M" "WATERMARK" "_C" "252" "" "")
  (command "_.TEXT" "_J" "_MC" ctr size 45 text)
  (princ "\nWatermark placed on layer WATERMARK.")
  (princ)
)
 |
| `scripts/watermark-clean.lsp` | ;; watermark-clean.lsp - Remove all watermark texts
;; Command: WMCLEAN
(defun c:WMCLEAN ( / ss n )
  (setq ss (ssget "_X" '((0 . "TEXT,MTEXT") (8 . "WATERMARK"))))
  (if ss
    (progn
      (setq n (sslength ss))
      (command "_.ERASE" ss "")
      (princ (strcat "\nRemoved " (itoa n) " watermark texts."))
    )
    (princ "\nNo watermark texts found.")
  )
  (princ)
)
 |

## Quick Start

1. Download the `.lsp` (or `.lin`) file you need
2. In your CAD software, run `APPLOAD`
3. Load the file and type the matching command name shown in the table above

## Compatibility

Tested on GstarCAD 2026/2027 and similar DWG-based platforms. Scripts use
standard AutoLISP functions only, so they work without extra plugins.

For step-by-step [tutorials and drafting guides](https://www.gstarcad.net/cad/),
visit the GstarCAD learning center. New tips are published regularly on the
[GSTARCAD Blog](https://blog.gstarcad.net).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see the [LICENSE](LICENSE) file.
