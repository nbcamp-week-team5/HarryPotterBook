//
//  SummaryRepository.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/27/25.
//

import Foundation

class SummaryRepository: SummaryRepositoryProtocol {
    private let isSummaryKeys: [String] = (0..<7).map { "isSummaryKey_\($0)" }
    
    func getSummaryFromUserDefaults(_ page: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: isSummaryKeys[page])
    }
    
    func setSummaryToUserDefaults(page: Int, value: Bool) {
        UserDefaults.standard.set(value, forKey: isSummaryKeys[page])
    }
}
