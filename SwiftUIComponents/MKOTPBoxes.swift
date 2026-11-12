import SwiftUI

/// One-time-code entry with animated digit boxes and native iOS OTP autofill.
public struct MKOTPBoxes: View {
    @Binding var code: String
    let count: Int
    @FocusState private var focused: Bool

    public init(code: Binding<String>, count: Int = 6) { self._code = code; self.count = count }

    public var body: some View {
        ZStack {
            HStack(spacing: 9) {
                ForEach(0..<count, id: \.self) { index in
                    let active = index == code.count && code.count < count
                    Text(index < code.count ? String(Array(code)[index]) : "")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 13))
                        .overlay(RoundedRectangle(cornerRadius: 13).stroke(active ? Color.indigo : Color.gray.opacity(0.22), lineWidth: active ? 2 : 1))
                        .scaleEffect(active ? 1.04 : 1)
                        .animation(.spring(response: 0.25, dampingFraction: 0.6), value: code)
                }
            }
            TextField("", text: $code)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($focused)
                .opacity(0.015)
                .onChange(of: code) { value in code = String(value.filter(\.isNumber).prefix(count)) }
        }
        .contentShape(Rectangle())
        .onTapGesture { focused = true }
        .accessibilityLabel("One-time passcode")
    }
}
