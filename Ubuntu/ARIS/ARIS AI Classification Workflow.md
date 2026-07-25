---
created: 2026-06-09
tags:
source:
aliases:
---
[[ARIS AI Classification Workflow - Overview.excalidraw]]
![[ARIS AI Classification Workflow - Overview.excalidraw]]
![[ARIS AI Classification Workflow - Overview.excalidraw]]
## Notion table example

| Model          | Date       | Fraction | Classes                                        | Overall accuracy | F1   | ... | Dataset | Config      |
| -------------- | ---------- | -------- | ---------------------------------------------- | ---------------- | ---- | --- | ------- | ----------- |
| wood_acc=91.pt | 2026-04-05 | wood     | impregnated_wood, normal_wood                  | 0.91             | 0.90 | ... | dataset | config.yaml |
| wood_acc=92.pt | 2026-05-02 | wood     | impregnated_wood, normal_wood, wood_wool_board | 0.92             | 0.91 | ... | dataset | config.yaml |
| ...            | ...        | ...      | ...                                            | ...              | ...  | ... | ...     | ...         |

## Manifest
- [ ] Make the `manifest.py` script upload only specific files and folders instead of the whole rundir.
- [ ] 