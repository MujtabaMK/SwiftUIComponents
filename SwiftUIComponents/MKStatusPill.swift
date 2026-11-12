import SwiftUI

/// Status capsule with optional animated live indicator.
public struct MKStatusPill: View {
    let title: String
    var tint: Color
    var isLive: Bool
    @State private var pulse = false

    public init(_ title: String, tint: Color = .green, isLive: Bool = false) {
        self.title = title; self.tint = tint; self.isLive = isLive
    }

    public var body: some View {
        HStack(spacing: 7) {
            if isLive {
                Circle().fill(tint).frame(width: 7, height: 7)
                    .overlay(Circle().stroke(tint.opacity(0.35), lineWidth: pulse ? 6 : 2).scaleEffect(pulse ? 1.3 : 1))
            }
            Text(title).font(.system(size: 11, weight: .bold)).tracking(0.4)
        }
        .foregroundColor(tint)
        .padding(.horizontal, 12).padding(.vertical, 8)
        .background(tint.opacity(0.11), in: Capsule())
        .onAppear { if isLive { withAnimation(.easeOut(duration: 1).repeatForever(autoreverses: false)) { pulse = true } } }
    }
}
