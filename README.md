Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 4**

* Haoquan Liang
  * [LinkedIn](https://www.linkedin.com/in/leohaoquanliang/)
* Tested on: Windows 10, Ryzen 7 5800X 8 Core 3.80 GHz, NVIDIA GeForce RTX 3080 Ti 12 GB

# Overview
This project is a grass simulator and renderer using Vulkan API. It is based on [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf), which allows us to render fields of grass of arbitrary shapes and spatial alignment efficiently and realistically.   
One of the main goal of this project is to also learn about the pipeline of Vulkan and how tesselation works.    
![demo](img/demo.gif)

# Table of Contents  
* [Features](#features)   
* [Performance Analysis](#performance)   
* [Reference](#reference)

# <a name="features"> Features</a>
### Force Simulation
* **Gravity Force**
![gravity](img/gravity.gif)

* **Recovery Force**
![recovery](img/stiff.png)

* **Wind Force**
![wind](img/wind.gif)

### Blade Culling
* **Orientation Culling**
![orientation](img/orientation.gif)
* **View-Frustum Culling**
![viewfrustum](img/viewfrustum.gif)
* **Distance Culling** 
![distance](img/distance.gif)

### Extra Feature - Dynamic Levels of Details
![lod](img/LOD.png)

