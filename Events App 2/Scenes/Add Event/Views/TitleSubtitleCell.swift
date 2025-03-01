//
//  TitleSubtitleCell.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 20/02/2025.
//

import UIKit

class TitleSubtitleCell:UITableViewCell{
    static let cellIdentifier:String = "titleSubtitleCell"
    
    private let constant:CGFloat = 10

    private var titleLabel = UILabel()
    var textField = UITextField()
    private var eventImageView = UIImageView()
    private var stackview = UIStackView()
    
    private let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    private let dataPicker = UIDatePicker()
    private lazy var doneButton = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }()
    
    private var viewModel:TitleSubtitleCellViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupSubviews()
    }
    
    private func setupSubviews(){
        contentView.addSubview(stackview)
        stackview.axis = .vertical
        stackview.spacing = 5
        
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(textField)
        stackview.addArrangedSubview(eventImageView)

        eventImageView.backgroundColor = .black.withAlphaComponent(0.4)
        eventImageView.layer.cornerRadius = 7
        
        [titleLabel,textField,stackview,eventImageView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        dataPicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            dataPicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        textField.font = .systemFont(ofSize: 18,weight: .regular)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate(
            [
                stackview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: constant),
                stackview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: constant),
                stackview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -constant),
                stackview.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -constant),

            ]
        )
        
        eventImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func configure(viewModel:TitleSubtitleCellViewModel){
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        textField.placeholder = viewModel.placeholder
        textField.text = viewModel.subtitle
        textField.isHidden = viewModel.type == .image
        eventImageView.isHidden = viewModel.type != .image
        stackview.spacing = viewModel.type == .image ? 10 : 5
        
        textField.inputView = viewModel.type == .text ? nil : dataPicker
        textField.inputAccessoryView = viewModel.type == .text ? nil : toolBar
        eventImageView.image = viewModel.image
        toolBar.items = [doneButton]
    }
    
    @objc private func doneTapped(){
        viewModel?.updateDate(dataPicker.date)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
