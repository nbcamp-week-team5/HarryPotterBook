//
//  SummaryRepository.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/27/25.
//

import Foundation

class SummaryRepository: SummaryRepositoryProtocol {
    func getSummaryFromUserDefaults(_ page: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "isSummaryKey_\(page)")
    }
    
    func setSummaryToUserDefaults(page: Int, value: Bool) {
        UserDefaults.standard.set(value, forKey: "isSummaryKey_\(page)")
    }
}
