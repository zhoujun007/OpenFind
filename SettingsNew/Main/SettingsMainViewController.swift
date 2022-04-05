//
//  SettingsMainViewController.swift
//  Find
//
//  Created by A. Zheng (github.com/aheze) on 3/31/22.
//  Copyright © 2022 A. Zheng. All rights reserved.
//
    
import UIKit

class SettingsMainViewController: UIViewController, Searchable {
    var showSearchBar = true
    var baseSearchBarOffset = CGFloat(0)
    var additionalSearchBarOffset: CGFloat? = 0
    var updateSearchBarOffset: (() -> Void)?
    
    var model: SettingsViewModel
    var searchViewModel: SearchViewModel
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    
    lazy var pageViewController: SettingsPageViewController = {
        let viewController = model.page.generateViewController(model: model)
        return viewController
    }()
    lazy var resultsViewController = SettingsResultsViewController(paths: model.paths)
    
    static func make(
        model: SettingsViewModel,
        searchViewModel: SearchViewModel
    ) -> SettingsMainViewController {
        let storyboard = UIStoryboard(name: "SettingsContent", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SettingsMainViewController") { coder in
            SettingsMainViewController(
                coder: coder,
                model: model,
                searchViewModel: searchViewModel
            )
        }
        return viewController
    }

    init?(
        coder: NSCoder,
        model: SettingsViewModel,
        searchViewModel: SearchViewModel
    ) {
        self.model = model
        self.searchViewModel = searchViewModel
        super.init(coder: coder)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with metadata.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        setup()
        scrollView.alwaysBounceVertical = true
        
        addResizableChildViewController(pageViewController, in: contentView)
        addResizableChildViewController(resultsViewController, in: contentView)
        
        listen()
        showResults(false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseSearchBarOffset = getCompactBarSafeAreaHeight(with: Global.safeAreaInsets)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            self.baseSearchBarOffset = self.getCompactBarSafeAreaHeight(with: Global.safeAreaInsets)
            self.updateSearchBarOffset?()
        }
    }
}