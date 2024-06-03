import SwiftUI

@main
struct FloatingTodoApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 300, minHeight: 400)
                .background(Color.clear)
                .windowLevel(.floating)
                .onAppear {
                    if let window = NSApplication.shared.windows.first {
                        configureWindow(window)
                    }
                }
        }
    }
    
    private func configureWindow(_ window: NSWindow) {
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenPrimary]
        window.titlebarAppearsTransparent = true // 标题栏透明
        window.isOpaque = false // 设置窗口为透明
        window.backgroundColor = NSColor.clear
        window.titleVisibility = .hidden // 隐藏标题栏文字
        window.standardWindowButton(.closeButton)?.isHidden = false // 显示关闭按钮
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true // 隐藏最小化按钮
        window.standardWindowButton(.zoomButton)?.isHidden = true // 隐藏全屏按钮
    }
}
