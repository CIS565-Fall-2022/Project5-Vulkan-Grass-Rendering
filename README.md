Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Yu-Chia Shen
  * [LinkedIn](https://www.linkedin.com/in/ycshen0831/)
* Tested on: Windows 10, i5-11400F @ 4.3GHz 16GB, GTX 3060 12GB (personal)

# Overview
This project is to build a grass simulation using Vulkan. In this simulation, gravity and wind forces are applied to make it more realistic. Alos, a culling test is added to remove reduntant grass while rendering. Below video is the result of the grass simulation.

![](./img/result.gif)

# Forces Simulation
There are three types of forces added in the simulation: Gravity, Recovery, and Wind forces. Below are the demonstration without these forces.

![](./img/noF.gif)

## Gravity Froce
Gravity is a force that always point to the ground ```(y=-1)``` with the value of ```G = 9.8```. Below is the result that only contain gravity force. Also, a front gravity is applied to make the grass fall in the front facing direction.

![](./img/onlyG.gif)

As you can see, all grass are pressed to the ground. This is because there is only gravity force that push the grass to the ground. In order to solve this problem, a recovery force is added to make the grass balence.

## Recovery Force
This force represents a counter-force that brings the grass blade back into equilibrium. Recovery force will make the grass to perpendicular to the ground. Below is the video shows how the recovery force works. The force increases over time.

![](./img/Recover.gif)
Recovery force is controlled by one variable ```stiffness``` which is different for all the grass blades.

## Wind Force
Wind force is generated arbitrarily using noise functions. The image below is based on the following function:

```wind = noise(x, z) * cos(totalTime + x) * noise(totalTime) + noise(x, z)```

where ```(x, z)``` are the grass blade's coordinate.

## Total Force
The total froce is the combination of these forces. Then, the total force is added to every grass blade. The result:

![](./img/finalResult.gif)

# Culling Test
A culling test is applied to the simulation to remove reduntant grass blades. Reduntant grass blades include the blades whose directions are perpendicular to the view vector, the grass that are not appear in the frame, and the blades that are too far to the camera. By removing them, there will be a great performance increase while not affect the visual effect.

## Orientation Culling
Orientation culling removes blades that has face direction perpendicular to the view vector. Since the grass blades does not have width, they will become lines when we see them. Hence, we can remove them.

![](./img/oriCull.gif)

## View-frustum Culling 
View-frustum culling removes the blades that are outside the camera's view. A small tolerance value is added to control how far the blades are outside the view needed to be removed.

![](./img/vfCull.gif)

## Distance Culling
The final test culls the blades according to their distance toward the camera.

![](./img/disCull.gif)

# Performance Analysis 
