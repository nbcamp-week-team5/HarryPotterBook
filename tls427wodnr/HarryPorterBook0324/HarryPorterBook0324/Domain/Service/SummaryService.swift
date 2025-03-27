//
//  SummaryViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import Foundation

class SummaryService {
    
    private let isSummaryKeys: [String] = ["isSummaryKey_0","isSummaryKey_1","isSummaryKey_2","isSummaryKey_3","isSummaryKey_4","isSummaryKey_5","isSummaryKey_6"]
    
    private var isSummarys: [Bool] = Array(repeating: false, count: 7)
    
    func currentSummaryButtonTitle(page: Int) -> String {
        return isSummarys[page] ? "더 보기" : "접기"
    }
    
    func toggleSummaryState(page: Int) {
        isSummarys[page] = !isSummarys[page]
        UserDefaults.standard.set(isSummarys[page], forKey: isSummaryKeys[page])
    }
    
    func getSummaryState(page: Int) {
        isSummarys[page] = UserDefaults.standard.bool(forKey: isSummaryKeys[page])
    }
    
    func formatSummary(summary: String, page: Int) -> String {
        let limit = 450
        if summary.count >= limit, isSummarys[page] == true {
            let index = summary.index(summary.startIndex, offsetBy: limit)
            let formated = String(summary[..<index]) + "..."
            return formated
        }
        return summary
    }
}
