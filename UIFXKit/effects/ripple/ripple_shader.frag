uniform sampler2D uTexture;

varying mediump vec2 vFragTextureCoords;

void main()
{
    gl_FragColor = texture2D(uTexture, vFragTextureCoords);
}