# Entities Graphics Skinned Mesh Renderer Optimization

This repository contains optimizations described in https://blog.rukhanka.com/optimizing-smr.

# How to use
1. Clone this repository into Packages folder of your project.
2. Remove original Entities.Graphics entry from manifest.json
3. Make changes to the animation-aware shader graph:

   * Create "Custom Function" shader graph node.
   * Configure the node with the following properties:
     
    ![image](https://github.com/Rukhanka/com.unity.entities.graphics/assets/144379908/8f20901b-7f74-4ca5-8cf6-b18468d99137)
   * Connect vertex data input ports with object space vertex position/normal/tangent properties.
   * Provide vertexID node with appropriate data.
   * Connect output ports with corresponding inputs of the master vertex node.
   * Create "_ComputeMeshIndex" property with "HybridPerInstance" declaration:

   ![image](https://github.com/Rukhanka/com.unity.entities.graphics/assets/144379908/0669983b-b39e-4072-9dc3-a2e61fcd5ae2)

   The final shader should look like this:

   ![image](https://github.com/Rukhanka/com.unity.entities.graphics/assets/144379908/6902cdf7-db8c-4e64-9e14-6b36aace48b6)
