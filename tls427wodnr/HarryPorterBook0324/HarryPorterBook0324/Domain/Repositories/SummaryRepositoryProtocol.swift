//
//  Su.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 4/1/25.
//

protocol SummaryRepositoryProtocol: AnyObject {
    func getSummaryFromUserDefaults(_ page: Int) -> Bool
    func setSummaryToUserDefaults(page: Int, value: Bool)
}
