---
onenote-id: 0-c09b6a3a1161481c82c8e216f05b972f!1-CE7A9D2936F1E9C3!s5f40bae83aec410a8c081536d57fe2a2
---
**Perceiving Depth from Images** **–** **High-Level Key Topics (Exam Use)**

- Definition and applications of **stereo vision** in robotics and perception
- **Camera models** – pinhole projection
- **Epipolar geometry** – baseline, epipole, epipolar plane, and epipolar lines
- Benefits of **epipolar constraint** – reducing correspondence search to 1D
- **Rectified stereo** – image reprojection, parallel/horizontal epipolar lines
- **Depth from stereo** – disparity definition, formula Z=fBxL−xRZ = \frac{fB}{x_L - x_R}Z=xL​−xR​fB​
- **Correspondence problem** – hard constraints (epipolar geometry) and soft constraints (similarity, uniqueness, ordering, disparity gradient)
- **Sparse vs. dense stereo correspondence** – methods, advantages, limitations
- **Local methods** – pixel/window matching, similarity/dissimilarity metrics (SAD, SSD, NCC)
- **Global methods** – dynamic programming, graph cuts, energy minimization with data and smoothness terms
- Trade-offs: accuracy vs. computational cost in correspondence algorithms
- Introduction to **monocular depth estimation** – deep learning approaches, lightweight models for embedded systems
- **Depth estimation vs. depth completion** – bridging methods, combining RGB with sparse depth data
- Recent research examples: guided decoding, refinement methods, SteeredMarigold for incomplete depth maps