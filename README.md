Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Shixuan Fang
* Tested on: Windows 11, i7-12700kf, RTX3080 Ti (Personal)

## Project Overview 

<p align="center">
  <img src="img/open.gif" width=500 height=500>
</p>

In this project, I implemented a physically-based grass renderer and simulator using Vulkan. This project is based on this paper, [Responsive Real-Time Grass Rendering for General 3D Scenes](https://publik.tuwien.ac.at/files/publik_261737.pdf). In this paper, each blade of grass is simulated using three control points ```v0```, ```v1```, ```v2``` and also other useful informations for tessellation.

<img src="https://user-images.githubusercontent.com/54868517/198901778-5b690384-b434-4558-a7d1-9ed424713b96.png" width=300 height=300>

Also, blades are influenced by three forces, ```Gravity```, ```Recovery```, and ```Wind```. 

| Gravity  | Gravity+Recovery  | Gravity+Recovery+wind|
| ------------- |-------------:  | :----------:|
| <img src="img/gra.gif" width=300 height=300> | <img src="img/gra+reco.gif" width=300 height=300>| <img src="img/gra+rec+wind.gif" width=300 height=300>|


In order to reduce the number of blades that needed to render, I also implemented three culling methods, which are  ```Orientation Culling```, ```View-Frustum Culling```, and ```Distance Culling```.

| Orientation Culling  | View-Frustum Culling  | Distance Culling|
| ------------- |-------------:  | :----------:|
| <img src="img/orien.gif" width=300 height=300> | <img src="img/view.gif" width=300 height=300>| <img src="img/dist_culling.gif" width=300 height=300>|

Orientation culling removes blades that have front face direction perpendicular to the view vector; View-frustum culling removes blades that out of the view-frustum using ```v0, v2, and m``` where ```m = (1/4)v0 * (1/2)v1 * (1/4)v2```; and Distance culling simply removes blades that are too far from the camera.

## Performace

<img src="https://user-images.githubusercontent.com/54868517/198901419-8af1d271-19b6-4815-8a7e-06d1dc2f5d58.png" width=600 height=300>

It's actually hard to compare these three culling methods since they remove blades of grass considering different values, and they all depend on camera position. When camera is near to the plane, then view-frustum and orientation cullings take most part, while when camera is far from the plane, distance culling removes lost of blades. Data in this chart comes from same camera position with ```blades number == 2^17```. In general, having all three culling methods activated can significantly improve performance.
