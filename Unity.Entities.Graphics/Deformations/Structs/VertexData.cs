using Unity.Mathematics;

namespace Unity.Rendering
{
    /// <summary>
    /// Represent vertex data for a SharedMesh buffer
    /// </summary>
    /// <remarks>
    /// This must map between compute shaders and CPU data.
    /// </remarks>
    internal struct VertexData
    {
        //  Just make it correct size. Out struct is 3 x half3 + half as padding
        public float4 dummyField1;
        public float dummyField2;
    }
}
