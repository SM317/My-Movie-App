//
//  BaseViewController.swift
//  AsianMovieApp
//
//  Created by SourabhMehta on 09/10/19.
//  Copyright © 2019 SourabhMehta. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

   var view_CircularProgress : UIImageView?
   var view_CircularProgressNew : UIImageView?
   var tempView : UIView?
   var view_Bg : UIView?
   var isRotating = false
   var isRotatingNew = false
   var shouldStopRotating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
          NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
      }
      
      
      //MARK: Notification Observer Method
      /**
       * This is a notification observer, comes into action when just before keyboard appears
       *
       */
      @objc func keyboardWillShow(_ notification: Notification) {
      }
      
      //MARK: Notification Observer Method
      /**
       * This is a notification observer, comes into action when just before keyboard appears
       *
       */
      @objc func keyboardWillHide(_ notification: Notification) {
      }
      
      //MARK: Custom Loader Methods
      
      func customLoaderExist () ->Bool {
          if let _ = (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.viewWithTag(1234))
          {
              return true
          }
          return false
      }
      
      /**
       * Showing the custom loader
       */
      func showCustomLoader()
      {
          DispatchQueue.main.async { () -> Void in
              if !self.customLoaderExist()
              {
                  let newView = UIView()
                  newView.frame = UIScreen.main.bounds
                  newView.backgroundColor = UIColor.clear
                  newView.tag = 1234
                  
                  let tempView = UIView()
                  tempView.frame = UIScreen.main.bounds
                  tempView.backgroundColor = UIColor.gray
                  tempView.alpha = 0.4
                  
                  self.view_CircularProgress = UIImageView()
                  self.view_CircularProgress!.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                  self.view_CircularProgress!.center = tempView.center
                  self.view_CircularProgress!.image = UIImage(named: Constants.Images.customLoader)
                  tempView.addSubview(self.view_CircularProgress!)
                  newView.addSubview(tempView)
                  if self.isRotating == false {
                      self.view_CircularProgress!.rotate360Degrees()
                      self.isRotating = true
                  }
                  UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(newView)
              } else {
                  if let _ = self.view_CircularProgress{
                      self.view_CircularProgress!.rotate360Degrees()
                      self.isRotating = true
                  }
                  
              }
          }
          
      }
      
      /**
       * hiding the custom loader
       */
      func hideCustomLoader()
      {
          DispatchQueue.main.async(execute: {
              self.shouldStopRotating = true
              if let _ = self.view_CircularProgress {
                  self.view_CircularProgress?.stop360Rotation()
              }
              if let view2Remove = (UIApplication.shared.keyWindow?.viewWithTag(1234))
              {
                  view2Remove.removeFromSuperview()
              }
              self.isRotating = false
          })
      }
    
    /**
     * showing error in the alert
     * @param strErrorText - text which need to show in alert
     */
    func ShowError(_ strErrorText : String)
    {
        let alertController:UIAlertController = UIAlertController.init(title: "Error", message: strErrorText, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: { (UIAlertAction) -> Void in
            DispatchQueue.main.async { () -> Void in
                alertController.dismiss(animated: true, completion: nil)
            }
        }))
        DispatchQueue.main.async { () -> Void in
            self.present(alertController, animated: true, completion: nil)
        }
    }

}
