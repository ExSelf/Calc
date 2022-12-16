import UIKit

protocol ButtonViewDelegate {
    func buttonClicked(sender: UIButton)
}

class ButtonView: UIView {
    let buttonView = UIButton()
    
    let greyButtonColor = UIColor(red: 52/255, green: 52/255, blue: 52/255, alpha: 1)
    let lightGreyButtonColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
    let orangeButtonColor = UIColor(red: 1, green: 153/255, blue: 0, alpha: 1)
    
    var delegate: ButtonViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        addSubViews()
        setupConstrains()
        addActions()
    }
    
    private func addSubViews() {
        self.addSubview(buttonView)
    }
    
    private func setupConstrains() {
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -6),
            //           buttonView.widthAnchor.constraint(equalTo: buttonView.heightAnchor)
            //            buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
            //            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
        ])
    }
        
    private  func addActions() {
        buttonView.addTarget(self, action: #selector(buttonClicked(sender:)), for: .touchUpInside)
    }
    
    func setupSelf(name: String, height: Double) {
        //buttonView.setTitle(name, for: [])
        //buttonView.layer.cornerRadius = height / 2 + 6
        buttonView.titleLabel?.font = UIFont.systemFont(ofSize: height / 2, weight: .light)
        
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.title = name
        //configuration.
        
        if name == "0" {
            NSLayoutConstraint.activate([
                buttonView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6),
                buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6),
            ])
        } else {
            buttonView.widthAnchor.constraint(equalTo: self.buttonView.heightAnchor).isActive = true
        }

        configuration.baseBackgroundColor = greyButtonColor
        
        ["AC", "+/-", "%"].forEach {
            if name == $0 {
                configuration.baseBackgroundColor = lightGreyButtonColor
                configuration.baseForegroundColor = .black
            }
        }
        
        ["/", "*", "-", "+", "="].forEach {
            if name == $0 {
                configuration.baseBackgroundColor = orangeButtonColor
                configuration.baseForegroundColor = .white
            }
        }
        
        buttonView.configuration = configuration
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if let delegate = delegate {
            delegate.buttonClicked(sender: sender)
        }
    }
}
