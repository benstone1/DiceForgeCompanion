import UIKit

class SelectDieFaceViewController: UIViewController {

    @IBOutlet var facesCollectionView: UICollectionView!
    
    var faces = DieFace.allFaces
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facesCollectionView.delegate = self
        facesCollectionView.dataSource = self
        facesCollectionView.register(UINib(nibName: "DieFaceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "dieFaceCell")
    }
    
    var onSelect: ((DieFace) -> Void)?
}

extension SelectDieFaceViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return faces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dieFaceCell", for: indexPath) as? DieFaceCollectionViewCell else { fatalError() }
        cell.dieFace = faces[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let face = faces[indexPath.row]
        onSelect?(face)
        dismiss(animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}
