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

    static let identifier: String = "AddImageViewController"
    let imagePickerController = UIImagePickerController()

    var thisTitle = ""
    var thisContent = ""
    var thisImageData: NSData?

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

        if let imageData = thisImageData {
            self.buttonSelectImage.setImage(UIImage(data: imageData as Data), for: .normal)
        }
        self.textFieldTitle.text = thisTitle
        self.textViewContent.text = thisContent

        self.buttonSelectImage.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        self.buttonDismiss.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.buttonSend.addTarget(self, action: #selector(sendPost), for: .touchUpInside)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotificationObserver()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotificationObserver()
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

        guard let imageData = UIImageJPEGRepresentation(self.buttonSelectImage.image(for: UIControlState.normal)!, 1 ) else {
            return
        }

        addCoreDataArticle(content: self.textViewContent.text, title: self.textFieldTitle.text, imageData: imageData as NSData?)
        appDelegate.saveContext()

        dismiss(animated: true, completion: nil)
    }

    func didTapView(gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    func addNotificationObserver() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) { (notification) in
            self.keyboardWillShow(notification: notification)
        }

        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) { (notification) in
            self.keyboardWillHide(notification: notification)
        }
    }

    func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }

    func keyboardWillShow(notification: Notification) {

        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue )?.cgRectValue else { return }

        self.mainScrollView.contentOffset.y = frame.height
    }

    func keyboardWillHide(notification: Notification) {
        self.mainScrollView.contentOffset.y = 0
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
