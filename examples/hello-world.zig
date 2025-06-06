const std = @import("std");
const sdl3 = @import("sdl3");

const SCREEN_WIDTH = 640;
const SCREEN_HEIGHT = 480;

pub fn main() !void {
    defer sdl3.init.shutdown();

    const init_flags = sdl3.init.Flags{ .video = true };
    try sdl3.init.init(init_flags);
    defer sdl3.init.quit(init_flags);

    const window = try sdl3.video.Window.init("Hello SDL3", SCREEN_WIDTH, SCREEN_HEIGHT, .{});
    defer window.deinit();

    const surface = try window.getSurface();
    try surface.fillRect(null, surface.mapRgb(128, 30, 255));
    try window.updateSurface();

    while (true) {
        switch ((try sdl3.events.wait(true)).?) {
            .quit => break,
            .terminating => break,
            else => {}
        }
    }
}
