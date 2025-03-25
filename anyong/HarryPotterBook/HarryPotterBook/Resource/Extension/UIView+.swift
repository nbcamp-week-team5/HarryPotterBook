//
//  UIView+.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/24/25.
//

import UIKit

extension UIView {
    func addsubViews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
        }
    }
}
