---
created: 2026-06-09
tags:
source:
aliases:
---
Make sure background model works

```
(classification) simon@ARISAI:~/Desktop/classification[ap/audit-reference-matching]$ python3 classification/scripts/audit/review/__main__.py --flagged-csv /home/simon/Desktop/classification/outputs/background/validate_background_dataset/2026-07-21/multirun_22-04-47/8/evaluation/predictions.csv
Traceback (most recent call last):
  File "/home/simon/Desktop/classification/classification/scripts/audit/review/__main__.py", line 79, in <module>
    raise SystemExit(main())
                     ^^^^^^
  File "/home/simon/Desktop/classification/classification/scripts/audit/review/__main__.py", line 61, in main
    session = load_review_session(
              ^^^^^^^^^^^^^^^^^^^^
  File "/home/simon/Desktop/classification/classification/scripts/audit/review/session.py", line 91, in load_review_session
    raise EmptyReviewSessionError(
classification.scripts.audit.review.session.EmptyReviewSessionError: No image in predictions.csv fired any of: misclassified, low_confidence, high_loss, disagreement.
```
