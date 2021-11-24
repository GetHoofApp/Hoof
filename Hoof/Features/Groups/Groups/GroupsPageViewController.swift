//
//  GroupsPageViewController.swift
//  Groups
//
//  Created by Sameh Mabrouk on 21/11/2021.
//

import UIKit
import Core

class GroupsPageViewController: ViewController<ChallengesViewModel> {
    
    // MARK: Properties
    
    private var segmentedControl: CustomSegmentedContrl!
    
    private var pageController: UIPageViewController!
    private var viewControllers:[UIViewController] = []
    private var currentPage: Int!
    
    private let groupsViewController: GroupsViewController!
    private let challengesViewController: ChallengesViewController!
    private let activeViewController: ActiveViewController!
    
    init(groupsViewController: GroupsViewController, challengesViewController: ChallengesViewController, activeViewController: ActiveViewController) {
        self.groupsViewController = groupsViewController
        self.challengesViewController = challengesViewController
        self.activeViewController = activeViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        currentPage = 0
        createPageViewController()
        
        viewControllers.append(groupsViewController)
        viewControllers.append(challengesViewController)
        viewControllers.append(activeViewController)
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        
        view.backgroundColor = .white
    }
    
    private func setupNavogationBar() {
        title = "Groups"
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
//            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
//            segmentedControl.widthAnchor.constraint(equalToConstant: 100),
//            segmentedControl.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupSubviews() {
        segmentedControl = CustomSegmentedContrl.init(frame: CGRect.init(x: 0, y: 90, width: view.frame.width, height: 55))
        segmentedControl.backgroundColor = .white
        segmentedControl.commaSeperatedButtonTitles = "Active, Challenges, Groups"
        segmentedControl.addTarget(self, action: #selector(onChangeOfSegment(_:)), for: .valueChanged)

        view.addSubview(segmentedControl)
    }
    
    private func createPageViewController() {
        pageController = UIPageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageController.view.backgroundColor = UIColor.white
        pageController.delegate = self
        pageController.dataSource = self
        
        for svScroll in pageController.view.subviews as! [UIScrollView] {
            svScroll.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.pageController.view.frame = CGRect(x: 0, y: self.segmentedControl.frame.maxY, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }
                
        pageController.setViewControllers([groupsViewController], direction: .forward, animated: false, completion: nil)
        
        addChild(pageController)
        view.addSubview(pageController.view)
        pageController.didMove(toParent: self)
    }
    
    @objc func onChangeOfSegment(_ sender: CustomSegmentedContrl) {
        switch sender.selectedSegmentIndex {
        case 0:
            pageController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true, completion: nil)
            currentPage = 0
            
        case 1:
            if currentPage > 1{
                pageController.setViewControllers([viewControllers[1]], direction: .reverse, animated: true, completion: nil)
                currentPage = 1
            }else{
                pageController.setViewControllers([viewControllers[1]], direction: .forward, animated: true, completion: nil)
                currentPage = 1
                
            }
        case 2:
            if currentPage < 2 {
                pageController.setViewControllers([viewControllers[2]], direction: .forward, animated: true, completion: nil)
                currentPage = 2
                
                
            }else{
                pageController.setViewControllers([viewControllers[2]], direction: .reverse, animated: true, completion: nil)
                currentPage = 2
                
            }
        default:
            break
        }
    }
}

// MARK: - Helpers

private extension GroupsPageViewController {
    
    private func indexofViewController(viewController: UIViewController) -> Int {
        if(viewControllers.contains(viewController)) {
            return viewControllers.firstIndex(of: viewController)!
        }
        
        return -1
    }
}


// MARK: - UIPageViewControllerDataSource

extension GroupsPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
          
          var index = indexofViewController(viewController: viewController)
          
          if(index != -1) {
              index = index - 1
          }
          
          if(index < 0) {
              return nil
          }
          else {
              return viewControllers[index]
          }
          
      }
      
      func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
          
          var index = indexofViewController(viewController: viewController)
          
          if(index != -1) {
              index = index + 1
          }
          
          if(index >= viewControllers.count) {
              return nil
          }
          else {
              return viewControllers[index]
          }
          
      }
      
      func pageViewController(_ pageViewController1: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
          
          if(completed) {
            currentPage = viewControllers.firstIndex(of: (pageViewController1.viewControllers?.last)!)
             // self.segmentedControl.selectedSegmentIndex = currentPage
              
              self.segmentedControl.updateSegmentedControlSegs(index: currentPage)
              
          }

      }
    
}

extension GroupsPageViewController: UIPageViewControllerDelegate {
    
}

extension GroupsPageViewController: UIScrollViewDelegate {
    
}
