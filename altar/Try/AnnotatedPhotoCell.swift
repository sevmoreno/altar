

import UIKit

class AnnotatedPhotoCell: UICollectionViewCell {
  @IBOutlet private weak var containerView: UIView!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var captionLabel: UILabel!
  @IBOutlet var commentLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    containerView.layer.cornerRadius = 6
    containerView.layer.masksToBounds = true
  }
  
    /*
  var photo: Photo? {
    didSet {
      if let photo = photo {
        imageView.image = photo.image
        captionLabel.text = photo.caption
        commentLabel.text = photo.comment
      }
    }
  }
 */
    
}
