//
//  ContentView.swift
//  SwiftUIComponents
//
//  Created by Mujtaba Khan on 12/11/26.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var email = "developer@example.com"
    @State private var otp = "24"
    @State private var showToast = false
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 26) {
                    VStack(alignment: .leading, spacing: 7) {
                        Text("MHK CODECRAFT").font(.system(size: 11, weight: .heavy)).tracking(2).foregroundColor(.indigo)
                        Text("Premium SwiftUI Kit").font(.system(size: 30, weight: .bold))
                        Text("Beautiful, animated building blocks for real apps.")
                            .font(.subheadline).foregroundColor(.secondary)
                    }
                    section("01  •  ACTION BUTTONS") {
                        MKAnimatedButton("Create your account", symbol: "arrow.up.right") { showToast = true }
                        MKAnimatedButton("Continue securely", symbol: "lock.fill", style: .dark) {}
                        MKAnimatedButton("Loading state", isLoading: true) {}
                    }
                    section("02  •  FLOATING INPUT") {
                        MKFloatingField("Full name", text: $name, symbol: "person")
                        MKFloatingField("Email address", text: $email, symbol: "envelope", error: email.contains("@") ? nil : "Please enter a valid email")
                    }
                    section("03  •  GLASS CARDS") {
                        MKGlassCard(accent: .indigo, action: { showToast = true }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 7) {
                                    Text("TOTAL REVENUE").font(.system(size: 10, weight: .bold)).tracking(1.2).foregroundColor(.secondary)
                                    Text("$24,580").font(.system(size: 29, weight: .bold))
                                    Label("+12.8% this month", systemImage: "arrow.up.right").font(.caption.weight(.semibold)).foregroundColor(.green)
                                }
                                Spacer()
                                Image(systemName: "chart.line.uptrend.xyaxis").font(.system(size: 30, weight: .medium)).foregroundColor(.indigo)
                            }
                        }
                    }
                    section("04  •  LIVE STATUS & AVATAR") {
                        HStack(spacing: 12) {
                            MKGradientAvatar(initials: "MK", size: 58, online: true)
                            VStack(alignment: .leading, spacing: 5) {
                                Text("MHK CodeCraft").font(.headline)
                                Text("Product creator").font(.caption).foregroundColor(.secondary)
                            }
                            Spacer()
                            MKStatusPill("Online", tint: .green, isLive: true)
                        }
                    }
                    section("05  •  SHIMMER LOADING") {
                        VStack(alignment: .leading, spacing: 11) {
                            MKShimmerSkeleton(height: 18).frame(width: 145)
                            MKShimmerSkeleton(height: 13)
                            MKShimmerSkeleton(height: 13).frame(width: 230)
                        }.padding(17).background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 18))
                    }
                    section("06  •  OTP INPUT") { MKOTPBoxes(code: $otp) }
                    section("07  •  EMPTY STATE") {
                        MKAnimatedEmptyState(title: "Your workspace is empty",
                                             message: "Create your first project and keep everything in one place.",
                                             symbol: "square.stack.3d.up",
                                             actionTitle: "Create project") { showToast = true }
                            .background(Color(uiColor: .secondarySystemBackground), in: RoundedRectangle(cornerRadius: 22))
                    }
                    section("08  •  TOAST FEEDBACK") {
                        MKAnimatedButton("Show success toast", symbol: "checkmark") { showToast = true }
                    }
                }
                .padding(20)
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .navigationBarTitle("Component Gallery", displayMode: .inline)
            .mkToast(isPresented: $showToast, message: "Your changes have been saved")
        }
    }

    private func section<Content: View>(_ title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 13) {
            Text(title).font(.system(size: 12, weight: .heavy)).tracking(0.8).foregroundColor(.secondary)
            content()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView().preferredColorScheme(.light)
            ContentView().preferredColorScheme(.dark)
        }
    }
}

