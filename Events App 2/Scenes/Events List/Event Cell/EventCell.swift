//
//  EventCell.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 27/02/2025.
//

import UIKit

class EventCell: UITableViewCell {
    
    private var dateLabel:UILabel = UILabel()
    private var timeRemainingStackView = TimeRemainingStackView()
    private var eventBackgroundImageView:UIImageView = UIImageView()
    private var eventNameLabel:UILabel = UILabel()
    private var verticalStackView:UIStackView = UIStackView()


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(){
        timeRemainingStackView.setup()
        
        [dateLabel,eventNameLabel,eventBackgroundImageView,verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        contentView.layer.cornerRadius = 10
        
        dateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        dateLabel.textColor = .white
        
        eventNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        eventNameLabel.textColor = .white
        
        verticalStackView.alignment = .trailing
        verticalStackView.axis  = .vertical
                
        setupHierarchy()
        setupConstriants()
    }
    
    private func setupHierarchy(){
        contentView.addSubview(eventBackgroundImageView)
        contentView.addSubview(verticalStackView)
        
        [timeRemainingStackView,UIView(),dateLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(eventNameLabel)
    }
    
    private func setupConstriants(){
        eventBackgroundImageView.pinSubviewsToSuperView(edges: [.top,.left,.right])
        let bottomConstraint = eventBackgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        
        
        eventBackgroundImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        verticalStackView.pinSubviewsToSuperView(edges: [.top,.bottom,.right], constant: 15)
        
        eventNameLabel.pinSubviewsToSuperView(edges: [.left,.bottom], constant: 15)
    }
    
    func configureCellData(eventCellModel:EventCellViewModel){
        if let timeRemaingViewModel = eventCellModel.timeRemaingViewModel{
            timeRemainingStackView.setData(timeRemainingViewModel: timeRemaingViewModel)
        }
        
        eventNameLabel.text = eventCellModel.eventName
        dateLabel.text = eventCellModel.eventDate
        
        
        eventCellModel.loadEventImage { [weak self] image in
            DispatchQueue.main.async {
                self?.eventBackgroundImageView.image = image
            }
        }
    }
    
}
