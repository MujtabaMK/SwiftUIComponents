#Version 1.0 · SwiftUI · iOS 15+

A premium-oriented collection of animated, reusable SwiftUI building blocks with a live gallery demo.

## Components
- `MKAnimatedButton`: gradient CTA, press feedback, loading state and subtle glow.
- `MKFloatingField`: animated floating label, focus styling, clear action and inline error.
- `MKGlassCard`: glass-inspired card surface with press feedback and accent styling.
- `MKStatusPill`: status capsule with optional pulsing live indicator.
- `MKGradientAvatar`: animated gradient ring, initials and online indicator.
- `MKShimmerSkeleton`: animated loading shimmer.
- `MKAnimatedEmptyState`: floating icon and optional CTA.
- `MKOTPBoxes`: digit boxes, number pad and iOS one-time-code autofill.
- `MKToastOverlay`: spring-animated toast presentation modifier.
- `MKToastOverlay` is exposed through `.mkToast(isPresented:message:)`.

## Run the demo
1. Create a new iOS App project in Xcode using SwiftUI.
2. Drag the entire `Sources/MHKPremiumKit` folder into the project. Select **Copy items if needed** and ensure your app target is checked.
3. Add `Demo/ContentView.swift` to your app target.
4. If you copied component files into the same app target, do not add a module import.
5. Set `ContentView()` as the root view in your `@main App` file.
6. Open Canvas and resume Preview, or run in an iOS Simulator.

## Requirements
- iOS 15.0+
- Swift 5.7+
- Xcode 14+ recommended

## Important
This is a source-code starter kit. The components are self-contained UI building blocks, not a complete backend or purchase/authentication product. Test on supported devices and OS versions before commercial distribution. Review accessibility, localization, reduced-motion behavior and production edge cases before release.

## License
See `LICENSE.txt`. Add your support email before publishing.
