# WCXA-SampleApp-iOS

WCXA-SampleApp-iOS is one of the sample iOS application that shows how to integrate [IBM Tealeaf SDK](https://github.com/ibm-watson-cxa/IBMTealeaf) with any iOS Application.


## Getting Started

### Prerequisites

You need to have recent cocoapods version install on your Mac OS. Current version is 1.4.0. Please refer to cocoapods website for the details.

For SDK prerequisites and documentation, please refer to the SDK documentation [here](https://developer.ibm.com/customer-engagement/docs/watson-marketing/ibm-watson-customer-experience-analytics/ibm-watson-customer-experience-analytics-mobile-basic-edition/)

### Installing

Clone the sample app code from git hub location

`git clone https://github.com/ibm-watson-cxa/WCXA-SampleApp-iOS.git`

Go to the sample app location

`cd WCXA-SampleApp-iOS`

Open Podfile in a text editor of your choice and note the following lines in the Podfile

`source 'https://github.com/ibm-watson-cxa/EOCore.git'`

`source 'https://github.com/ibm-watson-cxa/IBMTealeaf.git'`

`source 'https://github.com/CocoaPods/Specs.git'`

Also note the platform in the Podfile iOS 9

`platform :ios, '9.0'`

Note that use_frameworks is uncommented

`use_frameworks!`

In the respective targets for your project in the Podfile add the following line if you want to use IBM Tealeaf SDK's release version

`pod 'IBMTealeaf'`

In the respective targets for your project in the Podfile add the following line if you want to use IBM Tealeaf SDK's debug version

`pod 'IBMTealeafDebug'`

You will notice that by default the sample application uses `pod 'IBMTealeafDebug'`

Note that you can use only one of  `pod 'IBMTealeaf'` and `pod 'IBMTealeafDebug'`. Do not use both at the same time.

Now you need to install the pods by running one of the following commands.

`pod install`

or to update

`pod update`

Above pod command (install or update) should complete with no errors. If you do see errors run the same command with `--verbose` option and share the error log with us.

Open `CXA.xcworkspace` file and not the `CXA.xcodeproj` file. Once you open the workspace file, please use target CXA to build the sample app and run it. There are multiple targets in the project however the only one that serves for this example is the CXA target.

## Troubleshooting

If you are using Debug version of IBM Tealeaf SDK. i.e. `pod 'IBMTealeafDebug'` , then you may edit your project's scheme in XCode and add environmental variable `EODebug`and set its value to 1; also add environmental variable `TLF_DEBUG` and set its value to 1. This will make the SDK to start writing debug logs to your xcode console window. If and when you want to report issues, the Tealeaf support engineers will ask you for these logs.


## Versioning


## License

License files can be read [here](https://github.com/ibm-watson-cxa/IBMTealeaf/tree/master/Licenses)
