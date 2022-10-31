Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* RHUTA JOSHI
  * [LinkedIn](https://www.linkedin.com/in/rcj9719/)
  * [Website](https://sites.google.com/view/rhuta-joshi)

* Tested on: Windows 11 Home - 21H2, AMD Ryzen 5 5600H CPU @ 3.30 GHz, NVIDIA RTX 3060 6144 MB
* GPU Compatibility: 7.5

## Introduction

In this project, I use Vulkan to implement a grass simulator and renderer. I used compute shaders to perform physics calculations on Bezier curves that represent individual grass blades in this application. Since rendering every grass blade on every frame will is fairly inefficient, I have also used compute shaders to cull grass blades that don't contribute to a given frame. The remaining blades are passed to a graphics pipeline. The vertex shader transforms Bezier control points, tessellation shaders dynamically create the grass geometry from the Bezier curves, and the fragment shader shades the grass blades.
This project is an implementation of the paper, "Responsive Real-Time Grass Rendering for General 3D Scenes" by Klemens Jahrmann and Michael Wimmer using Vulkan API.

|2<sup>20</sup> blades under wind|2<sup>12</sup> in close-up|
|---|---|
|![](img/cullingOff.gif)|![](img/grassResult.gif)|


## Vulkan pipelines

The basic Vulkan pipeline as per Khronos documentation is as follows:

![](img/vulkanPipeline.png)

However, each of these shaders can be used to our advantage to harness the processing power of GPU. For this simulation, instead of storing many vertices forming each blade of grass, we use only 3 vertices and one direction vector to represent each blade. We then use tessellation shaders to generate blade geometry and compute shaders to influence blades by natural forces.
The following diagram shows how the Vulkan pipeline has been used in this project to simulate grass:

![](img/vulkanGrassPipeline.png)

### Grass Tessellation

|Remarks|Result|
|---|---|
|Initially we start off with values of v0, v1, v2 as shown here | ![](img/grassBlade2.png)|
|Tessellation control shader sets outer and inner tessellation level to 10 for each side|![](img/quadLevels.png)|
|Dynamic tessellation - As the distance from the camera increases, we reduce the number of tessellated points.|![](img/distanceTessellation.png)|
|Resultant tessellated grass, number of blades = 100|![](img/tessellation.gif)|
|Resultant tessellated grass, number of blades = 1<<13|![](img/tessellation2.gif)|


### Compute pipeline

In this project, we simulate forces on grass blades while they are still Bezier curves. This is done in a compute shader using the compute pipeline.

1. **Binding Resources** - In order to update the state of grass blades on every frame, we create a storage buffer to maintain the grass data. We also pass information about how much time has passed in the simulation and the time since the last frame.

2. **Applying natural forces** - We calculate the resultant force on each blade of grass when affected by gravity and wind. Considering the stiffness of each grass, a recovery force is also added which ensures that the grass does not fall on ground. A wave-based noise function determines the direction of the wind.

3. **Culling Tests** - To optimize performance, we perform culling operations on our blades based on orientation, distance from camera and camera's field of view. The following table explains each effect. Refer the base paper for thresholds and calculations.

|Culling type|Result|
|---|---|
|**Orientation Culling** - If the front face direction of the blade is perpendicular to view vector, Our grass blade won't have visible width. So we remove these blades. *Number of blades - 10, orientation threshold 0.95*|![](img/orientationCulling.gif)|
|**Distance Culling** - If the blades are too far away from the camera, we may get artifacts if the visible width is negligible (smaller than size of pixel). So we remove these blades. *Number of blades 1 << 13, max distance 20, number of buckets 5*  |![](img/distanceCulling.gif)|
|**View-frustum culling** - If our blades are not within the camera view, we remove them. For the result shown here, we have added some offset(threshold) to our frustum to see the effect more clearly. *Number of blades 1<<13, offset 3*|![](img/frustumCulling.gif)|


## Performance Analysis

For performance improvement we have implemented 3 culling techniques described above. The following chart shows comparison between different culling techniques and their effect on the framerate for a certain number of blades.

![](img/cullingPerformance.png)

We see that the most effective technique is distance culling technique as it removes a large number of blades. Frustum culling may appear to be least effective but it's effect can be observed better as the camera position changes. The above observations were made with most of the grass land within the camera view as shown in the figure below:

![](img/grassBlades.png)

We can also compare the performance with increasing number of blades, with and without culling as shown below. We observe that the framerate initially starts off consistent for smaller number of grass blades, but starts decreasing suddenly after a certain threshold. We can also see that overall framerate is higher when culling is on.

![](img/grassBladesPerformance2.png)

The above graph also shows the effect of varying tesselation level on framerate. The grass blades are tessellated to varying levels of detail as a function of how far the grass blade is from the camera.
As the distance from the camera increases, we reduce the number of tessellated points. This clearly increases the framerate for any number of blades being generated.

## References

- "Responsive Real-Time Grass Rendering for General 3D Scenes" by Klemens Jahrmann and Michael Wimmer
- [Khronos Vulkan documentation](https://registry.khronos.org/vulkan/specs/1.3-extensions/man/html/)
- [Vulkan Tutorial](https://vulkan-tutorial.com/)
- [Vulkan Guide](https://vkguide.dev/)
- [Graphics Pipeline](https://www.khronos.org/opengl/wiki)
- [Vulkan game engine tutorial playlist](https://www.youtube.com/playlist?list=PL8327DO66nu9qYVKLDmdLW_84-yE4auCR)
