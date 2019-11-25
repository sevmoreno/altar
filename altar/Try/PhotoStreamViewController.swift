

import UIKit
import AVFoundation

class PhotoStreamViewController: UICollectionViewController {
  var photos = [Photo] ()
  var alturaTexto: CGFloat = 0.0
  
    @IBOutlet var referenciaCollection: UICollectionView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    var photo = Photo (caption: "hola", comment: "pepe", image: UIImage(named: "1")!)
    photos.append(photo)
    
    photo = Photo (caption: "", comment: "fdsfdsfdss  ", image: UIImage(named: "2")!)
    photos.append(photo)
    
    photo = Photo (caption: "fsdfdsfs", comment: "fdsfdsfdss", image: UIImage(named: "3")!)
    photos.append(photo)
    
    photo = Photo (caption: "fsdfdsfs", comment: "fdsfdsfdss", image: UIImage(named: "4")!)
    photos.append(photo)
    
    if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
      layout.delegate = self
    }
    if let patternImage = UIImage(named: "1") {
      view.backgroundColor = UIColor(patternImage: patternImage)
    }
    collectionView?.backgroundColor = .clear
    collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
  }
}

extension PhotoStreamViewController: UICollectionViewDelegateFlowLayout {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    print (photos.count)
    return photos.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
   // cell.photo = photos[indexPath.item]
    cell.imageView.image = photos[indexPath.row].image
    cell.captionLabel.text = photos[indexPath.row].caption
    cell.commentLabel.text = photos[indexPath.row].comment
    alturaTexto = cell.captionLabel.bounds.height + cell.commentLabel.bounds.height
     print ("Esto es alutratexte ANTES DEl delegate \(alturaTexto)")
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
    return CGSize(width: itemSize, height: itemSize)
  }
}

extension PhotoStreamViewController: PinterestLayoutDelegate {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
    //return photos[indexPath.item].image.size.height
   
 //  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath as IndexPath) as! AnnotatedPhotoCell
    print ("Esto es alutratexte en el delegate \(alturaTexto)")
    
    return 200.0 + alturaTexto
  }
}
