import SwiftUI

struct WindowAccessor: NSViewRepresentable {
    var callback: (NSWindow?) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            if let window = view.window {
                configureWindow(window)
            }
            self.callback(view.window)
        }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}
    
    private func configureWindow(_ window: NSWindow) {
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]
        window.titlebarAppearsTransparent = true // 标题栏透明
        window.isOpaque = false
        window.backgroundColor = NSColor.clear
        window.titleVisibility = .hidden // 隐藏标题栏文字
        window.standardWindowButton(.closeButton)?.isHidden = false // 显示关闭按钮
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true // 隐藏最小化按钮
        window.standardWindowButton(.zoomButton)?.isHidden = true // 隐藏全屏按钮
    }
}
