//
//  UIImageView+Helpers.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import UIKit

extension UIImageView {
  func cornerRadius(radius: CGFloat? = nil) {
    layer.cornerRadius = radius ?? frame.width / 2
    layer.masksToBounds = true
  }
}
