uniform sampler2D uTexture;//Background texture

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform mediump float uFireProgress;
uniform sampler2D uBurnMapTexture;

void main()
{
    mediump vec4 burnTextel = texture2D(uBurnMapTexture, vFragTextureCoords);
    if (burnTextel.r < uFireProgress)
    {
        discard;
    } else
    {
        gl_FragColor = texture2D(uTexture, vFragTextureCoords);
    }
}