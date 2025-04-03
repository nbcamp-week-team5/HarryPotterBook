//
//  PageStateProtocol.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 4/1/25.
//

protocol PageStateProtocol: AnyObject {
    var onPageUpdated: (() -> Void)? { get set }
    func getPage() -> Int
    func setPage(_ value: Int)
}
