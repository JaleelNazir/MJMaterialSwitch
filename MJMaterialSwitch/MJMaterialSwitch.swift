//
//  MJMaterialSwitch.swift
//  MJMaterialSwitch
//
//  Created by Jaleel on 3/21/17.
//  Copyright © 2017 Glynk. All rights reserved.
//

import UIKit

//MARK: - Switch type
public enum MJMaterialSwitchStyle {
    case light, dark, medium
}

//MARK: - Initial state (on or off)
public enum MJMaterialSwitchState {
    case on, off
}

//MARK: - Initial MJMaterialSwitch size (big, normal, small)
public enum MJMaterialSwitchSize {
    case big, normal, small
}

class MJMaterialSwitch: UIControl {


    //MARK: - Properties

    //MARK:  State
    /** A Boolean value that represents switch's current state(ON/OFF). YES to ON, NO to OFF the switch */
    var isOn: Bool = false

    /** A Boolean value whether the bounce animation effect is enabled when state change movement */
    var isBounceEnabled: Bool = false {
        didSet {
            // Set bounce value, 3.0 if enabled and none for disabled
            if self.isBounceEnabled {
                self.bounceOffset = 3.0
            } else {
                self.bounceOffset = 0.0
            }
        }
    }

    /** A Boolean value whether the ripple animation effect is enabled or not */
    var isRippleEnabled: Bool = false

    //MARK:  Colour
    /** An UIColor property to represent the colour of the switch thumb when position is ON */
    var thumbOnTintColor: UIColor!

    /** An UIColor property to represent the colour of the switch thumb when position is OFF */
    var thumbOffTintColor: UIColor!

    /** An UIColor property to represent the colour of the track when position is ON */
    var trackOnTintColor: UIColor!

    /** An UIColor property to represent the colour of the track when position is OFF */
    var trackOffTintColor: UIColor!

    /** An UIColor property to represent the colour of the switch thumb when position is DISABLED */
    var thumbDisabledTintColor: UIColor!

    /** An UIColor property to represent the colour of the track when position is DISABLED */
    var trackDisabledTintColor: UIColor!

    /** An UIColor property to represent the fill colour of the ripple only when ripple effect is enabled */
    var rippleFillColor: UIColor = .gray

    //MARK:  UI components
    /** An UIButton object that represents current state(ON/OFF) */
    var switchThumb: UIButton!
    /** An UIView object that represents the track for the thumb */
    var track: UIView!


    /** A CGFloat value to represent the track thickness of this switch */
    var trackThickness: CGFloat!

    /** A CGFloat value to represent the switch thumb size(width and height) */
    var thumbSize: CGFloat!


    fileprivate var thumbOnPosition: CGFloat!
    fileprivate var thumbOffPosition: CGFloat!
    fileprivate var bounceOffset: CGFloat!
    fileprivate var thumbStyle: MJMaterialSwitchStyle!
    fileprivate var rippleLayer: CAShapeLayer!

    //MARK: - Initializer
    /**
     *  Initializes a MJMaterialSwitch in the easiest way with default parameters.
     *
     *  @MJMaterialSwitchStyle: MJMaterialSwitchStyleDefault,
     *  @MJMaterialSwitchState: MJMaterialSwitchStateOn,
     *  @MJMaterialSwitchSize: MJMaterialSwitchSizeNormal
     *
     *  @return A JTFadingInfoView with above parameters
     */
    //    - (id)init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /**
     *  Initializes a MJMaterialSwitch with a initial switch state position and size.
     *
     *  @param size A MJMaterialSwitchSize enum as this view's size(big, normal, small)
     *  @param state A MJMaterialSwitchState enum as this view's initial switch pos(ON/OFF)
     *
     *  @return A JTFadingInfoView with size and initial position
     */
    convenience init(withSize size: MJMaterialSwitchSize, state: MJMaterialSwitchState) {

        var frame: CGRect!
        var trackFrame = CGRect.zero
        var thumbFrame = CGRect.zero

        // Determine switch size
        // Actual initialization with selected size
        switch (size) {
        case .big:
            frame = CGRect(x: 0, y: 0, width: 50, height: 40)
            self.init(frame: frame)
            self.trackThickness = 23.0
            self.thumbSize = 31.0
            break

        case .normal:
            frame = CGRect(x: 0, y: 0, width: 40, height: 30)
            self.init(frame: frame)
            self.trackThickness = 17.0
            self.thumbSize = 24.0
            break

        case .small:
            frame = CGRect(x: 0, y: 0, width: 30, height: 25)
            self.init(frame: frame)
            self.trackThickness = 13.0
            self.thumbSize = 18.0
            break
        }

        // initialize parameters

        self.thumbOnTintColor  = UIColor(red:52.0 / 255.0, green:109.0 / 255.0, blue:241.0 / 255.0, alpha:1.0)
        self.thumbOffTintColor = UIColor(red:249.0 / 255.0, green:249.0 / 255.0, blue:249.0 / 255.0, alpha:1.0)

        self.trackOnTintColor = UIColor(red:143.0 / 255.0, green:179.0 / 255.0, blue:247.0 / 255.0, alpha:1.0)
        self.trackOffTintColor = UIColor(red:193.0 / 255.0, green:193.0 / 255.0, blue:193.0 / 255.0, alpha:1.0)

        self.thumbDisabledTintColor = UIColor(red:174.0 / 255.0, green:174.0 / 255.0, blue:174.0 / 255.0, alpha:1.0)
        self.trackDisabledTintColor = UIColor(red:203.0 / 255.0, green:203.0 / 255.0, blue:203.0 / 255.0, alpha:1.0)

        self.isEnabled = true

//        self.isRippleEnabled = true
//        self.isBounceEnabled = true

        self.bounceOffset = 3.0

        trackFrame.size.height = self.trackThickness
        trackFrame.size.width = frame.size.width
        trackFrame.origin.x = 0.0
        trackFrame.origin.y = (frame.size.height - trackFrame.size.height) / 2
        thumbFrame.size.height = self.thumbSize
        thumbFrame.size.width = thumbFrame.size.height
        thumbFrame.origin.x = 0.0
        thumbFrame.origin.y = (frame.size.height - thumbFrame.size.height) / 2

        self.track = UIView(frame: trackFrame)
        self.track.backgroundColor = .gray
        self.track.layer.cornerRadius = min(self.track.frame.size.height, self.track.frame.size.width) / 2
        self.addSubview(self.track)

        self.switchThumb = UIButton(frame: thumbFrame)
        self.switchThumb.backgroundColor = .white
        self.switchThumb.layer.cornerRadius = self.switchThumb.frame.size.height/2
        self.switchThumb.layer.shadowOpacity = 0.5
        self.switchThumb.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)

        self.switchThumb.layer.shadowColor = UIColor.black.cgColor
        self.switchThumb.layer.shadowRadius = 2.0

        // Add events for user action
        self.switchThumb.addTarget(self, action: #selector(self.onTouchDown(btn:withEvent:)), for: UIControlEvents.touchDown)
        self.switchThumb.addTarget(self, action: #selector(onTouchUpOutsideOrCanceled(btn:withEvent:)), for: UIControlEvents.touchUpOutside)
        self.switchThumb.addTarget(self, action: #selector(self.switchThumbTapped), for: UIControlEvents.touchUpInside)
        self.switchThumb.addTarget(self, action: #selector(self.onTouchDragInside(btn:withEvent:)), for: UIControlEvents.touchDragInside)
        self.switchThumb.addTarget(self, action: #selector(self.onTouchUpOutsideOrCanceled(btn:withEvent:)), for: UIControlEvents.touchCancel)

        self.addSubview(self.switchThumb)

        thumbOnPosition = self.frame.size.width - self.switchThumb.frame.size.width
        thumbOffPosition = self.switchThumb.frame.origin.x

        // Set thumb's initial position from state property
        switch state {
        case .on:
            self.isOn = true
            self.switchThumb.backgroundColor = self.thumbOnTintColor
            var thumb_Frame = self.switchThumb.frame
            thumb_Frame.origin.x = self.thumbOnPosition
            self.switchThumb.frame = thumb_Frame
            break

        case .off:
            self.isOn = false
            self.switchThumb.backgroundColor = self.thumbOffTintColor

            var thumb_Frame = self.switchThumb.frame
            thumb_Frame.origin.x = self.thumbOffPosition
            self.switchThumb.frame = thumb_Frame
            break
        }

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.switchAreaTapped(recognizer:)))
        self.addGestureRecognizer(singleTap)

        self.setOn(on: self.isOn, animated: self.isRippleEnabled)

    }

    /**
     *  Initializes a MJMaterialSwitch with a initial switch size, style and state.
     *
     *  @param size A MJMaterialSwitchSize enum as this view's size(big, normal, small)
     *  @param state A MJMaterialSwitchStyle enum as this view's initial style
     *  @param state A MJMaterialSwitchState enum as this view's initial switch pos(ON/OFF)
     *
     *  @return A JTFadingInfoView with size, style and initial position
     */

    // Designated initializer with size, style and state
    convenience init(withSize size: MJMaterialSwitchSize, style: MJMaterialSwitchStyle, state: MJMaterialSwitchState) {
        self.init(withSize: size, state: state)

        self.thumbStyle = style

        // Determine switch style from preset colour set
        // Light and Dark color styles come from Google's design guidelines
        // https://www.google.com/design/spec/components/selection-controls.html
        switch style {
        case .light:
            self.thumbOnTintColor  = UIColor(red:0.0/255.0, green:134.0/255.0, blue:117.0/255.0, alpha:1.0)
            self.thumbOffTintColor = UIColor(red:237.0/255.0, green:237.0/255.0, blue:237.0/255.0, alpha:1.0)
            self.trackOnTintColor = UIColor(red:90.0/255.0, green:178.0/255.0, blue:169.0/255.0, alpha:1.0)
            self.trackOffTintColor = UIColor(red:129.0/255.0, green:129.0/255.0, blue:129.0/255.0, alpha:1.0)
            self.thumbDisabledTintColor = UIColor(red:175.0/255.0, green:175.0/255.0, blue:175.0/255.0, alpha:1.0)
            self.trackDisabledTintColor = UIColor(red:203.0/255.0, green:203.0/255.0, blue:203.0/255.0, alpha:1.0)
            break

        case .medium:

            self.thumbOnTintColor  = UIColor(red:52.0/255.0, green:109.0/255.0, blue:241.0/255.0, alpha:1.0)
            self.thumbOffTintColor = UIColor(red:249.0/255.0, green:249.0/255.0, blue:249.0/255.0, alpha:1.0)
            self.trackOnTintColor = UIColor(red:143.0/255.0, green:179.0/255.0, blue:247.0/255.0, alpha:1.0)
            self.trackOffTintColor = UIColor(red:193.0/255.0, green:193.0/255.0, blue:193.0/255.0, alpha:1.0)
            self.thumbDisabledTintColor = UIColor(red:174.0/255.0, green:174.0/255.0, blue:174.0/255.0, alpha:1.0)
            self.trackDisabledTintColor = UIColor(red:203.0/255.0, green:203.0/255.0, blue:203.0/255.0, alpha:1.0)
            break

        case .dark:
            self.thumbOnTintColor  = UIColor(red:233.0/255.0, green:30.0/255.0, blue:99.0/255.0, alpha:1.0)
            self.thumbOffTintColor = UIColor(red:175.0/255.0, green:175.0/255.0, blue:175.0/255.0, alpha:1.0)

            self.trackOnTintColor = UIColor(red:240.0/255.0, green:98.0/255.0, blue:146.0/255.0, alpha:1.0)
            self.trackOffTintColor = UIColor(red:94.0/255.0, green:94.0/255.0, blue:94.0/255.0, alpha:1.0)

            self.thumbDisabledTintColor = UIColor(red:50.0/255.0, green:51.0/255.0, blue:50.0/255.0, alpha:1.0)
            self.trackDisabledTintColor = UIColor(red:56.0/255.0, green:56.0/255.0, blue:56.0/255.0, alpha:1.0)
            break

        }

        self.setOn(on: self.isOn, animated: self.isRippleEnabled)

    }

//    // When addSubview is called
//    func willMoveToSuperview(newSuperview: UIView) {
//        super.willMove(toSuperview: newSuperview)
//
//        print("willMoveToSuperview")
//
//        // Set colors for proper positions
//        if self.isOn {
//            self.switchThumb.backgroundColor = self.thumbOnTintColor
//            self.track.backgroundColor = self.trackOnTintColor
//        } else {
//            self.switchThumb.backgroundColor = self.thumbOffTintColor
//            self.track.backgroundColor = self.trackOffTintColor
//
//            // set initial position
//            self.changeThumbStateOFFwithoutAnimation()
//        }
//
//        if self.isEnabled {
//            self.switchThumb.backgroundColor = self.thumbDisabledTintColor
//            self.track.backgroundColor = self.trackDisabledTintColor
//        }
//
//        // Set bounce value, 3.0 if enabled and none for disabled
//        if self.isBounceEnabled {
//            bounceOffset = 3.0
//        } else {
//            bounceOffset = 0.0
//        }
//    }

    //MARK:  setter/getter
    /**
     *  Initializes a MJMaterialSwitch with a initial switch size, style and state.
     *
     *  @return A boolean value. Yes if the current switch state is ON, NO if OFF.
     */
    // Just returns current switch state,
    func getSwitchState() -> Bool {
        return self.isOn
    }

    /**
     *  Set switch state with or without moving animation of switch thumb
     *
     *  @param on The switch state you want to set
     *  @param animated Yes to set with animation, NO to do without.
     */
    // Change switch state if necessary, with the animated option parameter
    func setOn(on: Bool, animated: Bool)  {
        if on {
            if animated {
                // set on with animation
                self.changeThumbStateONwithAnimation()
            } else {
                // set on without animation
                self.changeThumbStateONwithoutAnimation()
            }
        } else {
            if animated {
                // set off with animation
                self.changeThumbStateOFFwithAnimation()
            } else {
                // set off without animation
                self.changeThumbStateOFFwithoutAnimation()
            }
        }
    }

    // Override setEnabled: function for changing color to the correct style
    func setEnabled(enabled: Bool)  {
        super.isEnabled = enabled
        // Animation for better transfer, better UX
        UIView.animate(withDuration: 0.1) {
            if enabled {
                if self.isOn {
                    self.switchThumb.backgroundColor = self.thumbOnTintColor
                    self.track.backgroundColor = self.trackOnTintColor
                } else {
                    self.switchThumb.backgroundColor = self.thumbOffTintColor
                    self.track.backgroundColor = self.trackOffTintColor
                }
                self.isEnabled = true

            } else { // if disabled
                self.switchThumb.backgroundColor = self.thumbDisabledTintColor
                self.track.backgroundColor = self.trackDisabledTintColor
                self.isEnabled = false
            }
        }
    }

    //The event handling method
    @objc func switchAreaTapped(recognizer: UITapGestureRecognizer) {
        self.changeThumbState()
    }

    func changeThumbState() {

        if self.isOn {
            self.changeThumbStateOFFwithAnimation()
        } else {
            self.changeThumbStateONwithAnimation()
        }

        if self.isRippleEnabled {
            self.animateRippleEffect()
        }
    }

    func changeThumbStateONwithAnimation() {

        // switch movement animation
        UIView.animate(withDuration: 0.15, delay: 0.05, options: UIViewAnimationOptions.curveEaseInOut, animations: {

            var thumbFrame = self.switchThumb.frame
            thumbFrame.origin.x = self.thumbOnPosition + self.bounceOffset
            self.switchThumb.frame = thumbFrame
            if self.isEnabled {
                self.switchThumb.backgroundColor = self.thumbOnTintColor
                self.track.backgroundColor = self.trackOnTintColor
            } else {
                self.switchThumb.backgroundColor = self.thumbDisabledTintColor
                self.track.backgroundColor = self.trackDisabledTintColor
            }
            self.isUserInteractionEnabled = false

        }) { (finished) in

            // change state to ON
            if !self.isOn {
                self.isOn = true // Expressly put this code here to change surely and send action correctly
                self.sendActions(for: UIControlEvents.valueChanged)
            }
            // print("now isOn: %d", self.isOn)
            // print("thumb end pos: %@", NSStringFromCGRect(self.switchThumb.frame))
            // Bouncing effect: Move thumb a bit, for better UX

            UIView.animate(withDuration: 0.15, animations: {
                // Bounce to the position
                var thumbFrame = self.switchThumb.frame
                thumbFrame.origin.x = self.thumbOnPosition
                self.switchThumb.frame = thumbFrame

            }, completion: { (finished) in
                self.isUserInteractionEnabled = true
            })
        }
    }

    func changeThumbStateOFFwithAnimation() {

        // switch movement animation
        UIView.animate(withDuration: 0.15, delay: 0.05, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            var thumbFrame = self.switchThumb.frame
            thumbFrame.origin.x = self.thumbOffPosition - self.bounceOffset
            self.switchThumb.frame = thumbFrame
            if self.isEnabled {
                self.switchThumb.backgroundColor = self.thumbOffTintColor
                self.track.backgroundColor = self.trackOffTintColor
            } else {
                self.switchThumb.backgroundColor = self.thumbDisabledTintColor
                self.track.backgroundColor = self.trackDisabledTintColor
            }
            self.isUserInteractionEnabled = false

        }) { (finished) in

            // change state to OFF
            if self.isOn {
                self.isOn = false // Expressly put this code here to change surely and send action correctly
                self.sendActions(for: UIControlEvents.valueChanged)
            }
            // print("now isOn: %d", self.isOn)
            // print("thumb end pos: %@", NSStringFromCGRect(self.switchThumb.frame))
            // Bouncing effect: Move thumb a bit, for better UX

            UIView.animate(withDuration: 0.15, animations: {

                // Bounce to the position
                var thumbFrame = self.switchThumb.frame
                thumbFrame.origin.x = self.thumbOffPosition
                self.switchThumb.frame = thumbFrame
            }, completion: { (finish) in
                self.isUserInteractionEnabled = true
            })
        }
    }

    // Without animation
    func changeThumbStateONwithoutAnimation() {

        var thumbFrame = self.switchThumb.frame
        thumbFrame.origin.x = thumbOnPosition
        self.switchThumb.frame = thumbFrame
        if self.isEnabled {
            self.switchThumb.backgroundColor = self.thumbOnTintColor
            self.track.backgroundColor = self.trackOnTintColor
        } else {
            self.switchThumb.backgroundColor = self.thumbDisabledTintColor
            self.track.backgroundColor = self.trackDisabledTintColor
        }

        if !self.isOn {
            self.isOn = true
            self.sendActions(for: UIControlEvents.valueChanged)
        }
    }

    // Without animation
    func changeThumbStateOFFwithoutAnimation() {

        var thumbFrame = self.switchThumb.frame
        thumbFrame.origin.x = thumbOffPosition
        self.switchThumb.frame = thumbFrame

        if self.isEnabled {
            self.switchThumb.backgroundColor = self.thumbOffTintColor
            self.track.backgroundColor = self.trackOffTintColor
        } else {
            self.switchThumb.backgroundColor = self.thumbDisabledTintColor
            self.track.backgroundColor = self.trackDisabledTintColor
        }

        if self.isOn {
            self.isOn = false
            self.sendActions(for: UIControlEvents.valueChanged)
        }
    }

    // Initialize and appear ripple effect
    func initializeRipple() {
        // Ripple size is twice as large as switch thumb

        let rippleScale : CGFloat = 2
        var rippleFrame = CGRect.zero
        rippleFrame.origin.x = -self.switchThumb.frame.size.width / (rippleScale * 2)
        rippleFrame.origin.y = -self.switchThumb.frame.size.height / (rippleScale * 2)
        rippleFrame.size.height = self.switchThumb.frame.size.height * rippleScale
        rippleFrame.size.width = rippleFrame.size.height

        //  print("")
        //  print("thumb State: %d", self.isOn)
        //  print("switchThumb pos: %@", NSStringFromCGRect(self.switchThumb.frame))

        let path = UIBezierPath.init(roundedRect: rippleFrame, cornerRadius: self.switchThumb.layer.cornerRadius*2)

        // Set ripple layer attributes
        rippleLayer = CAShapeLayer()
        rippleLayer.path = path.cgPath
        rippleLayer.frame = rippleFrame
        rippleLayer.opacity = 0.2
        rippleLayer.strokeColor = UIColor.clear.cgColor
        rippleLayer.fillColor = self.rippleFillColor.cgColor
        rippleLayer.lineWidth = 0

        //  print("Ripple origin pos: %@", NSStringFromCGRect(circleShape.frame))
        self.switchThumb.layer.insertSublayer(rippleLayer, below: self.switchThumb.layer)
    }

    func animateRippleEffect() {
        // Create ripple layer
        if rippleLayer == nil {
            self.initializeRipple()
        }

        // Animation begins from here
        rippleLayer?.opacity = 0.0

        CATransaction.begin()

        //remove layer after animation completed
        CATransaction.setCompletionBlock {
            self.rippleLayer?.removeFromSuperlayer()
            self.rippleLayer = nil
        }

        // Scale ripple to the modelate size
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0.5
        scaleAnimation.toValue = 1.25

        // Alpha animation for smooth disappearing
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0.4
        alphaAnimation.toValue = 0

        // Do above animations at the same time with proper duration
        let animation = CAAnimationGroup()
        animation.animations = [scaleAnimation, alphaAnimation]
        animation.duration = 0.4
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        rippleLayer?.add(animation, forKey: nil)

        CATransaction.commit()

        // End of animation, then remove ripple layer
        // print("Ripple removed")
    }

    //MARK: - Event Actions
    @objc func onTouchDown(btn: UIButton, withEvent event: UIEvent) {

        // print("touchDown called")
        if self.isRippleEnabled {
            self.initializeRipple()

            // Animate for appearing ripple circle when tap and hold the switch thumb
            CATransaction.begin()

            let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
            scaleAnimation.fromValue = 0.0
            scaleAnimation.toValue = 1.0

            let alphaAnimation = CABasicAnimation(keyPath:"opacity")
            alphaAnimation.fromValue = 0
            alphaAnimation.toValue = 0.2

            // Do above animations at the same time with proper duration
            let animation = CAAnimationGroup()
            animation.animations = [scaleAnimation, alphaAnimation]
            animation.duration = 0.4
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            rippleLayer?.add(animation, forKey: nil)
            CATransaction.commit()
        }
        //  print("Ripple end pos: %@", NSStringFromCGRect(circleShape.frame))
    }

    // Change thumb state when touchUPInside action is detected
    @objc func switchThumbTapped() {
        // print("touch up inside")
        // print("track midPosX: %f", CGRectGetMidX(self.track.frame))
        // print("%@", NSStringFromCGRect(self.switchThumb.frame))

        self.changeThumbState()
    }

    // Change thumb state when touchUPOutside action is detected
    @objc func onTouchUpOutsideOrCanceled(btn: UIButton, withEvent event: UIEvent) {

        // print("Touch released at ouside")
        if let touch = event.touches(for: btn)?.first {

            let prevPos = touch.previousLocation(in: btn)
            let pos = touch.location(in: btn)

            let dX = pos.x - prevPos.x

            //Get the new origin after this motion
            let newXOrigin = btn.frame.origin.x + dX
            //print("Released tap X pos: %f", newXOrigin)

            if (newXOrigin > (self.frame.size.width - self.switchThumb.frame.size.width)/2) {
                //print("thumb pos should be set *ON*")
                self.changeThumbStateONwithAnimation()
            } else {
                //print("thumb pos should be set *OFF*")
                self.changeThumbStateOFFwithAnimation()
            }

            if self.isRippleEnabled {
                self.animateRippleEffect()
            }
        }
    }

    // Drag the switch thumb
    @objc func onTouchDragInside(btn: UIButton, withEvent event:UIEvent) {
        //This code can go awry if there is more than one finger on the screen
        
        if let touch = event.touches(for: btn)?.first {
            
            let prevPos = touch.previousLocation(in: btn)
            let pos = touch.location(in: btn)
            let dX = pos.x - prevPos.x
            
            //Get the original position of the thumb
            var thumbFrame = btn.frame
            
            thumbFrame.origin.x += dX
            //Make sure it's within two bounds
            thumbFrame.origin.x = min(thumbFrame.origin.x, thumbOnPosition)
            thumbFrame.origin.x = max(thumbFrame.origin.x, thumbOffPosition)
            
            //Set the thumb's new frame if need to
            if thumbFrame.origin.x != btn.frame.origin.x {
                btn.frame = thumbFrame
            }
        }
    }
}
