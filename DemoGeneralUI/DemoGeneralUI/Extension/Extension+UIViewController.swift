////
////  Extension+UIViewController.swift
////  Hi FPT
////
////  Created by Jenny on 23/07/2021.
////
//
//import UIKit
//
//extension UIPageViewController {
//    var isPagingEnabled: Bool {
//        get {
//            return scrollView?.isScrollEnabled ?? false
//        }
//        set {
//            scrollView?.isScrollEnabled = newValue
//        }
//    }
//    
//    var scrollView: UIScrollView? {
//        return view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
//    }
//    
//}
//extension UIViewController {
//    func topMostViewController() -> UIViewController {
//        var topMostViewController = UIApplication.shared.keyWindow?.rootViewController
//        while let presentedViewController = topMostViewController?.presentedViewController {
//            topMostViewController = presentedViewController
//        }
//        return topMostViewController ?? self
//    }
//    static func view(storyboardName: String, identifier: String) -> UIViewController {
//        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
//        return storyboard.instantiateViewController(withIdentifier: identifier)
//    }
//
//    
//    var isModal: Bool {
//        let presentingIsModal = presentingViewController != nil
//        let presentingIsNavigation = navigationController?.presentingViewController == navigationController
//        let presentinIsTabBar = tabBarController?.presentingViewController is UITabBarController
//        return presentingIsModal || presentingIsNavigation || presentinIsTabBar
//    }
//    
//    /// push view controller check BaseNavigation
//    /// - Parameters:
//    ///   - vc: destination
//    ///   - animated: is animated or not
//    func pushViewControllerHiF(_ vc: UIViewController, animated: Bool) {
//        if self.isKind(of: BaseViewController.self) {
//            (vc as? BaseViewController)?.previousScreenId = String(describing: type(of: self))
//        }else if ( self.isKind(of: MyTabbarController.self)) { //HOME
//            (vc as? BaseViewController)?.previousScreenId = String(describing: type(of: self))
//        }
//        
//        if self.isKind(of: BaseNavigation.self) {
//            if let nav = self as? BaseNavigation {
//                nav.pushViewController(vc, animated: animated)
//            }
//        } else {
//            self.navigationController?.pushViewController(vc, animated: animated)
//        }
//    }
//    
//    /// pop to root view controller check BaseNavigation
//    /// - Parameter animated: is animated or not
//    func popToRootViewControllerHiF(animated: Bool) {
//        if self.isKind(of: BaseNavigation.self) {
//            if let nav = self as? BaseNavigation {
//                nav.popToRootViewController(animated: animated)
//            }
//        } else {
//            self.navigationController?.popToRootViewController(animated: animated)
//        }
//    }
//
//    func showToast(message : String, font: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)) {
//        
//        let termView = UIView()
//        self.view.addSubview(termView)
//        termView.translatesAutoresizingMaskIntoConstraints = false
//        termView.backgroundColor = UIColor(hexString: "#282828").withAlphaComponent(0.75)
//        termView.layer.cornerRadius = 10;
//        let toastLabel = UILabel()
//        toastLabel.backgroundColor = .clear
//        toastLabel.textColor = UIColor.white
//        toastLabel.font = font
//        toastLabel.textAlignment = .center;
//        toastLabel.text = "  " + message + "  "
//        toastLabel.alpha = 1.0
//        toastLabel.layer.cornerRadius = 10;
//        toastLabel.clipsToBounds  =  true
//        toastLabel.numberOfLines = 0
//        
//        termView.addSubview(toastLabel)
//        toastLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            toastLabel.leadingAnchor.constraint(equalTo: termView.leadingAnchor, constant : 12),
//            toastLabel.centerXAnchor.constraint(equalTo: termView.centerXAnchor),
//            toastLabel.topAnchor.constraint(equalTo: termView.topAnchor, constant : 12),
//            toastLabel.bottomAnchor.constraint(equalTo: termView.bottomAnchor, constant : -12),
//        ])
//       
//        NSLayoutConstraint.activate([
//            termView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant : 12),
//            termView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            termView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant : -110),
//        ])
//        
//        
//        UIView.animate(withDuration: 1, delay: 3, options: .curveEaseOut, animations: {
//            termView.alpha = 0.0
//        }, completion: {(isCompleted) in
//            termView.removeFromSuperview()
//        })
//    }
//    
//}
