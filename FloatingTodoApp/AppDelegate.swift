import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate, NSWindowDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            window.delegate = self
            configureWindow(window)
            restoreWindowSize(window)
        }
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        if !flag {
            for window in sender.windows {
                window.makeKeyAndOrderFront(self)
                configureWindow(window)
                restoreWindowSize(window)
            }
        }
        return true
    }
    
    func applicationWillTerminate(_ notification: Notification) {
        if let window = NSApplication.shared.windows.first {
            saveWindowSize(window)
        }
    }
    
    func windowWillMiniaturize(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            saveWindowSize(window)
        }
    }
    
    func windowWillClose(_ notification: Notification) {
        if let window = notification.object as? NSWindow {
            saveWindowSize(window)
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
        
        // 添加调试日志
        print("Window configured with frame: \(window.frame)")
    }
    
    private func saveWindowSize(_ window: NSWindow) {
        let size = NSStringFromRect(window.frame)
        UserDefaults.standard.set(size, forKey: "windowFrame")
        // 添加调试日志
        print("Window size saved: \(size)")
    }
    
    private func restoreWindowSize(_ window: NSWindow) {
        if let savedFrame = UserDefaults.standard.string(forKey: "windowFrame") {
            window.setFrame(NSRectFromString(savedFrame), display: true)
            // 添加调试日志
            print("Window size restored: \(savedFrame)")
        } else {
            // 添加调试日志
            print("No saved window size found, using default size.")
        }
    }
}
