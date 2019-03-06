//
//  Picker_Delegate + LocationDetailViewController.swift
//  TestTaskCrassula
//
//  Created by Oleg Soloviev on 06.03.2019.
//  Copyright © 2019 varton. All rights reserved.
//

import UIKit

extension UserLocationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func showPhotoMenu() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let actCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actCancel)
        let actPhoto = UIAlertAction(title: "Take Photo", style: .default, handler: { [unowned self] _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.takePhotoWithCamera()
            }
        })
        alert.addAction(actPhoto)
        let actLibrary = UIAlertAction(title: "Choose From Library", style: .default, handler: { [unowned self] _ in
            self.choosePhotoFromLibrary()
        })
        alert.addAction(actLibrary)
        present(alert, animated: true, completion: nil)
    }
    
    private func takePhotoWithCamera() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    private func choosePhotoFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.view.tintColor = view.tintColor
        present(imagePicker, animated: true)
    }
    
    // MARK: - Image Picker Delegates
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            adapter.items.append(image)
            collectionView.reloadData()
            if collectionView.isHidden {
                collectionView.isHidden = false
                collectionConstraint.constant = 79
            }

        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
