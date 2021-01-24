//
//  DevTableViewCell.swift
//  Tawk.to
//
//  Created by Danmark Arqueza on 1/22/21.
//

import UIKit
import Combine
import SkeletonView

class DevTableViewCell: UITableViewCell {
    
    @IBOutlet weak var devProfileImageView: UIImageView!
    @IBOutlet weak var devUsernameLabel: UILabel!
    @IBOutlet weak var devDetailLabel: UILabel!
    @IBOutlet weak var devNoteImageView: UIImageView!
    
    private var imageRequester: AnyCancellable?
    

    public override func prepareForReuse() {
      super.prepareForReuse()
      devProfileImageView.image = nil
      imageRequester?.cancel()
    }
    
    
    func configure(withDev dev: Devs, index: Int) {
        hideSkeletonView()
        let invertColor = (index + 1) % 4 == 0 && index > 0
        devNoteImageView.isHidden = !CoreDataManager.shared.thereIsNotes(id: Int(dev.id))
        devUsernameLabel.text = dev.login
        devDetailLabel.text = dev.htmlURL
        if let url = URL(string: dev.avatarURL ?? .empty) {
          imageRequester = ImageLoader.shared.loadImage(from: url).sink { [weak self] image in
            guard let s = self else { return }
            if invertColor {
              s.changeImage(image: image)
            } else {
              s.devProfileImageView.image = image
            }
          }
        }
      }
    
    
    // MARK: - Show All Skeleton View
    func showSkeletonView() {
        devProfileImageView.showAnimatedGradientSkeleton()
        devUsernameLabel.showAnimatedGradientSkeleton()
        devDetailLabel.showAnimatedGradientSkeleton()
    }

    // MARK: - Hide All Skeleton View
    func hideSkeletonView() {
        devProfileImageView.hideSkeleton()
        devUsernameLabel.hideSkeleton()
        devDetailLabel.hideSkeleton()
    }
    
    // MARK: - Invert Image Color
    private func changeImage(image: UIImage?) {
      if let filter = CIFilter(name: "CIColorInvert"),
        let image = image,
        let ciImage = CIImage(image: image) {
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let newImage = UIImage(ciImage: filter.outputImage!)
        devProfileImageView.image = newImage
      }
    }

}
