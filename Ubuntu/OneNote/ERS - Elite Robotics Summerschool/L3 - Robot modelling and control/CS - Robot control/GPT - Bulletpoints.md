---
onenote-id: 0-5d61ec39bfa849eeaaab2d75f1104377!1-CE7A9D2936F1E9C3!sf45b50f3386948a2a4d5e0fae23b9025
---
**Modelling & Control of Robots (Control)** **–** **High-Level Key Topics (Exam Use)**

- Joint-space vs. operational-space control: architectures, when to use each, and error definitions.
- Robot dynamic models: joint-space B,C,g,τfB, C, g, \tau_f and operational-space Λ,Γ,η\Lambda, \Gamma, \eta; Jacobian relations.
- Second-order system basics: ζ, ωn\zeta,\ \omega_n, pole cases, and links to rise/settling time & overshoot specs.
- Inverse dynamics control (computed torque):
	- Joint space: feedback-linearization to double integrator, PD shaping of error.
	- Operational space: analogous formulation with commanded wrench.
- Motion controller tuning: mapping KP,KDK_P, K_D to ωn, ζ\omega_n,\ \zeta and time-domain specs.
- Force/compliance control taxonomy: direct vs. indirect; impedance vs. admittance; RCC concept.
- Impedance control: with/without force sensing, linearity/decoupling considerations, frame choices for time-varying references.
- Admittance control: structure, quaternion-based orientation handling, stability/disturbance sensitivity trade-offs.
- Comparative insights: when to prefer impedance vs. admittance (hardware torque control availability, model errors, stiff environments).
- Kinesthetic teaching / PbD: motivation, pros/cons, gain scheduling (velocity/force/passivity), task segmentation & parameter estimation for in-contact skills.