# MJMaterialSwitch

![MJMaterialSwitch](TiitleTheme.png)

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


### Customize Behaviors
MJMaterialSwitch has many prateters to customize behaviors as you like.

#### Style and size
#### MJMaterialSwitchStyle
.light
.dark
.default

#### MJMaterialSwitchSize
.big
.normal
.small
 
 ![Screen shot](Docs/style_and_size.gif)

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
