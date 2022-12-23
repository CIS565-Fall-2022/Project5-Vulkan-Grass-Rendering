Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Eyad Almoamen
  * [LinkedIn](https://www.linkedin.com/in/eyadalmoamen/), [personal website](https://eyadnabeel.com)
* Tested on: Windows 11, i7-10750H CPU @ 2.60GHz 2.59 GHz 16GB, RTX 2070 Super Max-Q Design 8GB (Personal Computer)

Introduction
================
I've built a vulkan-based grass renderer based on the following paper:

https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf

In this project, triangles are used to represent blades of grass. They're then tesselated in tesselation shaders to create more of a grass look. Numerous forces are then applied to the blades to make them look physical.

Features implemented include:

* Grass based on tesselation shader
* Gravity force applied to grass
* Wind force applied to grass
* Recovery force applied to grass
* Grass blade orientation based culling
* Grass blade view frustum culling
* Grass blade distance based culling

Image Samples
================
<img src="img/WhatsApp Image 2022-12-22 at 20.15.05.jpg">
<img src="img/WhatsApp Image 2022-12-22 at 20.15.06.jpg">
<img src="img/WhatsApp Image 2022-12-22 at 20.15.052.jpg">
<img src="img/WhatsApp Image 2022-12-22 at 20.15.062.jpg">