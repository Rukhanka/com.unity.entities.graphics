#ifndef DOTS_DEFORMATIONS_INCLUDED
#define DOTS_DEFORMATIONS_INCLUDED

#ifdef UNITY_DOTS_INSTANCING_ENABLED

#include "../Resources/CompressedVertexDelta.hlsl"

struct DeformedVertexDelta
{
    uint4 field0;
    uint field1;
};

uniform StructuredBuffer<DeformedVertexDelta> _DeformedMeshData : register(t1);
//uniform StructuredBuffer<DeformedVertexDelta> _PreviousFrameDeformedMeshData;

void DeformInputVertex_float(float3 positionIn, float3 normalIn, float3 tangentIn, uint vertexID, float meshStartIndex, out float3 positionOut, out float3 normalOut, out float3 tangentOut)
{
    const DeformedVertexDelta vertexData = _DeformedMeshData[asuint(meshStartIndex) + vertexID];

    positionOut = positionIn + GetPosition(vertexData);
    normalOut = normalIn + GetNormal(vertexData);
    tangentOut = tangentIn + GetTangent(vertexData);
}
/*
void ApplyDeformedVertexData(uint vertexID, inout float3 positionOut, inout float3 normalOut, inout float3 tangentOut)
{
    const uint4 materialProperty = asuint(UNITY_ACCESS_HYBRID_INSTANCED_PROP(_DotsDeformationParams, float4));
    const uint currentFrameIndex = materialProperty[2];
    const uint meshStartIndex = materialProperty[currentFrameIndex];

    const DeformedVertexData vertexData = _DeformedMeshData[meshStartIndex + vertexID];

    positionOut += vertexData.Position;
    normalOut += vertexData.Normal;
    tangentOut += vertexData.Tangent;
}

void ApplyPreviousFrameDeformedVertexPosition(in uint vertexID, inout float3 positionOS)
{
    const uint4 materialProperty = asuint(UNITY_ACCESS_HYBRID_INSTANCED_PROP(_DotsDeformationParams, float4));
    const uint prevFrameIndex = materialProperty[2] ^ 1;
    const uint meshStartIndex = materialProperty[prevFrameIndex];

    // If we have a valid index, fetch the previous frame position
    // Index zero is reserved as 'uninitialized'.
    if (meshStartIndex > 0)
    {
        positionOS += _PreviousFrameDeformedMeshData[meshStartIndex + vertexID].Position;
    }
    // Else grab the current frame position
    else
    {
        const uint currentFrameIndex = materialProperty[2];
        const uint currentFrameMeshStartIndex = materialProperty[currentFrameIndex];

        positionOS += _DeformedMeshData[currentFrameMeshStartIndex + vertexID].Position;
    }
}
*/
#else
void DeformInputVertex_float(float3 positionIn, float3 normalIn, float3 tangentIn, uint vertexID, uint meshStartIndex, out float3 positionOut, out float3 normalOut, out float3 tangentOut)
{
    // Empty body for non dots variants
    positionOut = positionIn;
    normalOut = normalIn;
    tangentOut = tangentIn;
}
#endif
#endif //DOTS_DEFORMATIONS_INCLUDED
