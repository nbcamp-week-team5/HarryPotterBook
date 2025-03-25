//
//  UIStackView+.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/25/25.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: UIView...) {
        views.forEach {
            self.addArrangedSubview($0)
        }
    }
}
