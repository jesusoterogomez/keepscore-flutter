

## After installing cloud_firestore@1.0.1, Flutter won't build for IOS

### Problem 1

Mismatch on "nanopb" version (CocoaPods could not find compatible versions for pod "nanopb")

Install a prerelease version of Cocoapods
`sudo gem install cocoapods --pre`

Delete cocoapods lockfile
`cd ios rm -rf Podfile.lock`

Install dependencies again
`pod install`


### Problem 2

https://stackoverflow.com/a/58543307/781779

This seems to be a problem with out of date `GoogleDataTransport` references are lingering from old pod versions

```
rm -rf ~/Library/Developer/Xcode/DerivedData/
rm -rf ~/Library/Caches/CocoaPods/
pod deintegrate
pod update
flutter clean
```

## XCode Builds are slow

Adding this to Podfile doesn't work, even though it's stated as a solution:

  # Improve iOS build times with pre-built Firebase SDK
  # @todo: enable for CI purposes
  # @see: https://firebase.flutter.dev/docs/overview#improve-ios-build-times
  # pod 'FirebaseFirestore', :git => 'https://github.com/invertase/firestore-ios-sdk-frameworks.git', :tag => '7.3.0'


