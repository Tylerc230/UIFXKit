uniform sampler2D uTexture;//Background texture

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform mediump float uFireProgress;
uniform sampler2D uBurnMapTexture;

#define kRedWidth 0.01
#define kBlackWidth 0.02
#define kTransitionWidth (kRedWidth + kBlackWidth)
#define kBlackDarkness -0.6
#define kRedness vec4(.7, .14, .02, 0.0)

void main()
{
    mediump vec4 burnTextel = texture2D(uBurnMapTexture, vFragTextureCoords);
    mediump vec4 color;
    if (burnTextel.r < (uFireProgress - kTransitionWidth))
    {
        discard;
    } else if (burnTextel.r < (uFireProgress - kRedWidth))
    {
        color = vec4(kBlackDarkness);
        color.a = 0.0;
    } else if( (burnTextel.r < uFireProgress))
    {
        color = kRedness;
    } else {
        color = vec4(0.0, 0.0, 0.0, 0.0);
    }
    gl_FragColor = texture2D(uTexture, vFragTextureCoords) + color;

}