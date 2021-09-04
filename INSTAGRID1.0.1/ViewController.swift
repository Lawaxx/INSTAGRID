//
//  ViewController.swift
//  INSTAGRID1.0.1
//
//  Created by Aurélien Waxin on 27/07/2021.
//

import UIKit


final class ViewController: UIViewController {
    
    private let imagePicker = UIImagePickerController()
    private var photoButton : UIButton?
    private var gridIsEmpty = true // This Boolean will permit to check wether the grid is empty or not before sharing
    
    private let imageSelect = UIImage(named: "Selected")
    private let layout1 = UIImage(named: "Layout 1")
    private let layout2 = UIImage(named: "Layout 2")
    private let layout3 = UIImage(named: "Layout 3")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view!.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view!.addGestureRecognizer(swipeUp)
    }
    
    
    //     Function Swipe&Share
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.left && UIApplication.shared.statusBarOrientation.isLandscape {
            print("Swipe Left")
            moveMainViewLeft()
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.up && UIApplication.shared.statusBarOrientation.isPortrait {
            print("Swipe Up")
            moveMainViewUp()
        }
    }
    
    @IBOutlet weak var swipeText: UILabel!
    @IBOutlet weak var swipeArrow: UIButton!
    
    
    @IBOutlet var layoutButtons: [UIButton]!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var highRightButton: UIButton!
    @IBOutlet weak var lowRightButton: UIButton!
    
    
    // Saw if the view is Landscape or Portrait
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.swipeText.text = "Swipe left to share"
                self.swipeArrow.transform = CGAffineTransform(rotationAngle: 30)
                // activate landscape changes
            } else {
                self.swipeText.text = "Swipe up to share"
                self.swipeArrow.transform = CGAffineTransform(rotationAngle: 0)
                // activate portrait changes
            }
        })
    }
    
    // Function for adding picture to photo buttons
    @IBAction func presentImagePicker(from sender: UIButton) {
        print("Button Click")
        self.photoButton = sender
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    // Function for change grid layout and set a "selected" image to background
    @IBAction func changeLayout(_ sender : UIButton) {
        sender.setBackgroundImage(UIImage(named: "Selected"), for: UIControl.State.normal)
        
        switch sender {
        
        case layoutButtons[0] :
            highRightButton.isHidden = true
            lowRightButton.isHidden = false
            sender.setBackgroundImage(UIImage(named: "Selected")?.withAlpha(0.5), for: UIControl.State.normal)
            layoutButtons[1].setBackgroundImage(UIImage(named: "Layout 2"), for: UIControl.State.normal)
            layoutButtons[2].setBackgroundImage(UIImage(named: "Layout 3"), for: UIControl.State.normal)
            
        case layoutButtons[1] :
            lowRightButton.isHidden = true
            highRightButton.isHidden = false
            sender.setBackgroundImage(UIImage(named: "Selected")?.withAlpha(0.5), for: UIControl.State.normal)
            layoutButtons[0].setBackgroundImage(UIImage(named: "Layout 1"), for: UIControl.State.normal)
            layoutButtons[2].setBackgroundImage(UIImage(named: "Layout 3"), for: UIControl.State.normal)
            
        case layoutButtons[2] :
            highRightButton.isHidden = false
            lowRightButton.isHidden = false
            sender.setBackgroundImage(UIImage(named: "Selected")?.withAlpha(0.5), for: UIControl.State.normal)
            layoutButtons[1].setBackgroundImage(UIImage(named: "Layout 2"), for: UIControl.State.normal)
            layoutButtons[0].setBackgroundImage(UIImage(named: "Layout 1"), for: UIControl.State.normal)
            
        default :
            return
            
        }
    }
    
    
    // Function for animate UP the GridView to share / Check if is empty / Share if good
    private func moveMainViewUp() {
        UIView.animate(withDuration: 1, animations: {
            self.blueView.transform = CGAffineTransform(translationX: 0, y: -UIScreen.main.bounds.height)
        }, completion: {
            (true) in
            self.checkLayout()
        })
    }
    
    // Function for animate left the GridView to share / Check if is empty / Share if good
    private func moveMainViewLeft() {
        UIView.animate(withDuration: 1, animations: {
            self.blueView.transform = CGAffineTransform(translationX: -UIScreen.main.bounds.width, y: 0)
        }, completion: {
            (true) in
            self.checkLayout()
        })
    }
    
    
    // This function will present an alert if the user tries to share an empty grid
    private func checkLayout() {
        let alert = UIAlertController(title: "Empty Grid", message: "Are you sure you want to share an empty grid ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                                        self.shareLayout() } ))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
                                        UIView.animate(withDuration: 1, animations: {
                                            self.blueView.transform = .identity
                                        }
                                        )}))
        if gridIsEmpty == true {
            self.present(alert, animated: true)
        } else {
            shareLayout()
        }
    }
    
    
    // This function open the Activity Controller to share the grid with animation
    private func shareLayout() {
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
    
    
    // Function to set a " Selected " background image to layout choice
    private func setBackgroundImage(_: UIImage? , for : UIControl.State ) -> UIImage?{
        return imageSelect
    }
    
}




//MARK: EXTENSION


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



extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // METHOD FOR THE DELEGATE: when the user cancels image picking
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Function to add picture at photobutton
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.photoButton?.setImage(pickedImage, for: UIControl.State.normal)
            gridIsEmpty = false
        }
        dismiss(animated: true, completion: nil)
    }
}

