//
//  ImageViewerVC.swift
//  FlickrPhotos
//
//  Created by Ahmed Abuelmagd on 30/05/2021.
//

import UIKit

class ImageViewerVC: UIViewController {

    //MARK: - Variables & Constants
    var photo: Photo?
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: (photo?.imageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")) {
            img.kf.indicatorType = .activity
            img.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: [.transition(.fade(1))])
                }
        initScrll(scroll: scrollView)

    }
    // MARK: - Create
    class func create() -> ImageViewerVC {
        let vc = UIStoryboard(name: STORYBOARDS.MAIN.rawValue, bundle: nil).instantiateViewController(withIdentifier: IDENTIDIERS.IMAGE_VIEWER.rawValue) as! ImageViewerVC
        vc.modalPresentationStyle = .fullScreen
        return vc
    }
    func initScrll(scroll: UIScrollView){
        scroll.maximumZoomScale = 4
        scroll.minimumZoomScale = 1
        scroll.delegate = self
    }
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        print("share")
        share(items: ["Title: \(photo?.title ?? "") \n URL : \(photo?.imageUrl ?? "")"], forController: self)
    }
    
}
extension ImageViewerVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = img.image {
                let ratioWidth = img.frame.width / image.size.width
                let ratioHeight = img.frame.height / image.size.height
                let ratio = ratioWidth < ratioHeight ? ratioWidth : ratioHeight
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth * scrollView.zoomScale > img.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - img.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight * scrollView.zoomScale > img.frame.height
                let top = 0.5 * (conditioTop ? newHeight - img.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}

