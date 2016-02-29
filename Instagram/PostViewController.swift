//
//  PostViewController.swift
//  Instagram
//
//  Created by Brian Lee on 2/23/16.
//  Copyright © 2016 brianlee. All rights reserved.
//

import UIKit

let userDidPostNotification = "userDidPostNotification"

class PostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var setImageButton: UIButton!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var contentImageView: UIImageView!
    
    var toSelectImage = false

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
    
    override func viewWillAppear(animated: Bool) {
        if contentImageView.image != nil{
            setImageButton.hidden = true
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if toSelectImage == true{
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }

    @IBAction func onSubmit(sender: AnyObject) {
        var caption: String
        if captionTextView.text == nil{
            caption = ""
        } else{
            caption = captionTextView.text!
        }
        if contentImageView.image != nil{
            UserMedia.postUserImage(contentImageView.image!, withCaption: caption) { (sucess,error) -> Void in
                if let error = error{
                    print("post unsuccessful")
                    print(error.localizedDescription)
                }else{
                    print("post successful")
                    NSNotificationCenter.defaultCenter().postNotificationName(userDidPostNotification, object: nil)
                    self.toSelectImage = true
                }
            }
        } else{
            let alert = UIAlertController(title: "Error", message: "You must select a picture to submit", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onSetImage(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(vc, animated: true, completion: nil)
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
