uniform sampler2D uTexture;

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform highp vec3 uRippleOrigin;
uniform highp float uRippleRadius;


#define kFrequency .2

mediump vec2 modulateUVAlongAxis(in mediump vec2 uv, in highp vec2 axis, in highp float modulator);

void main()
{
    //vector from ripple origin to current fragment
    highp vec3 radial = vFragPosition - uRippleOrigin;
    //Distance from fragment to ripple orgin
    highp float dCenter = length(radial);
    //Distance from fragment to wave edge
    highp float dEdge = uRippleRadius - dCenter;
    highp float radialTextureOffset = sin(dEdge * kFrequency);
    highp vec2 modUV = modulateUVAlongAxis(vFragTextureCoords, radial.xy, radialTextureOffset);
    gl_FragColor = texture2D(uTexture, modUV);
}

mediump vec2 modulateUVAlongAxis(in mediump vec2 uv, in highp vec2 axis, in highp float modulator)
{
    highp vec2 nAxis = normalize(axis);
    return uv + nAxis * modulator;
}