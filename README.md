# SlackyBeaver

[![CI Status](http://img.shields.io/travis/drewg233/SlackyBeaver.svg?style=flat)](https://travis-ci.org/drewg233/SlackyBeaver)
[![Version](https://img.shields.io/cocoapods/v/SlackyBeaver.svg?style=flat)](http://cocoapods.org/pods/SlackyBeaver)
[![License](https://img.shields.io/cocoapods/l/SlackyBeaver.svg?style=flat)](http://cocoapods.org/pods/SlackyBeaver)
[![Platform](https://img.shields.io/cocoapods/p/SlackyBeaver.svg?style=flat)](http://cocoapods.org/pods/SlackyBeaver)

## Description

Takes the SwiftyBeaver library and will send a slack message of the logs whenever slacky.error(message) gets called.

## Installation

SlackyBeaver is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SlackyBeaver"
```

## Usage

Add that near the top of your `AppDelegate.swift` to be able to use SwiftyBeaver in your whole project.

``` Swift
import SlackyBeaver
let slacky = SlackyBeaver(slackToken: "YOUR-SLACK-API-TOKEN-HERE", slackChannel: "ios-logs")
```

Then you can call

``` Swift
slacky.debug(message: "Here is first log")
slacky.verbose(message: "Here is second log")
slacky.info("Here is third log")
slacky.warning("Here is fourth log")
slacky.error("This will log, then send the logs to the slack channel")
```

Upon calling `slacky.error` it will send the logs to the configured slack channel on a background thread.



## Author

drewg233, drewgarcia23@gmail.com

## License

SlackyBeaver is available under the MIT license. See the LICENSE file for more info.
