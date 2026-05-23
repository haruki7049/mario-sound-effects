const std = @import("std");
const lightmix = @import("lightmix");

const Sawtooth = @import("./sawtooth.zig");
const Scale = @import("./scale.zig");
const Splitter = @import("./splitter.zig");
const Filters = @import("./filters.zig");

pub fn gen(allocator: std.mem.Allocator) !lightmix.Wave(f64) {
    const sample_rate: f64 = 44100.0;
    const channels = 1;
    const volume: f64 = 0.25;

    var _4_4_c4_sawtooth = try Sawtooth.gen(
        f64,
        allocator,
        Scale.gen(.{ .code = .c, .octave = 4 }),
        sample_rate,
        volume,
    );
    try _4_4_c4_sawtooth.filter(Filters.decay);
    defer _4_4_c4_sawtooth.deinit();

    var _4_4_e4_sawtooth = try Sawtooth.gen(
        f64,
        allocator,
        Scale.gen(.{ .code = .e, .octave = 4 }),
        sample_rate,
        volume,
    );
    try _4_4_e4_sawtooth.filter(Filters.decay);
    defer _4_4_e4_sawtooth.deinit();

    return try Splitter.gen(
        f64,
        allocator,
        44100 * 2,
        &.{
            _4_4_c4_sawtooth,
            _4_4_e4_sawtooth,
            _4_4_c4_sawtooth,
            _4_4_e4_sawtooth,
        },
        sample_rate,
        channels,
    );
}
