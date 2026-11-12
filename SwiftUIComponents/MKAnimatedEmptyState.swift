import SwiftUI

/// Empty state with floating symbol and optional call-to-action.
public struct MKAnimatedEmptyState: View {
    let title: String
    let message: String
    var symbol: String
    var actionTitle: String?
    var action: (() -> Void)?
    @State private var float = false

    public init(title: String, message: String, symbol: String = "tray",
                actionTitle: String? = nil, action: (() -> Void)? = nil) {
        self.title = title; self.message = message; self.symbol = symbol
        self.actionTitle = actionTitle; self.action = action
    }

    public var body: some View {
        VStack(spacing: 13) {
            Image(systemName: symbol).font(.system(size: 35, weight: .light))
                .foregroundStyle(LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 86, height: 86)
                .background(Color.indigo.opacity(0.09), in: RoundedRectangle(cornerRadius: 27))
                .offset(y: float ? -6 : 6)
            Text(title).font(.system(size: 19, weight: .bold))
            Text(message).font(.system(size: 13)).foregroundColor(.secondary).multilineTextAlignment(.center).fixedSize(horizontal: false, vertical: true)
            if let actionTitle, let action {
                MKAnimatedButton(actionTitle, symbol: "plus", action: action).frame(maxWidth: 210).padding(.top, 5)
            }
        }
        .padding(22).frame(maxWidth: .infinity)
        .onAppear { withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) { float = true } }
    }
}
