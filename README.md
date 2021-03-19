# WCXA-SampleApp-iOS

WCXA-SampleApp-iOS is one of the sample iOS application that shows how to integrate [Tealeaf SDK](https://github.com/acoustic-analytics/IBMTealeaf) with any iOS Application.


## Getting Started

### Prerequisites

You need to have recent carthage version install on your Mac OS. Current version is 0.36.0. Please refer to carthage website for the details.

For SDK prerequisites and documentation, please refer to the SDK documentation [here](https://developer.goacoustic.com/acoustic-exp-analytics/docs/acoustic-experience-analytics-tealeaf-sdk-for-ios-standard-and-mobile-editions)

### Installing

Clone the sample app code from git hub location

`git clone https://github.com/acoustic-analytics/WCXA-SampleApp-iOS.git`

Go to the sample app location

`cd WCXA-SampleApp-iOS`

Open Cartfile in a text editor of your choice and note the following lines in the Podfile

In the respective targets for your project in the Podfile add the following line if you want to use Tealeaf SDK's release version

`binary "https://raw.githubusercontent.com/acoustic-analytics/IBMTealeaf/master/Tealeaf.json" >= 10.6.36`

`binary "https://raw.githubusercontent.com/acoustic-analytics/EOCore/master/EOCore.json" >= 2.3.24`

In the respective targets for your project in the Podfile add the following line if you want to use Tealeaf SDK's debug version

`binary "https://raw.githubusercontent.com/acoustic-analytics/IBMTealeaf/master/TealeafDebug.json" >= 10.6.36`

`binary "https://raw.githubusercontent.com/acoustic-analytics/EOCore/master/EOCoreDebug.json" >= 2.3.24`

You will notice that by default the sample application uses `Debug` version of libraries.

Note that you can use only one of  `Release` or `Debug`. Do not use both at the same time.

Now you need to install the carthage by running the following command.

`carthage update --platform iOS`

Above carthage command should complete with no errors.

Open `CXA.xcworkspace` file and not the `CXA.xcodeproj` file. Once you open the workspace file, please use target CXA to build the sample app and run it. There are multiple targets in the project however the only one that serves for this example is the CXA target.

## Troubleshooting

If you are using Debug version of Tealeaf SDK, then you may edit your project's scheme in XCode and add environmental variable `EODebug`and set its value to 1; also add environmental variable `TLF_DEBUG` and set its value to 1. This will make the SDK to start writing debug logs to your xcode console window. If and when you want to report issues, the Tealeaf support engineers will ask you for these logs.


## Versioning


## License

License files can be read [here](https://github.com/acoustic-analytics/IBMTealeaf/tree/master/Licenses)
