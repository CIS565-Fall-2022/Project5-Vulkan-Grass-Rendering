Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Guanlin Huang
  * [LinkedIn](https://www.linkedin.com/in/guanlin-huang-4406668502/), [personal website](virulentkid.github.io/personal_web/index.html)
* Tested on: Windows 11, i7-8750H CPU @ 3.5GHz 16GB, RTX2070 8GB; Compute Capability: 7.5

## Overview
This project uses Vulkan to simulate and render grass in real-time based on the following paper: [Responsive Real-Time Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).
![](img/display.gif) 

## Background
In most naturalistic environments, grass is significant. Due of the tremendous geometrical complexity of grass fields, which results in visual artifacts, the majority of interactive applications simulate fields of grass using image-based methods.
  
In this project, each blade of grass is rendered as geometrical objects. Only the grass blades necessary for the visual look of the field of grass are rendered thanks to precise culling techniques and a flexible rendering pipeline. We also present a physical model that is assessed for every blade of grass. This makes it possible for a blade of grass to respond to its surroundings by accounting for the effects of gravity, wind, and collisions.

## Grass Representation
According to the paper, a single blade of grass may be described as a Bezier curve with the three control points v0, v1, and v2. The grass blade's base is specified in 3D by the base point (v0), the up direction is defined by the guiding curve (v1), which is always "above" v0, and the control points (v2) are where we apply various simulation forces. For more information, the paper gives a thorough usage for modifying fundamental 3D geometry forms for Bezier curve rendering.
  
![](img/grass.png) 

## Main Features
1. **Simulation**: Force simulations (grass rebound, gravity and wind) which give the grass dynamics
2. **Culling**: Grass blades that are not visually significant are removed to enhance performance.

## Simmulation
Gravity, grass recovery and wind force are simulated per blade in the simulation, which is performed in the compute shader.

**Gravity**: In order to achieve the bending effect, an artificial gravity force is provided in addition to the natural gravity force that pulls the blade downward. 
**Recovery**: The grass blades will be prevented from falling to the ground by applying the recovery force, which works like a mass-spring system.
**Wind**: The wind is generated using a random-number-generating noise function.
  
Together, the result grass looks pretty realistic.
  
Grass with no force:
  
![](img/no_force.png)
  
Grass with force simulation
  
![](img/res.gif) 
  
## Culling

### Orientation Culling
Blades with a width direction parallel to the view direction are removed by orientation culling. As the camera is pointed in the image below, we can see that some blades vanish at a particular viewing angle. (Try concentrating solely on one blade to observe the effect.)
  
![](img/ori_cull.gif) 
  
### Frustum Culling
View-frustum culling will remove the grass blades outside of the view frustum.
  
![](img/frustum_cull.gif)
  
### Distance Culling
Last but not least, the distance culling process removes blades according on how far the blade is from the camera (projected on to the ground plane). A particular percentage of the blades in the distance level bucket, which is where the blade distance is discretized, will be removed. More blades will be removed the farther the distance level is from the camera.
  
![](img/dist_cull.gif) 

## Performance Analtsis










