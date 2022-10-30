Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Hanlin
   * [LinkedIn](https://www.linkedin.com/in/hanlin-sun-7162941a5/)
* Tested on: Windows 11, i7-12700H @ 2.30GHz 32GB, NVIDIA RTX 3070Ti

# Overview

![Overview](img/overview.gif)

This project involved implementing a physical grass simulation rendered in Vulkan, based on the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) by Jahrmann and Wimmer. There were three major components to this project, including rendering the grass, applying forces to control grass movement, and culling blades of grass to improve rendering frame rate when possible.

# Features
## Grass Blade Structure
A model for the grass blades was presented in the paper, which uses Bezier curves to represent the shape of a blade. Bezier curves are also used to represent grass blades for rendering in this project. The model is replicated below:

![](img/blade_model.jpg)

Each Bezier curve has three control points:
* `v0`: the position of the grass blade on the geomtry
* `v1`: a Bezier curve guide that is always "above" `v0` with respect to the grass blade's up vector
* `v2`: a physical guide for which we simulate forces on

Additional information is passed into the compute shader.
* `up`: the blade's up vector, which corresponds to the normal of the geometry that the grass blade resides on at `v0`
* Orientation: the orientation of the grass blade's face (as an angle offset from the x axis)
* Height: the height of the grass blade
* Width: the width of the grass blade's face
* Stiffness coefficient: the stiffness of our grass blade, which will affect the force computations on our blade

This data is packed into four `vec4`s, such that `v0.w` holds orientation, `v1.w` holds height, `v2.w` holds width, and `up.w` holds the stiffness coefficient.

# Modeling Forces

## Gravity
Gravity drags down the tips of the blades, making them move towards the ground. Alone, gravity would cause all the grass to fall, so a counter force is needed to balance them. This is discussed next.

![Gravity](img/gravity.png)

## Restorative
After applying gravity force, adding the restoring force pushes the blade of grass back up, allowing it to "bounce" back up when the gravity push the blade down. Depending on the stiffness of the blade, the recovery can be slow or fast.(Here only gravity applied)

![Recover](img/recover.gif)

## Wind
After applying gravity and restore force, adding simple wind force can make it swing from side to side.Wind force is based on the cosine (along x) and sin (along z) of the current time, which makes the grass blade move in a circular fashion.

![Wind](img/wind.gif)

# Optimization
Three optimizations were added to increase the frame rate. Some were more effective than others, as discussed in the performance analysis section.

## Orientation Culling
If the viewing angle is perpendicular to the thin edge of the blade of grass, it will not be rendered. To view it's effect I suggest focusing on the singlr blade and check it's visibility when camera rotate.

![Orientation Cull](img/orientationCull.gif)

## Frustum Culling
If the grass blade world position is outside of the camera view frustum, then it will be culled. It is a little bit difficult to view that effect since the render pipeline will automatically cull the object outside the window(but if not using frustum culling, they will still be rendered and will cause performance lost). So I output the FPS value, by moving the camera forward you can see that the FPS become higher(Only frustum culling was opened), which means less blades was rendered. That result proves that blades outside the camera frustum was culled and this algorithm works.

![Frustum Cull](img/FrustumCull.gif)

## Distance Culling
The distance culling operation removes blades based on the distance of the blade from the camera (projected on to the ground plane). The blade distance is discretized into a distance level bucket, in which a certain percentage of blades will be culled. The further the distance level is from the camera, the more blades will be culled.

![Distance Cull](img/DistanceCull.gif)

# Performance Analysis
All tests below were performed with the camera situated above the plane, at an angle. `r = 10.0, theta = 0.f, phi = 0.0`.


*DO NOT* leave the README to the last minute! It is a crucial part of the
project, and we will not be able to grade you without a good README.
