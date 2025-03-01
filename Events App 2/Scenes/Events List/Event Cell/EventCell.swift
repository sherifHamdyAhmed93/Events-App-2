//
//  EventCell.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 27/02/2025.
//

import UIKit

class EventCell: UITableViewCell {
    
    private var dateLabel:UILabel = UILabel()
    private var remainigTimeLabels:[UILabel] = [UILabel(),UILabel(),UILabel(),UILabel()]
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
        (remainigTimeLabels + [dateLabel,eventNameLabel,eventBackgroundImageView,verticalStackView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        contentView.layer.cornerRadius = 10
        
        remainigTimeLabels.forEach {
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }
        
        dateLabel.font = .systemFont(ofSize: 18, weight: .medium)
        dateLabel.textColor = .white
        
        eventNameLabel.font = .systemFont(ofSize: 28, weight: .bold)
        eventNameLabel.textColor = .white
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
        
        setupHierarchy()
        setupConstriants()
    }
    
    private func setupHierarchy(){
        contentView.addSubview(eventBackgroundImageView)
        contentView.addSubview(verticalStackView)
        
        (remainigTimeLabels + [UIView(),dateLabel]).forEach {
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
        remainigTimeLabels.forEach {
            $0.text = ""
        }
        
        eventNameLabel.text = eventCellModel.eventName
        dateLabel.text = eventCellModel.eventDate
        
        eventCellModel.remainingTime.enumerated().forEach {
            remainigTimeLabels[$0.offset].text = $0.element
        }
        
        eventCellModel.loadEventImage { [weak self] image in
            DispatchQueue.main.async {
                self?.eventBackgroundImageView.image = image
            }
        }
    }
    
}
