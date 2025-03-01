//
//  ImagePickerCoordinator.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 25/02/2025.
//

import UIKit

final class ImagePickerCoordinator:NSObject,Coordinator{
    private(set) var childCoordinators: [Coordinator] = []
    private var navigationController:UINavigationController
    var parentCoordinator:AddEventCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        navigationController.present(imagePickerController, animated: true)
    }
    
    
}
extension ImagePickerCoordinator :  UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage{
            parentCoordinator?.didPickImage(image: image)
        }
        parentCoordinator?.didFinishPickingImage(coordinator: self)
    }
}
