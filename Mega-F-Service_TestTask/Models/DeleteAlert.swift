//
//  DeleteAlert.swift
//  Mega-F-Service_TestTask
//
//  Created by Сергей Горбачёв on 08.09.2021.
//

import UIKit

class DeleteAlert: UIViewController {
    
    struct Constants {
        static let backgroundAlphaTo: CGFloat = 0.7
    }

    private let scrollView = UIScrollView()
    private var TargetView: UIView?
    
    var buttonAction: ( () -> Void)?
    
    let titleLabel = UILabel()
    
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 20
        return alert
    }()

    func showDeleteAlert(with title: String, on viewController: UIViewController, completion: @escaping () -> Void) {
        
        buttonAction = completion
        
        guard let targetView = viewController.view else { return }
        
        targetView.addSubview(scrollView)
        scrollView.frame = targetView.bounds
        
        TargetView = targetView
        backgroundView.frame = targetView.bounds
        
        scrollView.addSubview(backgroundView)
        scrollView.addSubview(alertView)
        alertView.frame = targetView.bounds
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width-80, height: 200)
        
        let deleteButton = UIButton()
        deleteButton.frame = CGRect(x: alertView.frame.size.width / 2 + 10,
                                    y: alertView.frame.size.height - 65,
                                    width: alertView.frame.size.width / 2 - 20,
                                    height: 40)
        deleteButton.setTitle("УДАЛИТЬ", for: .normal)
        deleteButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        deleteButton.backgroundColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4117647059, alpha: 1)
        deleteButton.layer.cornerRadius = 20
        deleteButton.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        alertView.addSubview(deleteButton)
        
        let cancelButton = UIButton()
        cancelButton.frame = CGRect(x: 10,
                                    y: alertView.frame.size.height - 65,
                                    width: alertView.frame.size.width / 2 - 20,
                                    height: 40)
        cancelButton.setTitle("ОТМЕНА", for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Roboto-Regular", size: 14)
        cancelButton.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7725490196, blue: 0.8117647059, alpha: 1)
        cancelButton.layer.cornerRadius = 20
        cancelButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        alertView.addSubview(cancelButton)
        
        
        titleLabel.frame = CGRect(x: 20,
                                    y: 20,
                                    width: alertView.frame.size.width - 40,
                                    height: alertView.frame.size.height - 100)
        titleLabel.text = "ВЫ ХОТИТЕ УДАЛИТЬ \(title)?"
        titleLabel.font = UIFont(name: "Roboto-Regular", size: 20)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        alertView.addSubview(titleLabel)

        UIView.animate(withDuration: 0.26, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion : { done in
            if done {
                UIView.animate(withDuration: 0.26, animations: {
                    self.alertView.center = CGPoint(x: self.scrollView.frame.midX, y: self.scrollView.frame.midY)
                })
            }
        })
    }
    
    @objc func deleteAction() {
        
        buttonAction?()
        
        guard let targetView = TargetView else { return }
        UIView.animate(withDuration: 0.26, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height + 100, width: targetView.frame.size.width-80, height: 300)
        }, completion : { done in
            if done {
                UIView.animate(withDuration: 0.26, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    self.titleLabel.text = ""
                    self.alertView.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                    self.scrollView.removeFromSuperview()
                })
            }
        })
    }
    
    @objc func dismissAlert() {
        
        guard let targetView = TargetView else { return }
        
        UIView.animate(withDuration: 0.26, animations: {
            self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height + 100, width: targetView.frame.size.width-80, height: 300)
        }, completion : { done in
            if done {
                UIView.animate(withDuration: 0.26, animations: {
                    self.backgroundView.alpha = 0
                }, completion: { done in
                    self.titleLabel.text = ""
                    self.alertView.removeFromSuperview()
                    self.backgroundView.removeFromSuperview()
                    self.scrollView.removeFromSuperview()
                })
            }
        })
    }
}




