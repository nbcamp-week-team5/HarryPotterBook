//
//  UserDefaultService.swift
//  HarryPotterBook
//
//  Created by 최안용 on 3/27/25.
//

import Foundation

final class UserDefaultService {
    private let userDefault = UserDefaults.standard
    
    func save(_ num: Int, _ isExpanded: Bool) {
        userDefault.set(isExpanded, forKey: "\(num)")
    }
    
    func get(_ num: Int) -> Bool {
        return userDefault.bool(forKey: "\(num)")
    }
}
