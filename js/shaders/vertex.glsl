uniform float time;
uniform float uProgress;
uniform vec2 uResolution;
uniform vec4 uCorners;
uniform vec2 uQuadSize;

varying vec2 vUv;
varying vec2 vSize;

void main() {
    float PI = 3.1415926;
    vUv = uv;
    float sine = sin(PI*uProgress);
    float waves = sine*0.05*sin(5.*length(uv) + 13.*uProgress);
    vec4 defaultState = modelMatrix*vec4( position, 1.0 );
    vec4 fullScreenState = vec4( position, 1.0 );
    fullScreenState.x *= uResolution.x;
    fullScreenState.y *= uResolution.y;
    fullScreenState.z *= uCorners.x;
    float cornersProgress = mix(
        mix(uCorners.x, uCorners.y, uv.x),
        mix(uCorners.z, uCorners.w, uv.x),
        uv.y
    );

    vec4 finalState = mix(defaultState,fullScreenState,cornersProgress + waves);

    vSize = mix(uQuadSize, uResolution, cornersProgress);

    gl_Position = projectionMatrix * viewMatrix * finalState;
}