//
//  EventListVM.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import Foundation

class EventListViewModel{
    
    private let coordinator:EventListCoordinator
    var onUpdate = {}
    
    enum Cell{
        case event(EventCellViewModel)
    }
    
    private(set) var cells:[Cell] = []
    
    init(coordinator:EventListCoordinator){
        self.coordinator = coordinator
    }
    
    func viewDidLoad(){
        reloadData()
    }
    
    func reloadData(){
        let events = CoreDataManager.shared.fetchEvents()
        cells = events.map({
            let eventCellViewModel = EventCellViewModel(event: $0)
            eventCellViewModel.onSelect = { [weak self] id in
                self?.coordinator.didSelectEvent(eventId: id)
            }
            return Cell.event(eventCellViewModel)
        })
        onUpdate()
    }
    
    func tappedAddEvent(){
        print("Pllus tabbed")
        coordinator.startAddEvent()
    }
    
    func numberOfRows()->Int{
        return cells.count
    }
    
    func cellForRow(at indexPath:IndexPath)->Cell{
        return cells[indexPath.row]
    }
    
    func didSelectRow(at indexpath:IndexPath){
        switch cells[indexpath.row]{
        case .event(let eventCellVM):
            eventCellVM.selectEvent()
        }
    }
    
}
