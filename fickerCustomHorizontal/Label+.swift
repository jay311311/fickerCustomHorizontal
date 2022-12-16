//
//  Label+.swift
//  fickerCustomHorizontal
//
//  Created by Jooeun Kim on 2022/12/15.
//

import UIKit

extension UILabel {
    func textConfigure(color: UIColor, size: CGFloat, weight: UIFont.Weight) -> Self {
        let _ = getTextColor(color)
        let _ = getFontSetting(size: size, weight: weight)
        return self
    }

    func getTextColor(_ color: UIColor) -> Self {
        self.textColor = color
        return self
    }

    func getFontSetting(size: CGFloat, weight: UIFont.Weight) -> Self {
        self.font = .systemFont(ofSize: size, weight: weight)
        return self
    }
}
