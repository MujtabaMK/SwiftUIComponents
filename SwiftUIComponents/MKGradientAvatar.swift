import SwiftUI

/// Avatar with gradient ring, initials fallback and online indicator.
public struct MKGradientAvatar: View {
    let initials: String
    var size: CGFloat
    var online: Bool
    @State private var rotate = false

    public init(initials: String, size: CGFloat = 58, online: Bool = false) {
        self.initials = initials; self.size = size; self.online = online
    }

    public var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Circle().stroke(AngularGradient(gradient: Gradient(colors: [.purple, .blue, .cyan, .purple]), center: .center), lineWidth: 3)
                .frame(width: size, height: size).rotationEffect(.degrees(rotate ? 360 : 0))
            Text(initials).font(.system(size: size * 0.32, weight: .bold)).foregroundColor(.white)
                .frame(width: size - 9, height: size - 9).background(LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing), in: Circle())
                .padding(4)
            if online {
                Circle().fill(.green).frame(width: size * 0.22, height: size * 0.22)
                    .overlay(Circle().stroke(Color(uiColor: .systemBackground), lineWidth: 2))
            }
        }
        .onAppear { withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) { rotate = true } }
        .accessibilityLabel("Avatar \(initials)")
    }
}
