//
//  ReelCollectionViewCell.swift
//  ReelsPageUIkit
//
//  Created by Noman belim on 09/02/26.
//

import UIKit

import UIKit
import AVFoundation

class ReelCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    // MARK: - Properties
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var videoURL: URL?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopPlayback()
        player = nil
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        // Make profile image circular
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
    }
    
    // MARK: - Configure Cell
    func configure(with reel: Reel) {
         usernameLabel.text = reel.username
         captionLabel.text = reel.caption
        
         likeCountLabel.text = formatCount(reel.likes)
        commentCountLabel.text = formatCount(reel.comments)
        
         let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .regular)
        profileImageView.image = UIImage(systemName: reel.userProfileImage, withConfiguration: config)
        profileImageView.tintColor = .white
         
        if let url = URL(string: reel.videoURL) {
            self.videoURL = url
            setupVideoPlayer(with: url)
        }
    }
    
    // MARK: - Video Player Setup
    private func setupVideoPlayer(with url: URL) {
         player = AVPlayer(url: url)
         
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = videoContainerView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
         if let playerLayer = playerLayer {
            videoContainerView.layer.insertSublayer(playerLayer, at: 0)
        }
        
         NotificationCenter.default.addObserver(
            self,
            selector: #selector(videoDidEnd),
            name: .AVPlayerItemDidPlayToEndTime,
            object: player?.currentItem
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = videoContainerView.bounds
    }
    
    
    func startPlayback() {
        player?.play()
    }
    
    func stopPlayback() {
        player?.pause()
    }
    
    @objc private func videoDidEnd() {
        player?.seek(to: .zero)
        player?.play()
    }
    
    // MARK: - Helper Methods
    private func formatCount(_ count: Int) -> String {
        if count >= 1000000 {
            return String(format: "%.1fM", Double(count) / 1000000.0)
        } else if count >= 1000 {
            return String(format: "%.1fK", Double(count) / 1000.0)
        } else {
            return "\(count)"
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        stopPlayback()
    }
}
