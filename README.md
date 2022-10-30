CUDA Denoiser For CUDA Path Tracer
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 3**

**[Repo link](https://github.com/IwakuraRein/Nagi)**

- Alex Fu
  
  - [LinkedIn](https://www.linkedin.com/in/alex-fu-b47b67238/)
  - [Twitter](https://twitter.com/AlexFu8304)
  - [Personal Website](https://thecger.com/)

Tested on: Windows 10, i7-10750H @ 2.60GHz, 16GB, GTX 3060 6GB

## Features

![](./img/my_grass.gif)

## Performance Analysis

65536 blades. The resolution is 640x480.

<table>
    <tr>
        <th>Without optimization</th>
        <th>With optimization</th>
    </tr>
    <tr>
        <th><video src="https://user-images.githubusercontent.com/28486541/198902080-e6b77b6b-7390-4850-acbb-a21081033435.mp4"></video></th>
        <th><video src="https://user-images.githubusercontent.com/28486541/198902147-b79a9257-bbe3-489c-a04e-a1fcca21b790.mp4"></video></th>
    </tr>
</table>

### Frustum Culling

<video src="https://user-images.githubusercontent.com/28486541/198902121-b51ba328-61d3-4d0b-9051-5fdc18f2d990.mp4"></video>

### Density Control

<video src="https://user-images.githubusercontent.com/28486541/198902203-bcd3692b-bdf7-4992-a363-fe4aae4e5edd.mp4"></video>

### Layer Of Detail

<video src="https://user-images.githubusercontent.com/28486541/198902218-70e10287-f67f-4378-b859-8a412fbfda5b.mp4"></video>
