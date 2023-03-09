//
//  BasePresentVC.swift
//  Hi FPT
//
//  Created by Trinh Quang Hiep on 03/11/2022.
//

import UIKit

extension UIView{
    enum TransitionAnimationPopupType{
        case ShowBottomTop
        case HideBottomTop

        case HideLeftToRight
        case ShowRightToLeft
        
    }
    func showHidePopup(background : UIView, animationType : TransitionAnimationPopupType, timeDuration : Double = 0.3){
        UIView.animate(withDuration: timeDuration, delay: 0,
                       options: [.curveEaseInOut, .transitionCrossDissolve], animations: {
            switch animationType {
            case .ShowBottomTop:
                self.frame.origin.y -= self.bounds.height
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            case .HideBottomTop:
                self.frame.origin.y += self.bounds.height
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
            case .ShowRightToLeft:
                self.frame.origin.x -= self.bounds.width
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            case .HideLeftToRight: // Hidden not word in iOS >= 15...
                self.frame.origin.x += self.bounds.width //UIScreen.main.bounds.width
                background.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
                
            }
        })
    }

}
