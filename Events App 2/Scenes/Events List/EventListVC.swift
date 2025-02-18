//
//  EventListVC.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import UIKit

class EventListVC: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    private func setupSubviews(){
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let rightBarItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tappedPlusIcon))
        rightBarItem.tintColor =  .primaryColor
        navigationItem.rightBarButtonItem = rightBarItem
        
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tappedPlusIcon(){
        print("Pllus tabbed")
    }

}
