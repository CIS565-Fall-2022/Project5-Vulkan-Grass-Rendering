Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Dongying Liu
* [LinkedIn](https://www.linkedin.com/in/dongying-liu/), [personal website](https://vivienliu1998.wixsite.com/portfolio)
* Tested on:  Windows 11, i7-11700 @ 2.50GHz, NVIDIA GeForce RTX 3060

# Project Description

<p align="center">
<img width="600" src="/img/result.gif">
</p>

In this project, I used Vulkan to implemented a grass simulator and renderer. The grass simulation is based on this paper, [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).

# Grass Representing and Forces Simulation
## Grass Representing

<p align="center">
<img width="400" src="/img/blade_model.jpg">
</p>

In this project, grass blades is represeted as a Beizier curves with three control points as the picture shows above.

* `v0`: the position of the grass blade on the geomtry
* `v1`: a Bezier curve guide that is always "above" `v0` with respect to the grass blade's up vector (explained soon)
* `v2`: a physical guide for which we simulate forces on

Up, orientation, height, width and stiffness coefficient are stored as well to represent and simulate the grass:

* `up`: the blade's up vector, which corresponds to the normal of the geometry that the grass blade resides on at `v0`
* Orientation: the orientation of the grass blade's face
* Height: the height of the grass blade
* Width: the width of the grass blade's face
* Stiffness coefficient: the stiffness of our grass blade, which will affect the force computations on our blade

## Forces Simulation

Based on the paper, three force simulations are implemented.
| No Force | Gravity | 
| ----------- | ----------- | 
| <img width="300" src="/img/noforce.jpg"> | <img width="300" src="/img/gravity.jpg"> |

| Gravity & Recovery | Gravity & Recovery & Wind |
| ----------- | ----------- | 
| <img width="300" src="/img/recovery.jpg"> | <img width="300" src="/img/result.gif"> |

## Culling and Performance

There are many blades that don't need to be rendered due to a variety of reasons. Based on the paper, three culling were implemented.

| Orientation Culling | View-frustum Culling | Distance Culling |
| ----------- | ----------- | ----------- |
| <img width="300" src="/img/orint_culling.gif"> | <img width="300" src="/img/frustum_culling.gif"> | <img width="300" src="/img/distance_culling.gif"> |

Orientation culling culls the blades which the front face direction of the grass blades is perpendicular to the camera view director.

View-frustum culling culls the that are outside of the view-frustum.

Distance culling culls the grass blades that are far away from the camera postion. Further the distance from the camera, fewer the grass blades will be.

The following picture shows the FPS(the higher the better) with each culling be done. With the number of grass simulated raise, the FPS went down. However, we can tell that the culling function improved the performace a lot.

<p align="center">
<img width="600" src="/img/performance.png">
</p>

