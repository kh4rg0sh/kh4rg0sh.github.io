---
linkTitle: Yellow Dog 1
title: Yellow Dog 1 [Writeup]
type: docs
math: True
---
## Challenge Description

> "Welcome to YellowDogLLM, a service for providing LLM-generated description for images of (mostly) yellow dogs (aka Carolina dogs or American dingos). Variation 1."


## Solution
We can navigate to the website and observe that we are provided with a couple of images. We can select these images and ask the LLM Model to describe it. There's an image that has been redacted and we cannot select it. Most probably, if we could select this image and ask the LLM to describe it, we could probably get the flag.
![alt text](image-1.png)
We can inspect the page in the developer console and notice the way it checks if image could be selected. 
![alt text](image-2.png)
All images has been assigned a `Class ID` and the image with the `class="grid-item disabled"` cannot be selected. Since, all of the javascript renders on the client side, we could manually change the `Class ID` of the image and select it and ask the model to describe it.
![alt text](image-3.png)
Now we can select it and there we have our flag
![alt text](image-4.png)

## Flag
```
flag{yellowdog1-8cOucCTcV9JBU1PZbyKzPj1bW8UKJEJ2tKxh9NO9E7WoNVcG1HqS}
```
