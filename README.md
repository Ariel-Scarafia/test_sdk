# Fiserv_QR_SDK

[![CI Status](https://img.shields.io/travis/Ariel-Scarafia/Fiserv_QR_SDK.svg?style=flat)](https://travis-ci.org/Ariel-Scarafia/Fiserv_QR_SDK)
[![Version](https://img.shields.io/cocoapods/v/Fiserv_QR_SDK.svg?style=flat)](https://cocoapods.org/pods/Fiserv_QR_SDK)
[![License](https://img.shields.io/cocoapods/l/Fiserv_QR_SDK.svg?style=flat)](https://cocoapods.org/pods/Fiserv_QR_SDK)
[![Platform](https://img.shields.io/cocoapods/p/Fiserv_QR_SDK.svg?style=flat)](https://cocoapods.org/pods/Fiserv_QR_SDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Fiserv_QR_SDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Fiserv_QR_SDK'
```

## Author

Ariel Scarafia, ascarafia@gmail.com

## License

Fiserv_QR_SDK is available under the MIT license. See the LICENSE file for more info.


How to compile framework:

Open terminal inside project dir.
Type: 
```
xcodebuild archive \
  -scheme Fiserv_QR_SDK_private \
  -destination "generic/platform=iOS" \
  -archivePath "./build/iOS.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
  -scheme Fiserv_QR_SDK_private \
  -destination "generic/platform=iOS Simulator" \
  -archivePath "./build/iOS-Simulator.xcarchive" \
  SKIP_INSTALL=NO \
  BUILD_LIBRARY_FOR_DISTRIBUTION=YES
```

Then
```
xcodebuild -create-xcframework \
  -framework "./build/iOS.xcarchive/Products/Library/Frameworks/Fiserv_QR_SDK_private.framework" \
  -framework "./build/iOS-Simulator.xcarchive/Products/Library/Frameworks/Fiserv_QR_SDK_private.framework" \
  -output "./build/Fiserv_QR_SDK_private.xcframework"
```
