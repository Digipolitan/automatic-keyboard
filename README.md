AutomaticKeyboard
=================================

[![Build Status](https://travis-ci.org/Digipolitan/dependency-injector.svg?branch=master)](https://travis-ci.org/Digipolitan/dependency-injector)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AutomaticKeyboard.svg)](https://img.shields.io/cocoapods/v/AutomaticKeyboard.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/AutomaticKeyboard.svg?style=flat)](http://cocoadocs.org/docsets/AutomaticKeyboard)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

Dependency injector Swift. Compatible for swift server-side and swift for iOS

## Installation

### CocoaPods

To install AutomaticKeyboard with CocoaPods, add the following lines to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0' # or platform :osx, '10.10' if your target is OS X.
use_frameworks!

pod 'AutomaticKeyboard'
```

## The Basics

First create the outlet containing the keyboardView and the property containing your keyboard object

```swift
@IBOutlet var keyboardView: UIView?
public var keyboard: Keyboard?
```

Then set the keyboard options like following

```swift
public var keyboardOptions = Keyboard.Options(mode: .insets)
```

Then in your **viewWillAppear** set your keyboard property

```swift
override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let kv = self.keyboardView {
        self.keyboard = Keyboard(view: kv, options: self.keyboardOptions)
    }
}
```
and in your **viewDidDisappear**

```swift
override open func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.keyboard = nil
}
```

After all this steps you need to setup your **.xib** file to accept **AutomaticKeyboard**, for that just add a **scrollView** to your view and **link** it to the **keyboardView** outlet.<br><br>
Check `AutomaticKeyboardSample-iOS` for a complete example.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

AutomaticKeyboard is licensed under the [BSD 3-Clause license](LICENSE).
