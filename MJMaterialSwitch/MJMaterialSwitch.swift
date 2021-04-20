//
//  MJMaterialSwitch.swift
//  MJMaterialSwitch
//
//  Created by Jaleel on 3/21/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

//MARK: - Initial state (on or off)
public enum MJMaterialSwitchState {
    case on, off
}

class MJMaterialSwitch: UIControl {
    
    var isOn: Bool = true
    
    var thumbOnTintColor: UIColor!
    var thumbOffTintColor: UIColor!
    
    var trackOnTintColor: UIColor!
    var trackOffTintColor: UIColor!
    
    var thumbDisabledTintColor: UIColor!
    var trackDisabledTintColor: UIColor!
    
    var isBounceEnabled: Bool = false {
        didSet {
            if self.isBounceEnabled {
                self.bounceOffset = 3.0
            } else {
                self.bounceOffset = 0.0
            }
        }
    }
    var isRippleEnabled: Bool = true
    var rippleFillColor: UIColor = .gray
    
    var switchThumb: UIButton!
    var track: UIView!
    
    var tarckEdgeInset: UIEdgeInsets = UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
    
    fileprivate var thumbOnPosition: CGFloat!
    fileprivate var thumbOffPosition: CGFloat!
    fileprivate var bounceOffset: CGFloat!
    fileprivate var rippleLayer: CAShapeLayer!
    
    //MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initialize()
    }
    
    func initialize() {
        self.backgroundColor = .white
        
        // initialize parameters
        self.thumbOnTintColor  = UIColor(red:52.0 / 255.0, green:109.0 / 255.0, blue:241.0 / 255.0, alpha:1.0)
        self.thumbOffTintColor = UIColor(red:249.0 / 255.0, green:249.0 / 255.0, blue:249.0 / 255.0, alpha:1.0)
        
        self.trackOnTintColor = UIColor(red:143.0 / 255.0, green:179.0 / 255.0, blue:247.0 / 255.0, alpha:1.0)
        self.trackOffTintColor = UIColor(red:193.0 / 255.0, green:193.0 / 255.0, blue:193.0 / 255.0, alpha:1.0)
        
        self.thumbDisabledTintColor = UIColor(red:174.0 / 255.0, green:174.0 / 255.0, blue:174.0 / 255.0, alpha:1.0)
        self.trackDisabledTintColor = UIColor(red:203.0 / 255.0, green:203.0 / 255.0, blue:203.0 / 255.0, alpha:1.0)
        
        self.track = UIView(frame: self.getTrackFrame())
        self.track.backgroundColor = self.trackOnTintColor
        self.track.layer.cornerRadius = min(self.track.frame.size.height, self.track.frame.size.width) / 2
        self.addSubview(self.track)
        
        self.switchThumb = UIButton(frame: self.getThumbFrame())
        self.switchThumb.backgroundColor = self.thumbOnTintColor
        self.switchThumb.layer.cornerRadius = self.switchThumb.frame.size.height / 2
        self.switchThumb.layer.shadowOpacity = 0.5
        self.switchThumb.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.switchThumb.layer.shadowColor = UIColor.black.cgColor
        self.switchThumb.layer.shadowRadius = 2.0
        self.addSubview(self.switchThumb)
        
        // Add events for user action
        self.switchThumb.addTarget(self, action: #selector(self.onTouchDown(btn:withEvent:)), for: UIControl.Event.touchDown)
        self.switchThumb.addTarget(self, action: #selector(self.onTouchDragInside(btn:withEvent:)), for: UIControl.Event.touchDragInside)
        self.switchThumb.addTarget(self, action: #selector(self.onTouchUpOutsideOrCanceled(btn:withEvent:)), for: UIControl.Event.touchUpOutside)
        self.switchThumb.addTarget(self, action: #selector(self.onTouchUpOutsideOrCanceled(btn:withEvent:)), for: UIControl.Event.touchCancel)
        
        self.switchThumb.addTarget(self, action: #selector(self.switchAreaTapped), for: UIControl.Event.touchUpInside)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.switchAreaTapped))
        self.addGestureRecognizer(singleTap)
        
        self.setOn(on: self.isOn, animated: self.isRippleEnabled)
    }
    
    
    func updateUI() {
        self.layoutSubviews()
        
        self.track.frame = self.getTrackFrame()
        self.track.layer.cornerRadius = min(self.track.frame.size.height, self.track.frame.size.width) / 2
        
        self.switchThumb.frame = self.getThumbFrame()
        self.switchThumb.layer.cornerRadius = self.switchThumb.frame.size.height / 2
        
        self.setOn(on: self.isOn, animated: self.isRippleEnabled)
    }
    
    fileprivate func getTrackFrame() -> CGRect {
        var trackFrame = self.bounds
        trackFrame.size.height = (self.bounds.size.height - self.tarckEdgeInset.top - self.tarckEdgeInset.bottom)
        
        let thumbWidth = (trackFrame.size.height + 10) / 2
        trackFrame.size.width = frame.size.width - (self.tarckEdgeInset.left + self.tarckEdgeInset.right + thumbWidth)
        
        trackFrame.origin.x = 0.0 + self.tarckEdgeInset.left + (thumbWidth / 2)
        trackFrame.origin.y = (self.frame.size.height / 2)  - (trackFrame.size.height / 2)
        return trackFrame
    }
    
    fileprivate func getThumbFrame() -> CGRect {
        var thumbFrame = CGRect.zero
        thumbFrame.size.height = self.track.frame.size.height + 10
        thumbFrame.size.width = thumbFrame.size.height
        
        if isOn {
            thumbFrame.origin.x = self.track.frame.maxX - (thumbFrame.size.width / 2)
            thumbFrame.origin.y = (frame.size.height / 2)  - (thumbFrame.size.height / 2)
        } else {
            thumbFrame.origin.x = self.track.frame.minX - (thumbFrame.size.width / 2)
            thumbFrame.origin.y = (frame.size.height / 2)  - (thumbFrame.size.height / 2)
        }
        return thumbFrame
    }
    
    //MARK:  setter/getter
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
    
    @objc func switchAreaTapped() {
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
        UIView.animate(withDuration: 0.15, delay: 0.05, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.switchThumb.frame = self.getThumbFrame()
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
                self.sendActions(for: UIControl.Event.valueChanged)
            }
            // Bouncing effect: Move thumb a bit, for better UX
            
            UIView.animate(withDuration: 0.15, animations: {
                // Bounce to the position
                self.switchThumb.frame = self.getThumbFrame()
                
            }, completion: { (finished) in
                self.isUserInteractionEnabled = true
            })
        }
    }
    
    func changeThumbStateOFFwithAnimation() {
        
        // switch movement animation
        UIView.animate(withDuration: 0.15, delay: 0.05, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.switchThumb.frame = self.getThumbFrame()
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
                self.sendActions(for: UIControl.Event.valueChanged)
            }
            //    Bouncing effect: Move thumb a bit, for better UX
            
            UIView.animate(withDuration: 0.15, animations: {
                // Bounce to the position
                self.switchThumb.frame = self.getThumbFrame()
                
            }, completion: { (finish) in
                self.isUserInteractionEnabled = true
            })
        }
    }
    
    // Without animation
    func changeThumbStateONwithoutAnimation() {
        self.switchThumb.frame = self.getThumbFrame()
        if self.isEnabled {
            self.switchThumb.backgroundColor = self.thumbOnTintColor
            self.track.backgroundColor = self.trackOnTintColor
        } else {
            self.switchThumb.backgroundColor = self.thumbDisabledTintColor
            self.track.backgroundColor = self.trackDisabledTintColor
        }
        
        if !self.isOn {
            self.isOn = true
            self.sendActions(for: UIControl.Event.valueChanged)
        }
    }
    
    func changeThumbStateOFFwithoutAnimation() {
        self.switchThumb.frame = self.getThumbFrame()
        
        if self.isEnabled {
            self.switchThumb.backgroundColor = self.thumbOffTintColor
            self.track.backgroundColor = self.trackOffTintColor
        } else {
            self.switchThumb.backgroundColor = self.thumbDisabledTintColor
            self.track.backgroundColor = self.trackDisabledTintColor
        }
        
        if self.isOn {
            self.isOn = false
            self.sendActions(for: UIControl.Event.valueChanged)
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
        
        let path = UIBezierPath.init(roundedRect: rippleFrame, cornerRadius: self.switchThumb.layer.cornerRadius*2)
        
        // Set ripple layer attributes
        rippleLayer = CAShapeLayer()
        rippleLayer.path = path.cgPath
        rippleLayer.frame = rippleFrame
        rippleLayer.opacity = 0.2
        rippleLayer.strokeColor = UIColor.clear.cgColor
        rippleLayer.fillColor = self.rippleFillColor.cgColor
        rippleLayer.lineWidth = 0
        
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
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        rippleLayer?.add(animation, forKey: nil)
        
        CATransaction.commit()
        
        // End of animation, then remove ripple layer
    }
    
    //MARK: - Event Actions
    @objc func onTouchDown(btn: UIButton, withEvent event: UIEvent) {
        
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
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            rippleLayer?.add(animation, forKey: nil)
            CATransaction.commit()
        }
    }
    
    // Change thumb state when touchUPOutside action is detected
    @objc func onTouchUpOutsideOrCanceled(btn: UIButton, withEvent event: UIEvent) {
        
        if let touch = event.touches(for: btn)?.first {
            
            let prevPos = touch.previousLocation(in: btn)
            let pos = touch.location(in: btn)
            
            let dX = pos.x - prevPos.x
            
            //Get the new origin after this motion
            let newXOrigin = btn.frame.origin.x + dX
            
            if (newXOrigin > (self.frame.size.width - self.switchThumb.frame.size.width)/2) {
                self.changeThumbStateONwithAnimation()
            } else {
                self.changeThumbStateOFFwithAnimation()
            }
            
            if self.isRippleEnabled {
                self.animateRippleEffect()
            }
        }
    }
    
    @objc func onTouchDragInside(btn: UIButton, withEvent event:UIEvent) {
        //This code can go awry if there is more than one finger on the screen
        
        //        if let touch = event.touches(for: btn)?.first {
        //
        //            let prevPos = touch.previousLocation(in: btn)
        //            let pos = touch.location(in: btn)
        //            let dX = pos.x - prevPos.x
        //
        //            //Get the original position of the thumb
        //            var thumbFrame = btn.frame
        //
        //            thumbFrame.origin.x += dX
        //            //Make sure it's within two bounds
        //            thumbFrame.origin.x = min(thumbFrame.origin.x, thumbOnPosition)
        //            thumbFrame.origin.x = max(thumbFrame.origin.x, thumbOffPosition)
        //
        //            //Set the thumb's new frame if need to
        //            if thumbFrame.origin.x != btn.frame.origin.x {
        //                btn.frame = thumbFrame
        //            }
        //        }
    }
}
