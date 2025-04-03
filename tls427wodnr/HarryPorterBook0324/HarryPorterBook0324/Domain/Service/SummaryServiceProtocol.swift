//
//  SummaryServiceProtocol.swift
//  HarryPorterBook0324
//
//  Created by tlswo on 4/1/25.
//

protocol SummaryServiceProtocol: AnyObject {
    func currentSummaryButtonTitle(page: Int) -> String
    func toggleSummaryState(page: Int)
    func getSummaryState(page: Int)
    func formatSummary(summary: String, page: Int) -> String
}
