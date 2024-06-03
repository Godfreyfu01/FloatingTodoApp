import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    var callback: (NSWindow?) -> ()

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            self.callback(view.window)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
}

extension View {
    func windowLevel(_ level: NSWindow.Level) -> some View {
        self.background(WindowAccessor { window in
            window?.level = level
        })
    }
}
