//
//  CollectionViewExt.swift
//  CasAngel
//
//  Created by Admin on 03/06/2019.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenuSwift

class BaseViewController: UIViewController {
    var selectedLeague: Int = 2
    var maskView: UIView?
    var animView: NVActivityIndicatorView?
    
    @IBAction open func openMenu(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let sideMenu = appDelegate.window?.rootViewController as! SideMenuController
        sideMenu.revealMenu()
    }
    
    func selectLeague(leagueId: Int) {
        selectedLeague = leagueId
    }
}

extension BaseViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showToast(message : String) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width * 0.2, y: self.view.frame.size.height*0.5, width: self.view.frame.size.width * 0.6, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.1
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showLoadingAnim(alpha: CGFloat = 0, type: Int = 0, showString: String = "") {
        if self.maskView != nil {
            self.maskView!.isHidden = false
            if alpha != 0 {
                animView!.backgroundColor = UIColor.black
                animView!.alpha = alpha
            }else {
                animView!.backgroundColor = UIColor.white
            }
            animView!.startAnimating()
            return
        }
        DispatchQueue.main.async {
            let frame = self.view.frame
            self.maskView = UIView(frame: CGRect.init(x: 0, y: 0, width: frame.width, height: frame.height))
            self.maskView!.backgroundColor = UIColor.white
            if alpha != 0 {
                self.maskView!.backgroundColor = UIColor.black
                self.maskView!.alpha = alpha
            }
            let x = (frame.size.width)/2
            let y = (frame.size.height)/2
            var spinRect = CGRect.init(x: x-30, y: y-20, width: 60, height: 40)
            if showString != "" {
                let label = UILabel.init(frame: CGRect.init(x: x+10, y: y-15, width: 100, height: 30))
                label.text = showString
                label.textColor = .white
                self.maskView!.addSubview(label)
                spinRect = CGRect.init(x: x-60, y: y-20, width: 60, height: 40)
            }
            let spinFrame = spinRect
            var indType = NVActivityIndicatorType.lineScalePulseOut
            if type == 1 {
                indType = .circleStrokeSpin
            }
            self.animView = NVActivityIndicatorView(frame: spinFrame, type: indType, color: UIColor.lightGray, padding: CGFloat.zero)
            self.animView!.startAnimating()
            self.maskView!.addSubview(self.animView!)
            self.view.addSubview(self.maskView!)
        }
    }
    
    func hideLoadingAnim() {
        DispatchQueue.main.async {
            self.maskView!.isHidden = true
            self.animView!.stopAnimating()
        }
    }
}
