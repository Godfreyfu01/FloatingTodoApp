import SwiftUI

struct WindowLevelModifier: ViewModifier {
    var level: NSWindow.Level

    func body(content: Content) -> some View {
        content
            .background(WindowAccessor { window in
                if let window = window {
                    window.level = level
                    window.isOpaque = false
                    window.backgroundColor = .clear
                }
            })
    }
}

extension View {
    func windowLevel(_ level: NSWindow.Level) -> some View {
        self.modifier(WindowLevelModifier(level: level))
    }
}
