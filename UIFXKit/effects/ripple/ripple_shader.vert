//These stay the same for every vertex
uniform mat4 uModelViewMatrix;
uniform mat4 uModelViewProjectionMatrix;
uniform mat3 uNormalMatrix;

//This is the data found in each vertex
attribute vec3 aVertPosition;
attribute vec3 aVertNormal;
attribute vec2 aVertTextureCoords;

varying vec2 vFragTextureCoords;


void main()
{
    gl_Position = uModelViewProjectionMatrix * vec4(aVertPosition, 1.0);
    vFragTextureCoords = aVertTextureCoords;
}