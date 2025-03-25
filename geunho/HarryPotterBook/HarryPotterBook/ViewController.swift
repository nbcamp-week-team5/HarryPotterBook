//
//  ViewController.swift
//  HarryPotterBook
//
//  Created by 정근호 on 3/25/25.
//

import UIKit

class ViewController: UIViewController {

    private let dataService = DataService()
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                
                
            case .failure(let error):
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

#Preview {
    ViewController()
}
