precision mediump float;

uniform sampler2D uTexture;//Background texture

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform mediump float uFireProgress;
uniform sampler2D uBurnMapTexture;

#define kBurnStartColor vec4(1.0, 1.0, 0.0, 1.0) //yellow
#define kBurnMiddleColor vec4(1.0, 0.0, 0.0, 1.0) //red
#define kBurnEndColor vec4(0.0, 0.0, 0.0, 1.0)//black

#define kTransitionWidth .1

#define kFlameAmount 0.2

void main()
{
    vec4 burnTextel = texture2D(uBurnMapTexture, vFragTextureCoords);
    vec4 color;
    float discardZone = uFireProgress - kTransitionWidth;
    if (burnTextel.r < discardZone)
    {
        discard;
    } else if(burnTextel.r < uFireProgress)
    {
        float blend = (burnTextel.r - discardZone)/kTransitionWidth;
        if (blend < kFlameAmount) {
            color = mix(kBurnStartColor, kBurnMiddleColor, blend/kFlameAmount);
        } else {
            color = mix(kBurnMiddleColor, kBurnEndColor, (blend - kFlameAmount)/(1.0 - kFlameAmount));
        }
    } else {
        color = texture2D(uTexture, vFragTextureCoords);
    }
    gl_FragColor = color;

}