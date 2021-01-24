//
//  DesignableButton.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import UIKit

@IBDesignable
class DesignableButton: UIButton {
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var imageEdgeInsetLeft: CGFloat {
        get {
            return imageEdgeInsets.left
        }
        set {
            imageEdgeInsets.left = newValue
        }
    }
    
    @IBInspectable var titleEdgeInsetLeft: CGFloat {
        get {
            return titleEdgeInsets.left
        }
        set {
            titleEdgeInsets.left = newValue
        }
    }
    
    @IBInspectable var titleEdgeInsetRight: CGFloat {
        get {
            return titleEdgeInsets.right
        }
        set {
            titleEdgeInsets.right = newValue
        }
    }
  
  @IBInspectable var shadowColor: UIColor = UIColor.gray {
    didSet {
      layer.shadowColor = shadowColor.cgColor
    }
  }
  
  @IBInspectable var shadowOpacity: Float = 1.0 {
    didSet {
      layer.shadowOpacity = shadowOpacity
    }
  }
  
  @IBInspectable var shadowRadius: CGFloat = 1.0 {
    didSet {
      layer.shadowRadius = shadowRadius
    }
  }
  
  @IBInspectable var masksToBounds: Bool = true {
    didSet {
      layer.masksToBounds = masksToBounds
    }
  }
  
  @IBInspectable var shadowOffset: CGSize = CGSize(width: 12, height: 12) {
    didSet {
      layer.shadowOffset = shadowOffset
    }
  }
  
}
