import UIKit

class CalculatorViewController: UIViewController, UITextFieldDelegate {
    
    var totalBill: Double = 0
    var tip: Double = 0
    var splitNumber: Int = 2
    var eachPersonPays: Double = 0

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.billTextField.delegate = self
        billTextField.keyboardType = .decimalPad // Ensure the keyboard type is decimalPad
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func tipChanged(_ sender: UIButton) {
        // Deselect all tip buttons
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Select the pressed button
        sender.isSelected = true
        
        // Safely unwrap the button title text and convert it to a Double
        guard let buttonTitle = sender.titleLabel?.text, let buttonTitleDouble = Double(buttonTitle.dropLast()) else {
            // Handle the case where the title cannot be converted to a Double
            print("Error: Button title is not a valid number")
            return
        }
        
        tip = buttonTitleDouble / 100
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
        splitNumber = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        // Safely unwrap the text field input and convert it to a Double
        guard let billText = billTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            // Handle the case where the bill text is not a valid number
            print("Error: Bill amount is not a valid number")
            return
        }
        
        // Use NumberFormatter to handle localization issues
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale.current
        
        guard let totalBillNumber = formatter.number(from: billText) else {
            print("Error: Bill amount is not a valid number")
            return
        }
        
        totalBill = totalBillNumber.doubleValue
        
        let tipAmount = totalBill * tip
        let finalAmount = totalBill + tipAmount
        eachPersonPays = (finalAmount / Double(splitNumber)).rounded(toPlaces: 2)
        
        
        // Instantiate ResultsViewController from storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destinationController = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as? ResultsViewController else {
            return
        }
        
        // Pass data to ResultsViewController
        destinationController.totalBill = totalBill
        destinationController.tipPercentage = tip * 100
        destinationController.splitNumber = splitNumber
        destinationController.eachPersonPays = eachPersonPays
        
        // Present the ResultsViewController
        self.present(destinationController, animated: true, completion: nil)
    }
}

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
