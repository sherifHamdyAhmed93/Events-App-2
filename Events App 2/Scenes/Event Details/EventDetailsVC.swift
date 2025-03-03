//
//  EventDetailsVC.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import UIKit

class EventDetailsVC: UIViewController {
    
    @IBOutlet weak var eventBackgroundImageView:UIImageView!
    @IBOutlet weak var timeRemainingStackView:TimeRemainingStackView!

    private var viewModel:EventDetailsViewModel
    
    init(viewModel: EventDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        timeRemainingStackView.setup()
        
        viewModel.onUpdate = { [weak self] in
            guard let self else{return}
            if let timeRemaingViewModel = self.viewModel.timeRemaingViewModel{
                timeRemainingStackView.setData(timeRemainingViewModel: timeRemaingViewModel)
            }
            
            self.viewModel.loadEventImage { [weak self] image in
                self?.eventBackgroundImageView.image = image
            }
        }
        
        viewModel.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.viewWillDisappear()
    }
    
    deinit{
        debugPrint("Deinit \(self.description)")
    }

}
