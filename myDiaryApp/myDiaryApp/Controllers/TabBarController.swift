//
//  TabBarController.swift
//  myDiaryApp
//
//  Created by SeoJunYoung on 2023/08/30.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        delegate = self
    }
    

    
    private func configure() {
        let calendarVC = UINavigationController(rootViewController: CalendarViewController())
        calendarVC.tabBarItem = UITabBarItem(
            title: "Calendar",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar")
        )
        
        let listVC = UINavigationController(rootViewController: ListViewController())
        listVC.tabBarItem = UITabBarItem(
            title: "List",
            image: UIImage(systemName: "list.bullet"),
            selectedImage: UIImage(systemName: "list.bullet")
        )
        viewControllers = [calendarVC, listVC]
        tabBar.tintColor = UIColor.myPointColor
    }
    
}

extension TabBarController: UITabBarControllerDelegate  {

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
            return false
        }
        animateToTab(toIndex: toIndex)
        return true
    }

    private func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
              let selectedVC = selectedViewController else { return }

        guard let fromView = selectedVC.view,
              let toView = tabViewControllers[toIndex].view,
              let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
              fromIndex != toIndex else { return }


        // Add the toView to the tab bar view
        fromView.superview?.addSubview(toView)

        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)

        // Disable interaction during animation
        view.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
            toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)

        }, completion: { finished in
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
}
