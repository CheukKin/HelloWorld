#ifdef GL_ES
precision mediump float;
#endif
uniform sampler2D u_texture;
varying vec2 v_texCoord;
varying vec4 v_fragmentColor;
void main(void)
{
    gl_FragColor = texture2D(u_texture, v_texCoord) * v_fragmentColor;
    gl_FragColor.r *= 1.8;
    //gl_FragColor.r += 0.08 * gl_FragColor.a;
    gl_FragColor.g *= 1.1;
    //gl_FragColor.b *= 0.2;
    //gl_FragColor.g += 0.2 * gl_FragColor.a;
}