const std = @import("std");
const lightmix = @import("lightmix");

const Sawtooth = @import("./sawtooth.zig");

pub fn gen(allocator: std.mem.Allocator) !lightmix.Wave(f64) {
    // Generate a 440Hz square wave
    const frequency: f64 = 440.0;
    const sample_rate: f64 = 44100.0;
    const volume: f64 = 0.25;

    return try Sawtooth.gen(
        f64,
        allocator,
        frequency,
        sample_rate,
        volume,
    );
}
