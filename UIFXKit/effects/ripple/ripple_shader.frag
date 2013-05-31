uniform sampler2D uTexture;

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform highp vec3 uRippleOrigin;
uniform highp float uRippleRadius;


#define kFrequency .05
#define kMaxAmplitude .02
#define kWaveFaceLength 50.0 //pix
#define kWaveTailLength 200.0

#define kTotalWaveLength (kWaveFaceLength + kWaveTailLength)
#define kAlphaStart (kTotalWaveLength + 10.0) //Distance from the wave edge (pix behind the wave)
#define kAlphaWidth 200.0
#define kAlphaEnd (kAlphaStart + kAlphaWidth)

/*
  /|\
 / | \ alpha = 1.0   alpha = 0.0
/  |  \|             |
face tail <- direction of travel 
 */
mediump vec2 modulateUVAlongAxis(in mediump vec2 uv, in highp vec2 axis, in highp float modulator);

void main()
{
    //vector from ripple origin to current fragment
    highp vec3 radial = vFragPosition - uRippleOrigin;
    //Distance from fragment to ripple orgin
    highp float dCenter = length(radial);
    //Distance from fragment to wave edge
    highp float dEdge = uRippleRadius - dCenter;
    mediump float amplitude;
    if (dCenter > uRippleRadius) { //fragment is beyond the edge
        amplitude = 0.0;//there should be no wave at all
    } else if (dEdge < kWaveFaceLength) {//The fragment is in the wave face
        amplitude = (dEdge/kWaveFaceLength);//the amplitude is 0 right at the edge of hte radius, and is highest 50 pix back from front
    } else if (dCenter > (uRippleRadius - kTotalWaveLength)){ //This is the wave from the peak all the way back to the end of the tail
        amplitude = (dCenter - uRippleRadius + kTotalWaveLength)/kWaveTailLength;//amp should be highest where face and tail meet. Should be 0 at the origin.
    } else {
        amplitude = 0.0;
    }
    
    mediump float alpha = 1.0;
    if (dEdge > kAlphaEnd) {//past where the fragments have faded to transparent (closer tor origin,
        alpha = 0.0;
    } else if (dEdge > kAlphaStart)
    {
        alpha = 1.0 - (dEdge - kAlphaStart)/kAlphaWidth;
    }
    
    highp float radialTextureOffset = sin(dEdge * kFrequency) * amplitude * kMaxAmplitude;
    highp vec2 modUV = modulateUVAlongAxis(vFragTextureCoords, radial.xy, radialTextureOffset);
    mediump vec4 color = texture2D(uTexture, modUV);
    color.a = alpha;
    gl_FragColor = color;
}

mediump vec2 modulateUVAlongAxis(in mediump vec2 uv, in highp vec2 axis, in highp float modulator)
{
    highp vec2 nAxis = normalize(axis);
    return uv + nAxis * modulator;
}
