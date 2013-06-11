precision mediump float;

uniform sampler2D uTexture;//Background texture

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform mediump float uFireProgress;
uniform sampler2D uBurnMapTexture;

#define kBurnStartColor vec4(1.0, 1.0, 0.0, 1.0) //yellow
#define kBurnMiddleColor vec4(1.0, 0.0, 0.0, 1.0) //red
#define kBurnEndColor vec4(0.0, 0.0, 0.0, 1.0)//black

#define kTransitionWidth .2

#define kFlameAmount 0.2

void main()
{
    vec4 burnTextel = texture2D(uBurnMapTexture, vFragTextureCoords);
    vec4 colorTextel = texture2D(uTexture, vFragTextureCoords);
    vec4 color;
    float discardZone = uFireProgress - kTransitionWidth;
    if (burnTextel.r < discardZone)
    {
        discard;
    } else if(burnTextel.r < uFireProgress)
    {
        float blend = (burnTextel.r - discardZone)/kTransitionWidth;
        vec4 fireColor;
        if (blend < kFlameAmount) {
            fireColor = mix(kBurnStartColor, kBurnMiddleColor, blend/kFlameAmount);
        } else {
            fireColor = mix(kBurnMiddleColor, kBurnEndColor, (blend - kFlameAmount)/(1.0 - kFlameAmount));
        }
        color = mix(fireColor, colorTextel, blend);
    } else {
        color = colorTextel;
    }
    gl_FragColor = color;

}