// gpu shader

struct Globals {
    projection: mat4x4<f32>,
    time: f32,
    scroll_speed: f32,
    _padding: vec2<f32>,
};

struct VertexInput {
    @location(0) position: vec2<f32>,
    @location(1) tex_coords: vec2<f32>,
};

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) tex_coords: vec2<f32>,
    @location(1) color_tint: vec4<f32>,
};

struct InstanceInput {
    @location(5) offset: vec2<f32>,
    @location(6) scale: vec2<f32>,
    @location(7) color_tint: vec4<f32>,
};

@group(1) @binding(0) var<uniform> globals: Globals;

@group(0) @binding(0) var t_diffuse: texture_2d<f32>;
@group(0) @binding(1) var s_diffuse: sampler;

@vertex
fn vs_main(model: VertexInput, instance: InstanceInput) -> VertexOutput {
    var out: VertexOutput;
    out.tex_coords = model.tex_coords;
    out.color_tint = instance.color_tint;
    let world_pos = (model.position * instance.scale) + instance.offset;
    out.clip_position = globals.projection * vec4<f32>(world_pos, 0.0, 1.0);
    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4<f32> {
    let tex_color = textureSample(t_diffuse, s_diffuse, in.tex_coords);
    return tex_color * in.color_tint;
}
