#ifndef MY_CGINC
#define MY_CGINC

float3 TriColAmbient(float3 normal, float3 topCol, float3 sideCol, float3 butCol)
{
    float topMask = max(0.0, normal.g);
    float butMask = max(0.0, -normal.g);
    float sideMask = 1 - topMask - butMask;
    float3 envCol = topCol * topMask +
                    sideCol * sideMask +
                    butCol * butMask;
    return envCol;
}

#endif