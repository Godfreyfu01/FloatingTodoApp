import SwiftUI

struct TransparentBackground: NSViewRepresentable {
    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        DispatchQueue.main.async {
            if let window = nsView.window {
                window.titlebarAppearsTransparent = true
                window.isMovableByWindowBackground = true
                window.backgroundColor = .clear
                window.isOpaque = false
                window.hasShadow = true
            }
        }
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}
