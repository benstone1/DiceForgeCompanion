import UIKit

protocol DieViewDelegate {
    func didSelect(dieView: DieView, at faceIndex: Int)
}

class DieView: UIView {
    
    func setDie(to newDie: Die) {
        self.die = newDie
    }
    
    func getDie() -> Die {
        return die!
    }
    
    func setDelegate(to newDelegate: DieViewDelegate) {
        self.delegate = newDelegate
    }
    
    private var delegate: DieViewDelegate?
    
    private var buttons: [UIButton] {
        var buttons = [UIButton]()
        for subview in dieContainer.arrangedSubviews {
            guard let stackView = subview as? UIStackView else { fatalError() }
            for arrangedView in stackView.arrangedSubviews {
                guard let button = arrangedView as? UIButton else { fatalError() }
                buttons.append(button)
            }
        }
        return buttons
    }
    
    private var die: Die? {
        didSet {
            guard let die = die else { return }
            for (i, button) in buttons.enumerated() {
                button.setBackgroundImage(die.faces[i].image, for: .normal)
            }
        }
    }
    
    lazy var dieContainer: UIStackView = {
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
    
    @objc private func buttonTapped(sender: UIButton!) {
        delegate?.didSelect(dieView: self, at: sender.tag)
    }


    private func setupViews() {
        addSubview(dieContainer)
        configureButtonHandling()
    }
    
    private func configureButtonHandling() {
        for (i, button) in buttons.enumerated() {
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
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
