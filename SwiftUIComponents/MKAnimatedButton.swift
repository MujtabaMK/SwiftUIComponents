import SwiftUI

/// Animated gradient CTA with press feedback, loading state and optional leading symbol.
public struct MKAnimatedButton: View {
    public enum Style { case primary, dark, success }
    let title: String
    let symbol: String?
    let style: Style
    let isLoading: Bool
    let action: () -> Void
    @State private var pressed = false
    @State private var glow = false

    public init(_ title: String, symbol: String? = "arrow.right", style: Style = .primary,
                isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title; self.symbol = symbol; self.style = style
        self.isLoading = isLoading; self.action = action
    }

    private var colors: [Color] {
        switch style {
        case .primary: return [Color(red: 0.35, green: 0.40, blue: 0.98), Color(red: 0.52, green: 0.28, blue: 0.91)]
        case .dark: return [Color(red: 0.12, green: 0.15, blue: 0.23), Color(red: 0.22, green: 0.26, blue: 0.36)]
        case .success: return [Color(red: 0.05, green: 0.65, blue: 0.43), Color(red: 0.02, green: 0.48, blue: 0.38)]
        }
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 11) {
                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text(title).font(.system(size: 16, weight: .bold))
                    if let symbol { Image(systemName: symbol).font(.system(size: 14, weight: .bold)) }
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(LinearGradient(gradient: Gradient(colors: colors), startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 17, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 17).stroke(Color.white.opacity(0.22), lineWidth: 1))
            .shadow(color: colors[0].opacity(glow ? 0.38 : 0.18), radius: glow ? 18 : 9, y: 7)
            .scaleEffect(pressed ? 0.975 : 1)
        }
        .buttonStyle(PressButtonStyle(pressed: $pressed))
        .disabled(isLoading)
        .onAppear { withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) { glow = true } }
    }
}

private struct PressButtonStyle: ButtonStyle {
    @Binding var pressed: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.spring(response: 0.25, dampingFraction: 0.62), value: configuration.isPressed)
    }
}
