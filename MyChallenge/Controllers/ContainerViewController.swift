//
//  ContainerViewController.swift
//  goal2.0
//
//  Created by Антон Ермолов on 14.09.2021.
//

import UIKit

final class ContainerViewController: UIViewController, MainViewControllerDelegate {
    
    //MARK: - variables
    private var mainViewController: UIViewController!
    private var menuViewController: UIViewController!
    private var isMove = false
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainViewController()
    }
    
    //MARK: - functions
    private func configureMainViewController() {
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
        viewController.delegate = self
        mainViewController = viewController
        addChild(mainViewController)
        view.addSubview(mainViewController.view)
        mainViewController.didMove(toParent: self)
    }
    
    private func configureMenuViewController() {
        menuViewController = MenuViewController()
        addChild(menuViewController)
        view.insertSubview(menuViewController.view, at: 0)
        menuViewController.didMove(toParent: self)
        //print("Добавили menuViewController")
    }
    
    private func showMenuViewController(shouldMove: Bool) {
        if shouldMove {
            // показываем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.mainViewController.view.frame.origin.x = self.mainViewController.view.frame.width - 140
                           }) { (finished) in
                
            }
        } else {
            // убираем menu
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.mainViewController.view.frame.origin.x = 0
                           }) { (finished) in
                
                self.menuViewController.remove()
                //print("Удалили menuViewController")
            }
        }
    }
    
    // MARK: MainViewControllerDelegate
    func toggleMenu() {
        if !isMove {
            configureMenuViewController()
        }
        isMove = !isMove
        showMenuViewController(shouldMove: isMove)
    }
}

//MARK: - extension
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
