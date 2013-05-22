uniform sampler2D uTexture;

varying highp vec3 vFragPosition;
varying mediump vec2 vFragTextureCoords;

uniform highp vec3 uRippleOrigin;
uniform highp float uRippleRadius;

void main()
{
    highp float dist = length(uRippleOrigin - vFragPosition);
    if (dist > uRippleRadius) {
        gl_FragColor = texture2D(uTexture, vFragTextureCoords);
    } else {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }

}