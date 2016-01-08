#ifdef GL_ES
precision mediump float;
#endif
varying vec2 v_texCoord;
uniform float u_time;

const float speed = 2.0;
const float bendFactor = 0.2;
void main()
{
	float height = 1.0 - v_texCoord.y;
	float offset = pow(height, 2.5);
	offset *= (sin(u_time * speed) * bendFactor);
	gl_FragColor = texture2D(CC_Texture0, fract(vec2(v_texCoord.x + offset, v_texCoord.y)));
}