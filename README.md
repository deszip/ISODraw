# ISODraw

Sample project that shows usage of marching squares algorithm for building isolines.

### Pipeline
- Builds a set of points with random values that decrease monotonicaly. Option "use deviation" adds a +/- 5 deviation to a value.
- Interpolates points values to a grid of selected resolution
- Runs marchig squares on a grid and draws lines based on segments produced bby MS

### Known issues
- MS algorithm sometimes draws a circle lines around distant points
- No smoothing is applied to a resulting isolines

<img width="1448" height="1112" alt="Снимок экрана — 2026-04-21 в 07 41 16" src="https://github.com/user-attachments/assets/9d19bc10-f43d-4406-afdb-2217f6f14652" />

