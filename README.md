AutomaticKeyboard
=================================

[![Swift Version](https://img.shields.io/badge/swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Build Status](https://travis-ci.org/Digipolitan/dependency-injector.svg?branch=master)](https://travis-ci.org/Digipolitan/automatic-keyboard)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/AutomaticKeyboard.svg)](https://img.shields.io/cocoapods/v/AutomaticKeyboard.svg)
[![Carthage Compatible](https://img.shields.io/badge/carthage-compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/AutomaticKeyboard.svg?style=flat)](http://cocoadocs.org/docsets/AutomaticKeyboard)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

AutomaticKeyboard is an helper to manage views when the keyboard is visible

## Installation

### CocoaPods

To install AutomaticKeyboard with CocoaPods, add the following lines to your `Podfile`.

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

pod 'AutomaticKeyboard'
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate AutomaticKeyboard into your Xcode project using Carthage, specify it in your `Cartfile`:

```
github 'Digipolitan/automatic-keyboard' ~> 1.0
```

Run `carthage update` to build the framework and drag the built `AutomaticKeyboard.framework` into your Xcode project.

## The Basics

In your **viewWillAppear** set your keyboard property

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

After all this steps you need to setup your **.xib** file to accept **AutomaticKeyboard**

Check `AutomaticKeyboardSample-iOS` for a complete example.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

AutomaticKeyboard is licensed under the [BSD 3-Clause license](LICENSE).
