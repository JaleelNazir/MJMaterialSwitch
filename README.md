# MJMaterialSwitch
Android Switch button for iOS

![MJMaterialSwitch](Docs/MJMaterialSwitch_Title.png)

## Overview
<img src="Docs/MJMaterialSwitch.png" width="250" align="right" />

`MJMaterialSwitch` is google's material design like switch UI with animation features.

This library has cool and sophisticated animations, ripple effect and bounce effect. Also, customizable properties can be tweaked behaviors and enhance your application UI cool.

With this library, you can easily implement material design switch to your app. 

<br/>

<br/>

## Usage

The simplest setup:

```objective-c
  MJMaterialSwitch *switch = [[MJMaterialSwitch alloc] init];
  switch.center = CGPointMake(200, 200);
  [self.view addSubview:switch];
```

This is the simplest and easiest initialization. 
The style, size and initial state of `MJMaterialSwitch` instance is set to all default value as shown below.

<img src="Docs/simple.gif" width="200">

In addition, this library also has following designated initializers to set these parameters.

```objective-c
 /**
  *  Initializes a MJMaterialSwitch with a initial switch state position and size.
  *
  *  @param size A MJMaterialSwitchSize enum as this view's size(big, normal, small)
  *  @param state A MJMaterialSwitchState enum as this view's initial switch pos(ON/OFF)
  *
  *  @return A MJMaterialSwitch with size and initial position
  */
 - (id)initWithSize:(MJMaterialSwitchSize)size state:(MJMaterialSwitchState)state;

 /**
  *  Initializes a MJMaterialSwitch with a initial switch size, style and state.
  *
  *  @param size A MJMaterialSwitchSize enum as this view's size(big, normal, small)
  *  @param state A MJMaterialSwitchStyle enum as this view's initial style
  *  @param state A MJMaterialSwitchState enum as this view's initial switch pos(ON/OFF)
  *
  *  @return A MJMaterialSwitch with size, style and initial position
  */
- (id)initWithSize:(MJMaterialSwitchSize)size style:(MJMaterialSwitchStyle)style state:(MJMaterialSwitchState)state;
```

### Customize Behaviors
MJMaterialSwitch has many prateters to customize behaviors as you like.

#### Style and size
## MJMaterialSwitchStyle
 - .light
 - .dark
 - .default

## MJMaterialSwitchSize
 - .big
 - .normal
 - .small
 
 ![Screen shot](Docs/style_and_size.gif)

 
#### Properties

```objective-c
#pragma State
/** A Boolean value that represents switch's current state(ON/OFF). YES to ON, NO to OFF the switch */
@property (nonatomic) BOOL isOn;
/** A Boolean value that represents switch's interaction mode. YES to set enabled, No to set disabled*/
@property (nonatomic) BOOL isEnabled;
/** A Boolean value whether the bounce animation effect is enabled when state change movement */
@property (nonatomic) BOOL isBounceEnabled;
/** A Boolean value whether the ripple animation effect is enabled or not */
@property (nonatomic) BOOL isRippleEnabled;

#pragma Color
/** An UIColor property to represent the color of the switch thumb when position is ON */
@property (nonatomic, strong) UIColor *thumbOnTintColor;
/** An UIColor property to represent the color of the switch thumb when position is OFF */
@property (nonatomic, strong) UIColor *thumbOffTintColor;
/** An UIColor property to represent the color of the track when position is ON */
@property (nonatomic, strong) UIColor *trackOnTintColor;
/** An UIColor property to represent the color of the track when position is OFF */
@property (nonatomic, strong) UIColor *trackOffTintColor;
/** An UIColor property to represent the color of the switch thumb when position is DISABLED */
@property (nonatomic, strong) UIColor *thumbDisabledTintColor;
/** An UIColor property to represent the color of the track when position is DISABLED */
@property (nonatomic, strong) UIColor *trackDisabledTintColor;
/** An UIColor property to represent the fill color of the ripple only when ripple effect is enabled */
@property (nonatomic, strong) UIColor *rippleFillColor;

```

 ![Screen shot](Docs/bounce_ripple_enabled.gif)

## Change History
1.1   Bug Fix

1.0.0 Initial Release

## Requirements
iOS 7.0 or later

## Author
Jaleel Nazir <nazirjaleel@gmail.com>

## License
MJMaterialSwitch is available under the MIT license.
