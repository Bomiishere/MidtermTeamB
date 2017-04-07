//
//  AddImageViewController.swift
//  MidtermTeamB
//
//  Created by Chien on 2017/4/7.
//  Copyright © 2017年 Chien. All rights reserved.
//

import UIKit

class AddImageViewController: UIViewController {

    @IBOutlet weak var mainScrollView: UIScrollView!

    @IBOutlet weak var buttonDismiss: UIButton!
    @IBOutlet weak var buttonSelectImage: UIButton!

    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textViewContent: UITextView!
    @IBOutlet weak var buttonSend: UIButton!

    let imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // Image Picker
        self.imagePickerController.delegate = self
        self.imagePickerController.allowsEditing = true

        self.buttonSelectImage.imageView?.tintColor = .white
        self.buttonDismiss.imageView?.tintColor = .white

        // 要Set title , 如果沒有東西是 Save , 如果有是 Update
        self.buttonSend.layer.cornerRadius = 22
        self.buttonSend.clipsToBounds = true

        self.buttonSelectImage.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        self.buttonDismiss.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.buttonSend.addTarget(self, action: #selector(sendPost), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    func selectImage() {
        print("Select photo")
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        } else {
            print("Photo Library is not available")
        }
    }

    func goBack() {
        print("Dismiss")
        dismiss(animated: true, completion: nil)
    }

    func sendPost() {
        print("Send")
        dismiss(animated: true, completion: nil)
    }

    func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - Image Picker Setting
extension AddImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        self.buttonSelectImage.imageView?.contentMode = .scaleAspectFill
        self.buttonSelectImage.setImage(image, for: UIControlState.normal)
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
