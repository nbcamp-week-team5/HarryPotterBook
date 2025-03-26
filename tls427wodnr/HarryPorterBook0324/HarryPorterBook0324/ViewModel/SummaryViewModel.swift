//
//  SummaryViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

import Foundation

class SummaryViewModel {
    private let pageVM: PageViewModel
    private let bookVM: BookViewModel

    init(pageVM: PageViewModel, bookVM: BookViewModel) {
        self.pageVM = pageVM
        self.bookVM = bookVM
    }
    
    private let isSummaryKeys: [String] = ["isSummaryKey_0","isSummaryKey_1","isSummaryKey_2","isSummaryKey_3","isSummaryKey_4","isSummaryKey_5","isSummaryKey_6"]
    
    private var isSummarys: [Bool] = Array(repeating: false, count: 7)
    
    func currentSummaryButtonTitle() -> String {
        return isSummarys[pageVM.getPage()] ? "더 보기" : "접기"
    }
    
    func toggleSummaryState() {
        isSummarys[pageVM.getPage()] = !isSummarys[pageVM.getPage()]
        UserDefaults.standard.set(isSummarys[pageVM.getPage()], forKey: isSummaryKeys[pageVM.getPage()])
    }
    
    func getSummaryState() {
        isSummarys[pageVM.getPage()] = UserDefaults.standard.bool(forKey: isSummaryKeys[pageVM.getPage()])
    }
    
    func formatSummary() -> String {
        let summary = bookVM.getBookSummary()
        let limit = 450
        if summary.count >= limit, isSummarys[pageVM.getPage()] == true {
            let index = summary.index(summary.startIndex, offsetBy: limit)
            let formated = String(summary[..<index]) + "..."
            return formated
        }
        return summary
    }
}
