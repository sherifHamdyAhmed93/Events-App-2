//
//  AddEventVC.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import UIKit

class AddEventVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let vm:AddEventViewModel
    
    init(vm: AddEventViewModel) {
        self.vm = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        vm.onUpdate = {[weak self] in
            self?.tableView.reloadData()
        }
        vm.viewDidLoad()
    }
    
    private func setupSubviews(){
        self.navigationItem.title = vm.title
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationItem.rightBarButtonItem?.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(CGPoint(x: 0, y: -1), animated: false)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: TitleSubtitleCell.cellIdentifier)
        tableView.tableFooterView = UIView()
    }

    @objc private func tappedDone(){
        debugPrint("Tap on Done")
        vm.doneTapped()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        vm.viewDidDisappear()
    }
    
    deinit{
        debugPrint("Deinit \(self.description)")
    }

}

extension AddEventVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = vm.cellFor(at: indexPath)
        switch cell {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleCell.cellIdentifier, for: indexPath) as! TitleSubtitleCell
            cell.configure(viewModel: titleSubtitleCellViewModel)
            cell.textField.delegate = self
            return cell
        }
    }
    
}

extension AddEventVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm.didSelectCell(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension AddEventVC:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else{return false}
        let newText = text + string
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point){
            vm.updateSubtitle(for: indexPath, subtitle: newText)
            return true
        }
        return false
    }
}
