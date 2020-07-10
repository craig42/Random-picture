# Random picture

## Presentation

This a simple iOS application which display random picture from [Unsplash](https://unsplash.com)

You can :
- Display picture on fullscreen
- Save picture at full size
- Get picture author

## Screenshot

![App screenshot](/AppScreenshot.png "Screenshot")

## Technical presentation

This app was written in Swift 5.2.4.

This app was done on the [VIPER architecture](https://hackernoon.com/introducing-clean-swift-architecture-vip-770a639ad7bf).
VIPER is an architecture pattern based on Clean Architecture. The word VIPER is a backronym for View, Interactor, Presenter, Entity and Routing. This divides an app’s logical structure into distinct layers of responsibility. 

[SwiftLint](https://github.com/realm/SwiftLint) was used to enforce Swift style and conventions.

## How to Use

1. Clone/Download the repo.
2. Open Random picture.xcodeproj
3. Install SwiftLint or remove it in Random picture -> Build Phases -> In targets on the left, click Random picture -> Run script -> at the right of this box, click on the cross.
4. Choose the right target your iPhone/iPad (if you have a free/paid developper account) or iOS simulator. You can also build this application for macOS (Thanks to [Catalyst](https://developer.apple.com/mac-catalyst/)).
5. Build & run and have fun.