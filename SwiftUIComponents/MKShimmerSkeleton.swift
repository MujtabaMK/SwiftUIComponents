import SwiftUI

/// Shimmer placeholder for loading content.
public struct MKShimmerSkeleton: View {
    var height: CGFloat
    @State private var phase: CGFloat = -0.8

    public init(height: CGFloat = 18) { self.height = height }

    public var body: some View {
        RoundedRectangle(cornerRadius: 9, style: .continuous)
            .fill(Color.gray.opacity(0.16))
            .frame(height: height)
            .overlay {
                GeometryReader { proxy in
                    LinearGradient(gradient: Gradient(colors: [.clear, .white.opacity(0.65), .clear]), startPoint: .leading, endPoint: .trailing)
                        .frame(width: proxy.size.width * 0.65)
                        .offset(x: proxy.size.width * phase)
                }
                .clipShape(RoundedRectangle(cornerRadius: 9))
            }
            .onAppear { withAnimation(.linear(duration: 1.25).repeatForever(autoreverses: false)) { phase = 1.2 } }
            .accessibilityLabel("Loading content")
    }
}
