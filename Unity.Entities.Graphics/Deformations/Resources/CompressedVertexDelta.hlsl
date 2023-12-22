#ifndef COMPRESSED_VERTEX_DELTA_HLSL_
#define COMPRESSED_VERTEX_DELTA_HLSL_

struct CompressedVertexDelta
{
    uint4 field0;
    uint field1;
};

CompressedVertexDelta CompressVertexDelta(float3 pos, float3 nrm, float3 tan)
{
    uint px = f32tof16(pos.x);
    uint py = f32tof16(pos.y);
    uint pz = f32tof16(pos.z);

    uint nx = f32tof16(nrm.x);
    uint ny = f32tof16(nrm.y);
    uint nz = f32tof16(nrm.z);

    uint tx = f32tof16(tan.x);
    uint ty = f32tof16(tan.y);
    uint tz = f32tof16(tan.z);

    CompressedVertexDelta v;
    v.field0.x = px << 16 | py;
    v.field0.y = pz << 16 | nx;
    v.field0.z = ny << 16 | nz;
    v.field0.w = tx << 16 | ty;
    v.field1 = tz;
    return v;
}

float3 GetPosition(CompressedVertexDelta v)
{
    float x = f16tof32(v.field0.x >> 16);
    float y = f16tof32(v.field0.x);
    float z = f16tof32(v.field0.y >> 16);
    return float3(x, y, z);
}

float3 GetNormal(CompressedVertexDelta v)
{
    float x = f16tof32(v.field0.y);
    float y = f16tof32(v.field0.z >> 16);
    float z = f16tof32(v.field0.z);
    return float3(x, y, z);
}

float3 GetTangent(CompressedVertexDelta v)
{
    float x = f16tof32(v.field0.w >> 16);
    float y = f16tof32(v.field0.w);
    float z = f16tof32(v.field1);
    return float3(x, y, z);
}

#endif
