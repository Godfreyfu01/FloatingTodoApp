import SwiftUI

struct CustomTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.yellow)
            .shadow(color: .green, radius: 1, x: 0.1, y: 0.1)
            .background(Color.clear)
    }
}

struct CustomIconStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.yellow)
            .shadow(color: .green, radius: 1, x: 0.1, y: 0.1)
            .background(Color.clear)
            .frame(width: 15, height: 15)
    }
}

struct CustomBorderStyle: ViewModifier {
    var isAwake: Bool

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.yellow, lineWidth: isAwake ? 1 : 0) // 根据 isAwake 状态控制黄线显示
                    .shadow(color: .green, radius: 1, x: 0.1, y: 0.1)
            )
    }
}

extension View {
    func customTextStyle() -> some View {
        self.modifier(CustomTextStyle())
    }

    func customIconStyle() -> some View {
        self.modifier(CustomIconStyle())
    }

    func customBorderStyle(isAwake: Bool) -> some View {
        self.modifier(CustomBorderStyle(isAwake: isAwake))
    }
}
