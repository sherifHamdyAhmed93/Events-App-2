//
//  EventListVC.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import UIKit

class EventListVC: UIViewController {
    
    @IBOutlet private weak var tableView:UITableView!
    

    private let vm:EventListViewModel
    
    init(vm: EventListViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        bindViewModel()
        vm.viewDidLoad()
    }
    
    private func bindViewModel(){
        vm.onUpdate = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupSubviews(){
        setupPlusButtonAndTitle()
        setupTableView()
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(EventCell.self, forCellReuseIdentifier: "EventCell")
    }
    
    private func setupPlusButtonAndTitle(){
        let plusImage = UIImage(systemName: "plus.circle.fill")
        let rightBarItem = UIBarButtonItem(image: plusImage, style: .plain, target: self, action: #selector(tapPlusButton))
        rightBarItem.tintColor =  .primaryColor
        navigationItem.rightBarButtonItem = rightBarItem
        
        navigationItem.title = "Events"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc private func tapPlusButton(){
        vm.tappedAddEvent()
    }

}

extension EventListVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = vm.cellForRow(at: indexPath)
        switch cell {
        case .event(let eventCellViewModel):
            let eventCell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
            eventCell.configureCellData(eventCellModel: eventCellViewModel)
            return eventCell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows()
    }
    
    
}

extension EventListVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.didSelectRow(at: indexPath)
    }
}
