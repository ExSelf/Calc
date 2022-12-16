import UIKit

class ViewController: UIViewController {

    let resultView = UILabel()
    
    //let buttonsView = ButtonsView()
    let buttonsStackView = UIStackView()
    
    let buttonArray = [
        ["AC", "+/-", "%", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["0", ".", "="],
    ]

    let firstRowButtonsView = UIStackView()
    let acButtonView = ButtonView()
    let plusMinusButtonView = ButtonView()
    let plusMinusButtonImageView = UIImageView()
    let percentButtonView = ButtonView()
    let divideButtonView = ButtonView()

    let secondRowButtonsView = UIStackView()
    let sevenButtonView = ButtonView()
    let eightButtonView = ButtonView()
    let nineButtonView = ButtonView()
    let multiplyButtonView = ButtonView()

    let thirdRowButtonsView = UIStackView()
    let fourButtonView = ButtonView()
    let fiveButtonView = ButtonView()
    let sixButtonView = ButtonView()
    let minusButtonView = ButtonView()

    let forthRowButtonsView = UIStackView()
    let oneButtonView = ButtonView()
    let twoButtonView = ButtonView()
    let threeButtonView = ButtonView()
    let plusButtonView = ButtonView()

    let fifthRowButtonsView = UIStackView()
    let zeroButtonView = ButtonView()
    let periodButtonView = ButtonView()
    let equalsButtonView = ButtonView()
    
    let lightGreyButtonColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
    let orangeButtonColor = UIColor(red: 1, green: 153/255, blue: 0, alpha: 1)
    
    var result = "0"
    var memory: action = .initial
    
    enum action {
        case initial
        case divide (String)
        case multiply (String)
        case subtract (String)
        case fold (String)
        case calculate (String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupButtons()
        updateResult()
        resetButtonColors()
    }

    private func setupViews() {
        resultView.text = result
        
        view.backgroundColor = .black
        
        resultView.textColor = .white
        resultView.textAlignment = .right
        resultView.font = UIFont.systemFont(ofSize: 80, weight: .light)
        
        [resultView, buttonsStackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            resultView.topAnchor.constraint(equalTo: view.topAnchor, constant: 178),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            resultView.heightAnchor.constraint(equalToConstant: 98),
            
            buttonsStackView.topAnchor.constraint(equalTo: resultView.bottomAnchor, constant: 47),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -95),
            ])
    }
    
    func updateResult() {
        if let number = Double(result) {
            let nearestInt = floor(number)
            if nearestInt == number {
                resultView.text = String(Int(nearestInt))
            } else {
                resultView.text = String(number)
            }
        }
    }

    private func setupButtons() {
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
                button.delegate = self
                let height = (view.frame.height - 518) / 5
                button.setupSelf(name: buttonName.description, height: height)
                
                if buttonName.description == "0" {
                    button.widthAnchor.constraint(equalTo: row.widthAnchor, multiplier: 0.5).isActive = true
                } else if buttonName.description == "." || buttonName.description == "=" {
                    button.widthAnchor.constraint(equalTo: row.widthAnchor, multiplier: 0.25).isActive = true
                }
            }
        }
        
//        rowsStackView.axis = .vertical
//        rowsStackView.distribution = .fillEqually
//
//        rowsStackView.addArrangedSubview(firstRowButtonsView)
//        rowsStackView.addArrangedSubview(secondRowButtonsView)
//        rowsStackView.addArrangedSubview(thirdRowButtonsView)
//        rowsStackView.addArrangedSubview(forthRowButtonsView)
//        rowsStackView.addArrangedSubview(fifthRowButtonsView)
//
//        firstRowButtonsView.axis = .horizontal
//        firstRowButtonsView.distribution = .fillEqually
//        firstRowButtonsView.addArrangedSubview(acButtonView)
//        firstRowButtonsView.addArrangedSubview(plusMinusButtonView)
//        firstRowButtonsView.addArrangedSubview(percentButtonView)
//        firstRowButtonsView.addArrangedSubview(divideButtonView)
//
//        secondRowButtonsView.axis = .horizontal
//        secondRowButtonsView.distribution = .fillEqually
//        secondRowButtonsView.addArrangedSubview(sevenButtonView)
//        secondRowButtonsView.addArrangedSubview(eightButtonView)
//        secondRowButtonsView.addArrangedSubview(nineButtonView)
//        secondRowButtonsView.addArrangedSubview(multiplyButtonView)
//
//        thirdRowButtonsView.axis = .horizontal
//        thirdRowButtonsView.distribution = .fillEqually
//        thirdRowButtonsView.addArrangedSubview(fourButtonView)
//        thirdRowButtonsView.addArrangedSubview(fiveButtonView)
//        thirdRowButtonsView.addArrangedSubview(sixButtonView)
//        thirdRowButtonsView.addArrangedSubview(minusButtonView)
//
//        forthRowButtonsView.axis = .horizontal
//        forthRowButtonsView.distribution = .fillEqually
//        forthRowButtonsView.addArrangedSubview(oneButtonView)
//        forthRowButtonsView.addArrangedSubview(twoButtonView)
//        forthRowButtonsView.addArrangedSubview(threeButtonView)
//        forthRowButtonsView.addArrangedSubview(plusButtonView)
//
//        fifthRowButtonsView.axis = .horizontal
//        fifthRowButtonsView.distribution = .equalCentering
//        fifthRowButtonsView.addArrangedSubview(zeroButtonView)
//        fifthRowButtonsView.addArrangedSubview(periodButtonView)
//        fifthRowButtonsView.addArrangedSubview(equalsButtonView)
//        zeroButtonView.buttonView.contentHorizontalAlignment = .left
//        zeroButtonView.buttonView.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0);
//        zeroButtonView.widthAnchor.constraint(equalTo: fifthRowButtonsView.widthAnchor, multiplier: 0.5).isActive = true
//        periodButtonView.widthAnchor.constraint(equalTo: fifthRowButtonsView.widthAnchor, multiplier: 0.25).isActive = true
//        equalsButtonView.widthAnchor.constraint(equalTo: fifthRowButtonsView.widthAnchor, multiplier: 0.25).isActive = true
//
//        acButtonView.buttonView.setTitle("AC", for: [])
//
//
//       // plusMinusButtonView.buttonView.setImage(UIImage(systemName: "plus.slash.minus"), for: [])
//       // plusMinusButtonView.buttonView.contentVerticalAlignment = .fill
//       // plusMinusButtonView.buttonView.contentHorizontalAlignment = .fill
//
//        var config = UIButton.Configuration.plain()
//        config.image = UIImage(systemName: "plus.slash.minus")
//        plusMinusButtonView.buttonView.configuration = config
//        plusMinusButtonView.buttonView.setTitle("\u{207A}\u{2215}\u{208B}", for: [])
//
//        percentButtonView.buttonView.setTitle("%", for: [])
//        divideButtonView.buttonView.setTitle("\u{00F7}", for: [])
//
//        sevenButtonView.buttonView.setTitle("7", for: [])
//        eightButtonView.buttonView.setTitle("8", for: [])
//        nineButtonView.buttonView.setTitle("9", for: [])
//        multiplyButtonView.buttonView.setTitle("\u{00D7}", for: [])
//
//        fourButtonView.buttonView.setTitle("4", for: [])
//        fiveButtonView.buttonView.setTitle("5", for: [])
//        sixButtonView.buttonView.setTitle("6", for: [])
//        minusButtonView.buttonView.setTitle("-", for: [])
//
//        oneButtonView.buttonView.setTitle("1", for: [])
//        twoButtonView.buttonView.setTitle("2", for: [])
//        threeButtonView.buttonView.setTitle("3", for: [])
//        plusButtonView.buttonView.setTitle("+", for: [])
//
//        zeroButtonView.buttonView.setTitle("0", for: [])
//        periodButtonView.buttonView.setTitle(".", for: [])
//        equalsButtonView.buttonView.setTitle("=", for: [])
//
////        rowsStackView.layoutIfNeeded()
//        [acButtonView, plusMinusButtonView, percentButtonView, divideButtonView,
//         sevenButtonView, eightButtonView, nineButtonView, multiplyButtonView,
//         fourButtonView, fiveButtonView, sixButtonView, minusButtonView,
//         oneButtonView, twoButtonView, threeButtonView, plusButtonView,
//         zeroButtonView, periodButtonView, equalsButtonView].forEach {
//            $0.delegate = self
//            $0.buttonView.layer.cornerRadius = firstRowButtonsView.frame.height / 2 - 6
//            $0.buttonView.titleLabel?.font = UIFont.systemFont(ofSize: firstRowButtonsView.frame.height / 2, weight: .light)
//        }
//
//        [acButtonView, plusMinusButtonView, percentButtonView, divideButtonView,
//         sevenButtonView, eightButtonView, nineButtonView, multiplyButtonView,
//         fourButtonView, fiveButtonView, sixButtonView, minusButtonView,
//         oneButtonView, twoButtonView, threeButtonView, plusButtonView,
//         periodButtonView, equalsButtonView].forEach {
//            NSLayoutConstraint.activate([
//                $0.buttonView.widthAnchor.constraint(equalTo: $0.buttonView.heightAnchor)
//            ])
//        }
//
//        let offset = (zeroButtonView.frame.width - 2 * (zeroButtonView.frame.height - 12)) / 4
//
//        NSLayoutConstraint.activate([
//            zeroButtonView.buttonView.leadingAnchor.constraint(equalTo: zeroButtonView.leadingAnchor, constant: offset),
//            zeroButtonView.buttonView.trailingAnchor.constraint(equalTo: zeroButtonView.trailingAnchor, constant: -offset),
//        ])

    }

    func resetButtonColors() {
        [acButtonView, plusMinusButtonView, percentButtonView].forEach {
            $0.buttonView.backgroundColor = lightGreyButtonColor
            $0.buttonView.setTitleColor(.black, for: [])
        }

        [divideButtonView, multiplyButtonView, minusButtonView, plusButtonView, equalsButtonView].forEach {
            $0.buttonView.backgroundColor = orangeButtonColor
            $0.buttonView.setTitleColor(.white, for: [])
        }
    }
}

extension ViewController: ButtonViewDelegate {
    func buttonClicked(sender: UIButton) {
        if let title = sender.title(for: .normal) {
            resetButtonColors()
            if Int(title) != nil {
                if result != "0" {
                    result.append(title)
                } else {
                    result = title
                }
                resultView.text = result
            } else if title == "." {
                resetButtonColors()
                if result.firstIndex(of: ".") == nil {
                    result.append(title)
                    resultView.text = result
                }
            } else if title == "AC" {
                memory = .initial
                result = "0"
                resultView.text = result
            } else if title == "\u{207A}\u{2215}\u{208B}" {
                if result.first == "-" {
                    result.removeFirst()
                } else {
                    var tempResult = "-"
                    tempResult.append(result)
                    result = tempResult
                }
                resultView.text = result
                
            } else if title == "\u{00F7}" {   // MARK: - Division
                switch memory {
                case .divide(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .divide(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .multiply(let mem):
                    let calc = Double(mem)! * Double(result)!
                    memory = .divide(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .initial:
                    memory = .divide(result)
                    result = "0"
                case .subtract(let mem):
                    let calc = Double(mem)! - Double(result)!
                    memory = .divide(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .fold(let mem):
                    let calc = Double(mem)! + Double(result)!
                    memory = .divide(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .calculate(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .divide(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                }
                divideButtonView.buttonView.backgroundColor = .white
                divideButtonView.buttonView.setTitleColor(orangeButtonColor, for: [])
                
            } else if title == "\u{00D7}" {   // MARK: - Multipication
                switch memory {
                case .divide(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .multiply(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .multiply(let mem):
                    let calc = Double(mem)! * Double(result)!
                    memory = .multiply(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .initial:
                    memory = .multiply(result)
                    result = "0"
                case .subtract(let mem):
                    let calc = Double(mem)! - Double(result)!
                    memory = .multiply(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .fold(let mem):
                    let calc = Double(mem)! + Double(result)!
                    memory = .multiply(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .calculate(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .multiply(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                }
                multiplyButtonView.buttonView.backgroundColor = .white
                multiplyButtonView.buttonView.setTitleColor(orangeButtonColor, for: [])
                
            } else if title == "-" {   // MARK: - Substraction
                switch memory {
                case .divide(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .subtract(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .multiply(let mem):
                    let calc = Double(mem)! * Double(result)!
                    memory = .subtract(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .initial:
                    memory = .subtract(result)
                    result = "0"
                case .subtract(let mem):
                    let calc = Double(mem)! - Double(result)!
                    memory = .subtract(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .fold(let mem):
                    let calc = Double(mem)! + Double(result)!
                    memory = .subtract(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .calculate(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .subtract(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                }
                minusButtonView.buttonView.backgroundColor = .white
                minusButtonView.buttonView.setTitleColor(orangeButtonColor, for: [])
                
            } else if title == "+" {   // MARK: - Folding
                switch memory {
                case .divide(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .fold(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .multiply(let mem):
                    let calc = Double(mem)! * Double(result)!
                    memory = .fold(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .initial:
                    memory = .fold(result)
                    result = "0"
                case .subtract(let mem):
                    let calc = Double(mem)! - Double(result)!
                    memory = .fold(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .fold(let mem):
                    let calc = Double(mem)! + Double(result)!
                    memory = .fold(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                case .calculate(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .fold(String(calc))
                    result = String(calc)
                    updateResult()
                    result = "0"
                }
                plusMinusButtonView.buttonView.backgroundColor = .white
                plusMinusButtonView.buttonView.setTitleColor(orangeButtonColor, for: [])
                
            } else if title == "=" {   // MARK: - Calc
                switch memory {
                case .divide(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .initial
                    result = "\(calc)"
                case .multiply(let mem):
                    let calc = Double(mem)! * Double(result)!
                    memory = .initial
                    result = "\(calc)"
                case .initial:
                    return
                case .subtract(let mem):
                    let calc = Double(mem)! - Double(result)!
                    memory = .initial
                    result = "\(calc)"
                case .fold(let mem):
                    let calc = Double(mem)! + Double(result)!
                    memory = .initial
                    result = "\(calc)"
                case .calculate(let mem):
                    let calc = Double(mem)! / Double(result)!
                    memory = .initial
                    result = "\(calc)"
                }
                updateResult()
                resetButtonColors()
            }
        }
    }
}
