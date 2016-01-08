#ifdef GL_ES   
precision mediump float;   
#endif   
uniform sampler2D u_texture;   
varying vec2 v_texCoord;   
varying vec4 v_fragmentColor;   
void main(void)   
{   
    vec4 normalColor = v_fragmentColor * texture2D(u_texture, v_texCoord);  
    normalColor *= vec4(0.8, 0.8, 0.8, 1);  
    normalColor.b += normalColor.a * 0.2;  
    gl_FragColor = normalColor;  
} 