Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Di Lu
  * [LinkedIn](https://www.linkedin.com/in/di-lu-0503251a2/)
  * [personal website](https://www.dluisnothere.com/)
* Tested on: Windows 11, i7-12700H @ 2.30GHz 32GB, NVIDIA GeForce RTX 3050 Ti

## Introduction

This is my first Vulkan project, which simulates grass movement in an outdoor environment based on the paper: [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)

This simulation is broken into three parts: Tessellation of the grass blade into some particular shape (in my case, a quadric knife shape), physics calcuations in a compute shader for grass movements, and culling unnecessary blades for performance. For the physics element of the simulation, the following three environmental forces are considered:
- Recovery: A force based on stiffness of a blade that counteracts external forces of gravity and wind
- Gravity: Gravitational force from the ground
- Wind: Force applied by wind and air
- Result Validation (to clamp the recalculated blade shape's length and position)

![](img/diGrass2.gif)

## Core Features Implemented

### Grass Shape Tessellation

### Environmental Forces

### Culling

## Results

## Performance Analysis

## Bloopers! :)
