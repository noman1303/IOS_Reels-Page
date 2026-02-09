//
//  ReelsViewController.swift
//  ReelsPageUIkit
//
//  Created by Noman belim on 09/02/26.
//

import UIKit

import UIKit

class ReelsViewController: UIViewController {
     
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private var reels: [Reel] = []
    private var currentIndex: Int = 0
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadReels()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playCurrentVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pauseCurrentVideo()
    }
    
     
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
      
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func loadReels() {
        reels = Reel.getSampleReels()
        collectionView.reloadData()
    }
    
     
    private func playCurrentVideo() {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as? ReelCollectionViewCell else {
            return
        }
        cell.startPlayback()
    }
    
    private func pauseCurrentVideo() {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: currentIndex, section: 0)) as? ReelCollectionViewCell else {
            return
        }
        cell.stopPlayback()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

 
extension ReelsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelCell", for: indexPath) as? ReelCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let reel = reels[indexPath.item]
        cell.configure(with: reel)
        
        return cell
    }
}

 
extension ReelsViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.y / scrollView.frame.height)
        
        if pageIndex != currentIndex {
  
            pauseCurrentVideo()
            currentIndex = pageIndex
            playCurrentVideo()
        }
    }
}

 
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
