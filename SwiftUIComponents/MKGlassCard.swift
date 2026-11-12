import SwiftUI

/// Tappable glass-style card with press depth and animated accent.
public struct MKGlassCard<Content: View>: View {
    let content: Content
    var accent: Color
    var action: (() -> Void)?
    @State private var pressed = false
    @State private var shimmer = false

    public init(accent: Color = .indigo, action: (() -> Void)? = nil,
                @ViewBuilder content: () -> Content) {
        self.accent = accent; self.action = action; self.content = content()
    }

    public var body: some View {
        Group {
            if let action {
                Button(action: action) { cardContent }
                    .buttonStyle(.plain)
            } else { cardContent }
        }
    }

    private var cardContent: some View {
        content.padding(20).frame(maxWidth: .infinity, alignment: .leading)
            .background {
                RoundedRectangle(cornerRadius: 23, style: .continuous)
                    .fill(LinearGradient(colors: [Color(uiColor: .secondarySystemBackground), accent.opacity(0.075)], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .overlay(alignment: .topTrailing) {
                        Circle().fill(accent.opacity(0.10)).frame(width: 130, height: 130).blur(radius: 2).offset(x: 35, y: -55).clipped()
                    }
            }
            .overlay(RoundedRectangle(cornerRadius: 23).stroke(Color.white.opacity(0.75), lineWidth: 1))
            .shadow(color: accent.opacity(pressed ? 0.20 : 0.09), radius: pressed ? 8 : 18, y: pressed ? 3 : 10)
            .scaleEffect(pressed ? 0.985 : 1)
            .animation(.spring(response: 0.32, dampingFraction: 0.72), value: pressed)
            .onLongPressGesture(minimumDuration: 0.01, pressing: { pressed = $0 }, perform: {})
    }
}
