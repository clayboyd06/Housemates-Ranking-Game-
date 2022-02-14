//
//  Utils.swift
//  LittleBoyChamp
//
//  Created by Clay Boyd on 2/11/22.
//

import Foundation
import UIKit
import SwiftUI

class Utils {
    
    // ============ STYLE ELEMENTS =========
    static func styleRoundImg(img: UIImageView) {
        img.layer.cornerRadius = img.frame.size.width / 2.0
    }
    
    static func styleFilledButton(button: UIButton) {
        button.backgroundColor = UIColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleEmptyButton(button: UIButton) {
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 1)
    }
    
    static func styleTitle(title: UILabel) {
        title.textColor = UIColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 1)
    }
    
    static func styleWinnerLabel(Name: UILabel) {
        Name.textColor = UIColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 1)
    }
    
    static func styleNameLabel(Name: UILabel) {
        Name.textColor = UIColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 1)
    }
    
    static func stlyePicker(picker: UIPickerView) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: picker.frame.height,
                                  width: picker.frame.width, height: 2)
        picker.layer.addSublayer(bottomLine)
    }
    
    static func styleTextField(textfield: UITextField) {
        let bottomLine = CALayer()
        let rect = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height,
                                  width: textfield.frame.width, height: 2)
        
        rect.frame = CGRect(x: 0, y: 0,
                            width: textfield.frame.width, height: textfield.frame.height)
        
        
        bottomLine.backgroundColor = CGColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 1)
        rect.backgroundColor = CGColor.init(red: 114/255, green: 126/255, blue: 228/255, alpha: 0.5)
        
        textfield.borderStyle = .none
        
        textfield.layer.addSublayer(bottomLine)
        textfield.layer.addSublayer(rect)

    }
    
    static func setContinueButton(enabled:Bool, button: UIButton) {
        if enabled {
            button.alpha = 1.0
            button.isEnabled = true
        } else {
            button.alpha = 0.5
            button.isEnabled = false
        }
    }
}
