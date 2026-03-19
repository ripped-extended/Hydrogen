// instanced note rendering

#[repr(C)]
#[derive(Debug, Clone, Copy, bytemuck::Pod, bytemuck::Zeroable)]
pub struct Instance {
    pub offset: [f32; 2],
    pub scale: [f32; 2], // size of object in pixels [x, x]
    pub color_tint: [f32; 4],
}
