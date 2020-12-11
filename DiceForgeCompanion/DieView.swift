import UIKit

class DieView: UIView {
    lazy var dieContainer: UIView = {
        let stackView = UIStackView(arrangedSubviews: (1...3).map { _ in return makeButtonStackView() })
        stackView.arrangedSubviews[0].widthAnchor.constraint(equalTo: stackView.arrangedSubviews[1].widthAnchor).isActive = true
        stackView.arrangedSubviews[0].heightAnchor.constraint(equalTo: stackView.arrangedSubviews[1].heightAnchor).isActive = true
        stackView.arrangedSubviews[1].widthAnchor.constraint(equalTo: stackView.arrangedSubviews[2].widthAnchor).isActive = true
        stackView.arrangedSubviews[1].heightAnchor.constraint(equalTo: stackView.arrangedSubviews[2].heightAnchor).isActive = true
        stackView.axis = .vertical
        stackView.frame = bounds
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupViews()
    }

    private func setupViews() {
        addSubview(dieContainer)
    }
    
    private func makeButtonStackView() -> UIStackView {
        let bOne = UIButton()
        let bTwo = UIButton()
        let sv = UIStackView(arrangedSubviews: [bOne, bTwo])
        bOne.widthAnchor.constraint(equalTo: bTwo.widthAnchor).isActive = true
        bOne.heightAnchor.constraint(equalTo: bTwo.heightAnchor).isActive = true
        sv.axis = .horizontal
        return sv
    }
}
