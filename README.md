Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Evan S
* Tested on: Strix G15: Windows 10, Ryzen 7 4800H @ 2.9 GHz, GTX 3050 (Laptop)

## Overview

This is a grass rendering project based on [this paper on the topic](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf). Each blade of grass is rendered as its own separate object in a "geometry-agnostic acceleration structure", which allows for arbitrary 3D models of grass. 

To achieve optimal performance, the project is implemented in Vulkan.