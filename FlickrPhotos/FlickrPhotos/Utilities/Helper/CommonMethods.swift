//
//  CommonMethods.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit

public var screenWidth:CGFloat { get { return UIScreen.main.bounds.size.width } }
public var screenHeight:CGFloat { get { return UIScreen.main.bounds.size.height } }
// MARK: - loader
public func showLoaderForController(_ controller:UIViewController){
    DispatchQueue.main.async(execute: {
        let loader = Bundle.main.loadNibNamed(CELL_IDENTIFIEERS.LOADER.rawValue, owner: controller, options: nil)?.last as! LoaderView
        loader.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        loader.tag = 4000
        controller.view.addSubview(loader)
        loader.showLoader()
        //loader.initLoader()
    })
}



public func hideLoaderForController(_ controller:UIViewController){
    DispatchQueue.main.async(execute: {
        if let view = controller.view.viewWithTag(4000) {
            view.removeFromSuperview()
        }
    })
}
//MARK: - Colors
public func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
public func getCurrentVC() -> UIViewController? {
    // we must get the root UIViewController and iterate through presented views
    if let rootController = UIApplication.shared.windows.first?.rootViewController {
        var currentController: UIViewController! = rootController
        // Each ViewController keeps track of the view it has presented, so we
        // can move from the head to the tail, which will always be the current view
        while( currentController.presentedViewController != nil ) {
            currentController = currentController.presentedViewController
        }
        return currentController
    }
    return nil
}
/// share items like string or images to all available social media
///
/// - Parameters:
///   - items: the items to share
///   - controller: the controller that will be responsable for displaying the ActivityController
///   - types: the excluded activity types, default value is nil
func share(items:[Any], forController controller:UIViewController, excludedActivityTypes types:[UIActivity.ActivityType]? = nil) {
    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    activityViewController.popoverPresentationController?.sourceView = controller.view // so that iPads won't crash
    
    // exclude some activity types from the list (optional)
    activityViewController.excludedActivityTypes = types
    
    // present the view controller
    controller.present(activityViewController, animated: true, completion: nil)
}
