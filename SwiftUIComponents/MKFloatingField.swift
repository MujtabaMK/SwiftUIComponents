import SwiftUI

/// Floating-label input with focus animation and inline validation.
public struct MKFloatingField: View {
    let title: String
    @Binding var text: String
    var symbol: String
    var error: String?
    @FocusState private var focused: Bool

    public init(_ title: String, text: Binding<String>, symbol: String = "person",
                error: String? = nil) {
        self.title = title; self._text = text; self.symbol = symbol; self.error = error
    }

    private var active: Bool { focused || !text.isEmpty }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                Image(systemName: symbol).foregroundColor(focused ? .indigo : .secondary).frame(width: 20)
                VStack(alignment: .leading, spacing: 2) {
                    if active {
                        Text(title.uppercased()).font(.system(size: 9, weight: .bold)).tracking(0.8).foregroundColor(focused ? .indigo : .secondary)
                            .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                    TextField(active ? "" : title, text: $text)
                        .font(.system(size: 15, weight: .medium))
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focused)
                }
                if !text.isEmpty {
                    Button { withAnimation(.spring()) { text = "" } } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 15).frame(height: 62)
            .background(Color(uiColor: .secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(error != nil ? Color.red : (focused ? Color.indigo : Color.gray.opacity(0.22)), lineWidth: focused || error != nil ? 1.5 : 1))
            .animation(.spring(response: 0.28, dampingFraction: 0.78), value: active)
            if let error {
                Label(error, systemImage: "exclamationmark.circle.fill").font(.caption).foregroundColor(.red).transition(.opacity)
            }
        }
    }
}
