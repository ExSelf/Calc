import UIKit

class ButtonsView: UIView {

    let buttonsStackView = UIStackView()
    
    let buttonArray = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="],
    ]
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        self.addSubview(buttonsStackView)
        
        self.backgroundColor = .gray
        
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fillEqually
        
        for buttonRow in buttonArray {
            let row = UIStackView()
            buttonsStackView.addArrangedSubview(row)
            row.axis = .horizontal
            row.distribution = .fillEqually
            for buttonName in buttonRow {
                let button = ButtonView()
                row.addArrangedSubview(button)
                button.backgroundColor = .red
                button.buttonView.setTitle(buttonName.description, for: [])
               // button.delegate = self
            }
        }
    }
}
