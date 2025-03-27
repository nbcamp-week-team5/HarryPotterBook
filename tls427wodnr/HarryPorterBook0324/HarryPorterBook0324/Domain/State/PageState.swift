//
//  PageViewModel.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 3/26/25.
//

class PageState {
    var onPageUpdated: (() -> Void)?
    
    private var page = 0 {
        didSet {
            onPageUpdated?()
        }
    }
    
    func getPage() -> Int {
        return page
    }
    
    func setPage(_ value: Int) {
        page = value
    }
}
