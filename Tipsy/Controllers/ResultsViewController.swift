import UIKit

class ResultsViewController: UIViewController {
    
    var totalBill: Double = 0
    var tipPercentage: Double = 0
    var splitNumber: Int = 0
    var eachPersonPays: Double = 0
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Update UI elements with the passed data
        totalLabel.text = String(format: "%.2f", eachPersonPays)
        settingsLabel.text = "Split between \(splitNumber) people, with \(Int(tipPercentage))% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
