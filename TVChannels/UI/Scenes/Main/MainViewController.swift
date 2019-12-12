//
//  MainViewController.swift
//  TVChannels
//
//  Created by Pablo Paciello on 19/11/2019.
//  Copyright © 2019 Pablo Paciello. All rights reserved.
//

import UIKit
import Combine
import PresentationLayer

class MainViewController: UICollectionViewController {
    private let viewModel: MainScreenViewModel
    private let transitionAnimator: MainTransitionAnimator
    private var displayData: [ChannelDisplayData] = []    
    private var cancellables = Set<AnyCancellable>()
    
    init?(coder: NSCoder, viewModel: MainScreenViewModel, transitionAnimator: MainTransitionAnimator) {
        self.viewModel = viewModel
        self.transitionAnimator = transitionAnimator
        super.init(coder: coder)
    }

    required init?(coder: NSCoder) {
        fatalError("MainViewController is required")
    }
    
    deinit {
        cancellables.forEach {
            $0.cancel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        collectionView?.register(ChannelCollectionViewCell.nib, forCellWithReuseIdentifier: ChannelCollectionViewCell.reuseIdentifier)
        
        //Bind to ViewModel
        viewModel.$channelList
            .sink { [weak self] displayData in
                guard !displayData.isEmpty else { return }
                self?.displayData = displayData
                self?.collectionView?.reloadData()
        }
        .store(in: &cancellables)
    }
    
    // MARK: Segue
    @IBSegueAction
    func createDetailVC(coder: NSCoder, sender: Any?) -> DetailViewController? {
        guard let channel = sender as? ChannelDisplayData, let detailsVC = DetailViewController(coder: coder, channel: channel) else { return nil }
        detailsVC.transitioningDelegate = self
        return detailsVC
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.reuseIdentifier, for: indexPath) as! ChannelCollectionViewCell
        
        // Configure the cell
        cell.populateCell(withDisplayData: displayData[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.showDetail.rawValue, sender: displayData[indexPath.row])
    }
}
    // MARK: UIViewControllerTransitioningDelegate
extension MainViewController: UIViewControllerTransitioningDelegate {    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems?.first, let selectedCell = collectionView.cellForItem(at: selectedIndex) as? ChannelCollectionViewCell, let transitionView = selectedCell.viewForTransition(), let transitionSuperView = transitionView.superview else { return nil }
        
        let startFrame = transitionSuperView.convert(transitionView.frame, to: nil)
        transitionAnimator.present(withFrame: startFrame)
        return transitionAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transitionAnimator.dismiss()
        return transitionAnimator
    }
}
