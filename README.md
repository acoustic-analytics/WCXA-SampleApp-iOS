# WCXA-SampleApp-iOS

WCXA-SampleApp-iOS is one of the sample iOS application that shows how to integrate [Tealeaf SDK](https://github.com/acoustic-analytics/IBMTealeaf) with any iOS Application.


## Getting Started

### Prerequisites

You need to have recent cocoapods version install on your Mac OS. Current version is 1.10.1. Please refer to cocoapods website for the details.

For SDK prerequisites and documentation, please refer to the SDK documentation [here](https://developer.goacoustic.com/acoustic-exp-analytics/docs/acoustic-experience-analytics-tealeaf-sdk-for-ios-standard-and-mobile-editions)

### Installing

Clone the sample app code from git hub location

`git clone https://github.com/acoustic-analytics/WCXA-SampleApp-iOS.git`

Go to the sample app location

`cd WCXA-SampleApp-iOS`

Now you need to install the pods by running one of the following commands.

`pod install`

or to update

`pod update`

Above pod command (install or update) should complete with no errors. If you do see errors run the same command with `--verbose` option and share the error log with us.

Open `CXA.xcworkspace` file and not the `CXA.xcodeproj` file. Once you open the workspace file, please use target CXA to build the sample app and run it. There are multiple targets in the project however the only one that serves for this example is the CXA target.

This project also uses Swift Package from https://github.com/acoustic-analytics/Tealeaf-SP which installs Tealeaf.

## Troubleshooting

If you are using Debug version of Tealeaf SDK. i.e. `pod 'IBMTealeafDebug'` , then you may edit your project's scheme in XCode and add environmental variable `EODebug`and set its value to 1; also add environmental variable `TLF_DEBUG` and set its value to 1. This will make the SDK to start writing debug logs to your xcode console window. If and when you want to report issues, the Tealeaf support engineers will ask you for these logs.


## Versioning


## License

License files can be read [here](https://github.com/acoustic-analytics/IBMTealeaf/tree/master/Licenses)
