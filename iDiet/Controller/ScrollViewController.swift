//
//  ScrollViewController.swift
//  iDiet
//
//  Created by Franck-Stephane Ndame Mpouli on 24/11/2018.
//  Copyright © 2018 Ahmad Karkouti. All rights reserved.
//

import UIKit

protocol ScrollViewControllerDelegate {
    var viewControllers: [UIViewController?] {get}
    var initialViewController: UIViewController {get}
    
    func scrollViewDidScroll()
}

class ScrollViewController: UIViewController {
    
    // MARK: - Properties
    var scrollView: UIScrollView {
        return view as! UIScrollView
    }
    
    var pageSize: CGSize {
        return scrollView.frame.size
    }
    
    var viewControllers: [UIViewController?]!
    var delegate: ScrollViewControllerDelegate?
    
    // MARK: - View Life Cycle
    override func loadView() {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        view = scrollView
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewControllers = delegate?.viewControllers
        for (index, controller) in viewControllers.enumerated() {
            if let controller = controller {
                addChild(controller)
                controller.view.frame = frame(for: index)
                scrollView.addSubview(controller.view)
                controller.didMove(toParent: self)
            }
        }
        // scroll view width
        let width = pageSize.width * CGFloat(viewControllers.count)
        let height = pageSize.height
        scrollView.contentSize = CGSize(width: width, height: height)
        if let controller = delegate?.initialViewController {
            setController(to: controller, animated: false)
        }
    }
    
    func isControllerVisible(_ controller: UIViewController?) -> Bool {
        guard controller != nil else {return false}
        for i in 0..<viewControllers.count {
            if viewControllers[i] == controller {
                let controllerFrame = frame(for: i)
                return controllerFrame.intersects(scrollView.bounds)
            }
        }
        return false
    }
}

// MARK: - Private methods
fileprivate extension ScrollViewController {
    
    func frame(for index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * pageSize.width,
                      y: 0,
                      width: pageSize.width,
                      height: pageSize.height)
    }
    
    func indexFor(controller: UIViewController?) -> Int? {
        return viewControllers.index(where: {$0 == controller } )
    }
    
}

// MARK: - Scroll View Delegate
extension ScrollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll()
    }
}

extension ScrollViewController {
    public func setController(to controller: UIViewController, animated: Bool) {
        guard let index = indexFor(controller: controller) else {return}
        let contentOffset = CGPoint(x: pageSize.width * CGFloat(index), y: 0)
        scrollView.setContentOffset(contentOffset, animated: animated)
    }
}


