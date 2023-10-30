Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Yuanqi Wang
  * [LinkedIn](https://www.linkedin.com/in/yuanqi-wang-414b26106/), [GitHub](https://github.com/plasmas).
* Tested on: Windows 11, i5-11600K @ 3.91GHz 32GB, RTX 4090 24GB (Personal Desktop)

## Overview

![](/img/blade_model.jpg)
The blade of grass is represented using a quadratic Bézier curve defined by three control points and some essential attributes: 

*$v_0$*: This is the base point, anchored at the ground level. It acts as the starting point of the grass blade.

*$v_1$*: This is the control point that doesn't lie on the curve itself but influences its shape. It essentially dictates the bend or curvature of the grass blade.

*$v_2$*: This is the endpoint of the curve and represents the tip of the grass blade.

*direction:* The general leaning or orientation of the grass blade.

*height:* The height of grass blade from base to tip (from $v_0$ to $v_2$).

*width:* The thickness of the grass blade base.

*up-vector:* a directional vector indicating the vertical orientation in 3D space. This usually aligned with the normal of the plane.

## Features
### Physics Simulation

To properly simulate grass movement, a combination of recovery, gravity, and wind is used. These animations show grass movement when different forces are considered:

| No Force  | Gravity Only |
|---|---|
|![](img/no_force.png)|![](img/gravity.png)|


| Gravity + Recovery  | Gravity + Recovery + Wind |
|---|---|
|![](img/recovery.png)|![](img/wind.gif)|

It is clear that when no force is applied, all blades of grass sts the same. When gravity is the only force, all grass fell to the ground since there is no stiffness or recovery force. When Recovery force is added, blades now have a natural curve. And finally when wind force is applied, the grass will move as wind direction and strength are different at varying locations and times.

### Culling

To improve performance, different culling methods are used to discard blades that are not or less visible.
