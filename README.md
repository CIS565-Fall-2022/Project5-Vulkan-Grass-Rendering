Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**



* Yilin Liu
  * [LinkedIn](https://www.linkedin.com/in/yilin-liu-9538ba1a5/)
  * [Personal website](https://www.yilin.games)
* Tested on personal laptop:
  - Windows 10, Intel(R) Core(TM), i7-10750H CPU @ 2.60GHz 2.59 GHz, RTX 2070 Max-Q 8GB

Overview
=============

A Vulkan-based grass renderer was implemented in this project. I used methods discussed in K. Jahrmann and M. Wimmer's paper ["Responsive Real-Time Grass Rendering for General 3D Scenes."](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf). 

The simulation and rendering of the grass mainly includes the following parts: a vertex shader to transform Bezier control points, tessellation shaders to dynamically create the grass geometry from the Bezier curves, and a fragment shader to shade the grass blades.

Features
=============
### Blade Model

We use Bezier curve with three control points, V0 (position), V1 (up vector), and V2 (direction) to represent the blades. 

![](img/blade_model.jpg)


### Basic Grass

Specificly, we need to use tessellation shader to generate vertices. The process should be as followings:

First, we specify the detail of tessellation (inner level and outer level) in tessellation control shader

Then, the tessellation primitive generator will create a bunch of vertices according to details of tessellation. Each vertex carries a tessellation coordinate uv, which ranges from (0, 0) to (1, 1) if we use quad mode

Last, in tessellation evaluation shader, we decide the position of these new vertices based on their tessellation coordinates. For example, a vertex's position can be sampled on a height map using these coordinates position = texture(heightMap, uv)

After tessellation, these vertices are guaranteed to be assembled to the primitives we specify when creating the pipeline

![](img/grass2.gif)


Performance Analysis
============
### Distance Culling




### Frustum Culling

We cull objects which are out of camera's frustum.

```cpp
vec4 ndc = camera.proj * camera.view * vec4(v0, 1);
ndc /= (ndc.w+1.0);
if (ndc.x > 1.0 || ndc.x < -1.0 || ndc.y > 1.0 || ndc.y < -1.0 || ndc.z > 1.0 || ndc.z < -1) return;
```


### Orientation Culling

Since our grass is represented by a quad thus no thickness, a blade is hard to see if its orientation is almost parallel to the camera's. So we can cull them:

```cpp
vec3 camPos = vec3(camera.view[3][0], camera.view[3][1], camera.view[3][2]);
if (abs(dot(fwd, normalize(v0-camPos))) > 0.9) return;
```

### Dynamic Tessellation Level


If a blade is far away it doesn't need a high tesselation level. So in the tesselation control shader we can adjust the tessellation level regarding distance:

```cpp
int level;
if (z < 4.0)
    level = 16;
else if (z < 8.0)
    level = 12;
else if (z < 16.0)
    level = 8;
else if (z < 32.0)
    level = 4;
else
    level = 2;
gl_TessLevelInner[0] = level;
gl_TessLevelInner[1] = level;
gl_TessLevelOuter[0] = level;
gl_TessLevelOuter[1] = level;
gl_TessLevelOuter[2] = level;
gl_TessLevelOuter[3] = level;
```

 

| World Normal | Position |
:-------:|:-------:
|![](img/denoiser/normal.png)|![](img/denoiser/pos.png) |


Bloopers
===============

   
Reference
===============
* [Responsive Real-Time Grass Rendering for General 3D Scenes.](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf). 