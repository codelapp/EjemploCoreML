import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var modelSegmentedControl: UISegmentedControl!
    @IBOutlet weak var extrasSwitch: UISwitch!
    @IBOutlet weak var kmsLabel: UILabel!
    @IBOutlet weak var kmsSlider: UISlider!
    @IBOutlet weak var statusSegmentedControl: UISegmentedControl!
    @IBOutlet weak var priceLabel: UILabel!
    let cars = Cars()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stackView.setCustomSpacing(25, after: self.modelSegmentedControl)
        self.stackView.setCustomSpacing(25, after: self.extrasSwitch)
        self.stackView.setCustomSpacing(25, after: self.kmsSlider)
        self.stackView.setCustomSpacing(50, after: self.statusSegmentedControl)
        self.calculateValue()
    }

    @IBAction func calculateValue() {
        // Formatear el valor de slider
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedKms = formatter.string(for: self.kmsSlider.value) ?? "0"
        self.kmsLabel.text = "Kilometraje: \(formattedKms) kms"
        
        // Hacer el calculo del valor del coche con ML
        if let prediction = try? cars.prediction(modelo: Double(self.modelSegmentedControl.selectedSegmentIndex), extras: self.extrasSwitch.isOn ? Double(1.0) : Double(0.0), kilometraje: Double(self.kmsSlider.value), estado: Double(self.statusSegmentedControl.selectedSegmentIndex)) {
            
            let clampValue = max(500, prediction.price)
            formatter.numberStyle = .currency
            self.priceLabel.text = formatter.string(for: clampValue)
        } else {
            self.priceLabel.text = "Error"
        }
    }
}

