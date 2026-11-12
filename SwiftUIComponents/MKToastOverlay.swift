import SwiftUI

/// View modifier for a spring-animated toast overlay.
public struct MKToastOverlay: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    var symbol: String

    public func body(content: Content) -> some View {
        content.overlay(alignment: .top) {
            if isPresented {
                HStack(spacing: 9) {
                    Image(systemName: symbol).foregroundColor(.green)
                    Text(message).font(.system(size: 13, weight: .semibold))
                }
                .padding(.horizontal, 17).padding(.vertical, 13)
                .background(.ultraThinMaterial, in: Capsule())
                .overlay(Capsule().stroke(Color.white.opacity(0.55), lineWidth: 1))
                .shadow(color: .black.opacity(0.12), radius: 15, y: 7)
                .padding(.top, 12)
                .transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) { isPresented = false }
                    }
                }
            }
        }
        .animation(.spring(response: 0.42, dampingFraction: 0.78), value: isPresented)
    }
}

public extension View {
    func mkToast(isPresented: Binding<Bool>, message: String, symbol: String = "checkmark.circle.fill") -> some View {
        modifier(MKToastOverlay(isPresented: isPresented, message: message, symbol: symbol))
    }
}
