# PIPassiveAlert

[![Language](https://img.shields.io/badge/language-Objective--C-blue.svg)]()
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-brightgreen.svg)](https://github.com/CocoaPods/CocoaPods)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg)](https://github.com/Carthage/Carthage)

A passive alert library in Objective-C. :rotating_light:

## Requirements

* iOS 8.0+

## Installation

### CocoaPods
PIPassiveAlert is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

```ruby
pod "PIPassiveAlert", :git => 'git@github.com:prolificinteractive/PIPassiveAlert.git', :tag => '0.0.6'
```

### Carthage

You can also add PIPassiveAlert to your project using [Carthage](https://github.com/Carthage/Carthage). Add the following to your `Cartfile`:

```ruby
github "prolificInteractive/PIPassiveAlert"
```

## Usage

### Configuration

#### Custom Nib

While a default look is provided for the alert, you have the option to provide a custom nib. The nib you provided *must* be of type `PIPassiveAlertView`.

For example, if we had a nib file with the file name `MyAlertView`, we could indicate a custom nib on our configuration as follows:

``` swift
config.nib = [UINib nibWithNibName:@"MyAlertView" bundle:nil];
```

Don't forget to implement `PIPassiveAlertView` delegate functions in your bustom nib, if desired!

## Contributing

To report a bug or enhancement request, feel free to file an issue under the respective heading.

If you wish to contribute to the project, fork this repo and submit a pull request. Code contributions should follow the standards specified in the [Prolific Objective-C Style Guide](https://github.com/prolificinteractive/objective-c-style-guide).

## Credits

### Icons

The default close icon was made by [Freepik](http://www.freepik.com) and made available by [Flaticon](http://www.flaticon.com) under the [CC 3.0 BY](http://creativecommons.org/licenses/by/3.0/) license. 

Usage of this library in which the default icon is not replaced must provide this attribution.

## License

PIPassiveAlert is Copyright (c) 2016 Prolific Interactive. It may be redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

## Maintainers

[![Prolific Interactive](https://s3.amazonaws.com/prolificsitestaging/logos/Prolific_Logo_Full_Color.png)](http://prolificinteractive.com)

PIPassiveAlert is maintained and funded by Prolific Interactive. The names and logos are trademarks of Prolific Interactive.
