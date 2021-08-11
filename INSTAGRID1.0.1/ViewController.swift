//
//  ViewController.swift
//  INSTAGRID1.0.1
//
//  Created by Aurélien Waxin on 27/07/2021.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    var photoButton : UIButton?
    
    var layoutIsEmpty = true // This Boolean will permit to check wether the grid is empty or not before sharing
    let imageSelect = UIImage(named: "Selected")
    let layout1 = UIImage(named: "Layout 1")
    let layout2 = UIImage(named: "Layout 2")
    let layout3 = UIImage(named: "Layout 3")
    
    
    func setBackgroundImage(_: UIImage? , for : UIControl.State ) -> UIImage?{
        return imageSelect
        
    }
    
    
    @IBOutlet var layoutButtons: [UIButton]!
    
    @IBOutlet var photoButtons:[UIButton]!
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }
    @IBAction func photoTapLoad(_ sender: UIButton) {
        print("Button Click")
        self.photoButton = sender
        imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                present(imagePicker, animated: true, completion: nil)
        }
    
    @IBAction func photoTapLoad2(_ sender: UIButton) {
        print("Button Click")
        self.photoButton = sender
        imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                present(imagePicker, animated: true, completion: nil)
        }
    
    
    
    
    @IBAction func photoTapLoad3(_ sender: UIButton) {
        print("Button Click")
        self.photoButton = sender
        imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                present(imagePicker, animated: true, completion: nil)
        }
    
    
    
    @IBAction func photoTapLoad4(_ sender: UIButton) {
        print("Button Click")
        self.photoButton = sender
        imagePicker.allowsEditing = true
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                present(imagePicker, animated: true, completion: nil)
        }
    
    
    
    
    @IBAction func layoutButton3(_ sender: UIButton) {
        print("Layout Button 3 Click")
        highRightButton.isHidden = false
        lowRightButton.isHidden = false
        sender.setBackgroundImage(UIImage(named: "Selected")?.withAlpha(0.5), for: UIControl.State.normal)
        layoutButtons[1].setBackgroundImage(UIImage(named: "Layout 2"), for: UIControl.State.normal)
        layoutButtons[0].setBackgroundImage(UIImage(named: "Layout 1"), for: UIControl.State.normal)
    }
    
    @IBAction func layoutButton2(_ sender: UIButton) {
        print("Layout Button 2 Click")
        highRightButton.isHidden = true
        lowRightButton.isHidden = false
        sender.setBackgroundImage(UIImage(named: "Selected")?.withAlpha(0.5), for: UIControl.State.normal)
        layoutButtons[1].setBackgroundImage(UIImage(named: "Layout 2"), for: UIControl.State.normal)
        layoutButtons[2].setBackgroundImage(UIImage(named: "Layout 3"), for: UIControl.State.normal)
        
    }
    
    @IBAction func layoutButton(_ sender: UIButton) {
        print("Layout Button Click")
        lowRightButton.isHidden = true
        highRightButton.isHidden = false
        sender.setBackgroundImage(UIImage(named: "Selected")?.withAlpha(0.5), for: UIControl.State.normal)
        layoutButtons[0].setBackgroundImage(UIImage(named: "Layout 1"), for: UIControl.State.normal)
        layoutButtons[2].setBackgroundImage(UIImage(named: "Layout 3"), for: UIControl.State.normal)
        
    }
    
    @IBOutlet weak var highRightButton: UIButton!
    @IBOutlet weak var lowRightButton: UIButton!
   
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer?) {
        if let gesture = sender {
            if UIDevice.current.orientation.isPortrait && gesture.direction == .up {
                moveMainViewUp()
            } else if UIDevice.current.orientation.isLandscape && gesture.direction == .left {
                moveMainViewLeft()
            }
        }
    }
    
    func moveMainViewUp() {
                 UIView.animate(withDuration: 2, animations: {
                     self.blueView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
                 }, completion: {
                     (true) in
                     self.checkLayout()
                 })
             }
             func moveMainViewLeft() {
                 UIView.animate(withDuration: 2, animations: {
                     self.blueView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
                 }, completion: {
                     (true) in
                     self.checkLayout()
                 })
             }

    
    // This function will present an alert if the user tries to share an empty grid
         func checkLayout() {
             let alert = UIAlertController(title: "Empty Grid", message: "Are you sure you want to share an empty grid ?", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                 self.shareLayout() } ))
             alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                 self.blueView.transform = .identity
             }))
             if layoutIsEmpty == true {
                 self.present(alert, animated: true)
             } else {
                 shareLayout()
             }
         }
    
    
    func shareLayout() {
              let content = blueView.asImage()
              let activityController = UIActivityViewController(activityItems: [content], applicationActivities: nil)
              self.present(activityController, animated: true, completion: nil)
              // We use the completion handler to move back the mainView when the activityController is closed
              activityController.completionWithItemsHandler = {  (activity, success, items, error) in
                  UIView.animate(withDuration: 1, animations: {
                      self.blueView.transform = .identity
                  }, completion: nil)
              }
          }
    
    
    
    
    
    
    
    
    
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.photoButton?.setImage(pickedImage, for: UIControl.State.normal)
                //layoutIsEmpty = false
            }
            dismiss(animated: true, completion: nil)
        }
    
    

        // METHOD FOR THE DELEGATE: when the user cancels image picking
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
}




    // This UIView extension will permit to convert our MainView to an image file
    extension UIView {
        func asImage() -> UIImage {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        }
    }

extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}

