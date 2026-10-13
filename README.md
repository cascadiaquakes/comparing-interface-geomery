# Comparing Cascadia Subduction Interface Geometries



This repository contains code and necessary files to generate Cascadia Subduction Zone interface geometries discretized into triangular elements based on depth contours or point clouds presented by four studies: 1) McCrory et al. (2012), 2) Hayes et al. (2018), 3) Sypus & Wang (2024), and 4) Bloch et al. (2023). In addition, there is code and input files to execute forward models with uniform or a Gaussian distribution of slip applied to subduction interface geometries, inversions of the latter, block models, and analysis of the results.

Codes are compatible with MATLAB and GNU Octave.

Dependent on:
- Gmsh v4.12.2 (Geuzaine & Remacle, 2009)
- tridisl (Loveless, 2021)

---

## Contents

### applyUniformSlip
Apply uniform dip slip to an isolated subduction interface and calculate the resulting surface displacements.

### applyAndInvertGaussianSlip
Apply a Gaussian slip distribution (purely dip slip) to one interface, calculate displacements and invert those displacements onto a second interface.

## blockModels
Results from block models of Cascadia that use the block configuration and GNSS velocities from Saux et al. (2022). Models were ran using Blocks (Loveless et al., 2021).

## generateFigures
Collection of codes to generate figures from Elston et al. (*in review*).

## generateMesh
Collection of codes to  generate a continuous mesh of triangular dislocation elements (TDEs) using depth contours at 5 km intervals down to 40 km depth. Each subdirectory contains the original contour or point cloud file(s) from its respective study, GMSH files containing depth contours only (.geo),GMSH files containing the discretized interface (.msh), and a .mat file compatible with other code in this repository. Four of the six subdirectories include files for an alternative geometry (under *trenchAdded*) that uses the USGS Cascadia trench coordinates as a 3.5 km depth contour. These geometries were used to run the aforementions block models.

blochC           - Original point cloud: *c_depth.nc*

blocht           - Original point cloud: *t_depth.nc*

mccrory          - Original contours: *Drafted_slab_contours_GC-S_WGS84.txt* (hand drafted) and *Modeled_slab_contours_GC-S_WGS84.txt* (modeled)

slab2            - Original point cloud: *cas_slab2_dep_02.24.18.txt*

sypusAdjB        - Original contours: *AdjB_contours.txt*

sypusGeometry    - Original contours: *Geometry_contours.txt*

## inputs
Collection of files needed to generate figures from Elston et al. (*in review*). Some colormaps are adapted from Crameri (2018).

## forOctave
Functions necessary to run codes using GNU Octave.

# References
Bloch, W., Bostock, M. G., & Audet, P. (2023). A Cascadia Slab Model From Receiver Functions. Geochemistry, Geophysics, Geosystems, 24(10), e2023GC011088. https://doi.org/10.1029/2023GC011088

Crameri, F. (2018). Scientific colour-maps. Zenodo. http://doi.org/10.5281/zenodo.1243862

Geuzaine, C., & Remacle, J. (2009). Gmsh: A 3‐D finite element mesh generator with built‐in pre‐ and post‐processing facilities. International Journal for Numerical Methods in Engineering, 79(11), 1309–1331. https://doi.org/10.1002/nme.2579

Hayes, G. P., Moore, G. L., Portner, D. E., Hearne, M., Flamme, H., Furtney, M., & Smoczyk, G. M. (2018). Slab2, a comprehensive subduction zone geometry model. Science, 362(6410), 58–61. https://doi.org/10.1126/science.aat4723

Loveless, J. P. (2021). jploveless/tridisl: tridisl 1.0 (v1.0). Zenodo. https://doi.org/10.5281/zenodo.4622245

Loveless, J. P., Meade, B. J., & Evans, E. L. (2021). Blocks: Analysis of plate boundary deformation using geodetic data (Version 1.0) (v1.0). Zenodo. https://doi.org/10.5281/zenodo.4622191

McCrory, P. A., Blair, J. L., Waldhauser, F., & Oppenheimer, D. H. (2012). Juan de Fuca slab geometry and its relation to Wadati‐Benioff zone seismicity. Journal of Geophysical Research: Solid Earth, 117(B9), 2012JB009407. https://doi.org/10.1029/2012JB009407

Saux, J. P., Molitors Bergman, E. G., Evans, E. L., & Loveless, J. P. (2022). The Role of Slow Slip Events in the Cascadia Subduction Zone Earthquake Cycle. Journal of Geophysical Research: Solid Earth, 127(2), e2021JB022425. https://doi.org/10.1029/2021JB022425

Sypus, M., & Wang, K. (2024). Improved Cascadia Earthquake Source Models for Tsunami Hazard Assessment (No. OPEN-FILE REPORT O-24-11). DOGAMI. https://www.oregon.gov/dogami/pubs/pages/ofr/p-o-24-11.aspx

---

## Contacts

- Maintained by [@helston](https://github.com/helston)

For bugs or questions, please [open an issue](https://github.com/cascadiaquakes/comparing-interface-geomery/issues).

---

## Acknowledgments

<table>
  <tr>
    <td align="center" valign="middle">
      <img src="https://raw.githubusercontent.com/cascadiaquakes/.github/main/assets/crescent-circle.png" alt="CRESCENT Logo" width="150" />
    </td>
    <td align="center" valign="middle">
      <img src="https://raw.githubusercontent.com/cascadiaquakes/.github/main/assets/nsf-logo.png" alt="NSF Logo" width="450" />
    </td>
  </tr>
</table>

This project is supported by the National Science Foundation through the Cascadia Region Earthquake Science Center (CRESCENT), Cooperative Agreement EAR-2225286.
