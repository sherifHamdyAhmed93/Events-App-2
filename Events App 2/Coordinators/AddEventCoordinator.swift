//
//  AddEventCoordinator.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import Foundation
import UIKit

final class AddEventCoordinator : Coordinator{
    var childCoordinators: [Coordinator] = []
    private let navigationController:UINavigationController
    var parentCoordinator:EventListCoordinator?
    private var modalNavigationController : UINavigationController?
    private var completion:((_ image:UIImage)->Void)?
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let addEventVM = AddEventViewModel(coordinator: self, cellBuilder: EventCellBuilder())
        let addEventVC = AddEventVC(vm: addEventVM)
        modalNavigationController  = UINavigationController(rootViewController: addEventVC)
        
        if let modalNavigationController{
            navigationController.present(modalNavigationController, animated: true)
        }
    }
    
    func didFinishSaveEvent(){
        parentCoordinator?.OnSaveEvent()
        navigationController.dismiss(animated: true)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
    
    func openImagePicker(completion:@escaping (_ image:UIImage)->()){
        guard let modalNavigationController else{return}
        self.completion = completion
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didPickImage(image:UIImage){
        completion?(image)
        completion = nil
    }
    
    func didFinishPickingImage(coordinator:Coordinator){
        childDidFinish(childCoordinator: coordinator)
        if let modalNavigationController{
            modalNavigationController.dismiss(animated: true)
        }
    }
    
    func childDidFinish(childCoordinator:Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === childCoordinator
        }){
            self.childCoordinators.remove(at: index)
        }
    }
    
    deinit{
        debugPrint("Deinit \(self)")
    }
}

