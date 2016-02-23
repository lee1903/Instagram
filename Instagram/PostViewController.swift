//
//  PostViewController.swift
//  Instagram
//
//  Created by Brian Lee on 2/23/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var contentImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        captionTextView.delegate = self
        captionTextView.text = "Say something about this picture..."
        captionTextView.textColor = UIColor.lightGrayColor()
        captionTextView.returnKeyType = .Done
        
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            contentImageView.image = editedImage
            
            self.dismissViewControllerAnimated(true) { () -> Void in
            }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if captionTextView.textColor == UIColor.lightGrayColor() {
            captionTextView.text = nil
            captionTextView.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if captionTextView.text.isEmpty {
            captionTextView.text = "Say something about this picture..."
            captionTextView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            captionTextView.resignFirstResponder()
            return false
        }
        return true
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
