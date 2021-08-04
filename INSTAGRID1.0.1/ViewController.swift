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
        // Do any additional setup after loading the view.
    }
    @IBAction func photoTapLoad(_ sender: UIButton) {
        print("Button Click")
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
   
    
    
//     This method will launch the imagePicker when a button is tapped
//        @IBAction func loadImageButtonTapped(_ sender: UIButton) {
//            self.photoButton = sender
//            imagePicker.allowsEditing = true
//            imagePicker.sourceType = .photoLibrary
//            imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
//            present(imagePicker, animated: true, completion: nil)
//        }




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

