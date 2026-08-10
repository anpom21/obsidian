---
onenote-id: 0-4b9bcc9b12cd41eb95e9f1d916bd58fa!1-CE7A9D2936F1E9C3!s38dce5096f464f2884fba5419c9b88ec
---
**Planning of Collision-Free and Feasible Robot Motions** **–** **High-Level Key Topics (Exam Use)**

- **Cartesian space vs. configuration space** – definitions, parametrizations, and mapping between them
- **Forward and inverse kinematics** – role in planning and task execution, Pieper’s theorem for IK solutions
- **Why plan in configuration space** – benefits for collision avoidance, speed, and avoiding singularities
- **Linear interpolation with parabolic blends** – cycle time estimation, velocity/acceleration constraints, blend time limits
- **Point-to-point motion planning problem** – concept, allowed vs. colliding configurations
- **Distance metrics** – role in planning efficiency, weighted norms, resolution property
- **Planning approaches** – grid-based vs. random sampling, pros/cons
- **Sampling-based planning algorithms** – general pipeline, completeness in theory vs. practice
- **Single query vs. multiple query problems** – when to bias search vs. explore roadmap
- **Lazy Probabilistic Roadmap (Lazy PRM)** – concept, vertex/edge checking order, enhancement steps
- **Collision checking and distance computation** – bounding volumes, tree structures, depth-first search for efficiency
- **A*** algorithm – finding shortest paths in graphs, role of heuristic lower bounds, triangle inequality assumption
- **Key planning considerations** – trade-offs between computation time, path length, and collision safety