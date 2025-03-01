//
//  AddEventVM.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import Foundation

class AddEventViewModel{
    
    private weak var coordinator:AddEventCoordinator?
    private let cellBuilder:EventCellBuilder

    let title = "Add Event"
    
    enum Cell{
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private var nameTitleSubtitleCell: TitleSubtitleCellViewModel?
    private var dateTitleSubtitleCell: TitleSubtitleCellViewModel?
    private var ImageTitleSubtitleCell: TitleSubtitleCellViewModel?

    private(set) var cells:[AddEventViewModel.Cell] = []
    var onUpdate:(()->Void) = {}
    
    lazy private var dateFormatter:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyy"
        return formatter
    }()
    
    init(coordinator:AddEventCoordinator,cellBuilder:EventCellBuilder){
        self.coordinator = coordinator
        self.cellBuilder = cellBuilder
    }
    
    func viewDidLoad(){
        setupCells()
        onUpdate()
    }
    
    func numberOfRows()->Int{
        return cells.count
    }
    
    func cellFor(at indexPath:IndexPath)->Cell{
        return cells[indexPath.row]
    }
    
    func updateSubtitle(for indexPath:IndexPath,subtitle:String){
        let cell = cells[indexPath.row]
        switch cell{
        case .titleSubtitle(let titleSubtitleViewModel):
            titleSubtitleViewModel.updateSubtitle(subtitle)
        }
    }
    
    func doneTapped(){
        guard let name = nameTitleSubtitleCell?.subtitle , let dateString = dateTitleSubtitleCell?.subtitle , let image = ImageTitleSubtitleCell?.image , let date = dateFormatter.date(from: dateString) else{
            return
        }
        debugPrint(name,date)
        CoreDataManager.shared.saveEvent(name: name, date: date, image: image)
        coordinator?.didFinishSaveEvent()
    }
    
    func viewDidDisappear(){
        coordinator?.didFinish()
    }
    
    deinit{
        debugPrint("Deinit \(self)")
    }
    
    func didSelectCell(at indexPath:IndexPath){
        let cellViewModel = self.cellFor(at: indexPath)
        switch cellViewModel {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else{
                return
            }
            coordinator?.openImagePicker(completion: {image in
                titleSubtitleCellViewModel.updateImage(image)
            })
        }
    }
    
}

extension AddEventViewModel{
    private func setupCells(){
        nameTitleSubtitleCell = cellBuilder.buildCell(.text)
        dateTitleSubtitleCell = cellBuilder.buildCell(.date, onUpdateCell: {[weak self] in
            self?.onUpdate()
        })
        
        ImageTitleSubtitleCell = cellBuilder.buildCell(.image, onUpdateCell: {[weak self] in
            self?.onUpdate()
        })
        
        guard let nameTitleSubtitleCell , let dateTitleSubtitleCell , let ImageTitleSubtitleCell else{
            return
        }
        
        cells = [
            Cell.titleSubtitle(nameTitleSubtitleCell),
            Cell.titleSubtitle(dateTitleSubtitleCell),
            Cell.titleSubtitle(ImageTitleSubtitleCell),
        ]
    }
}
