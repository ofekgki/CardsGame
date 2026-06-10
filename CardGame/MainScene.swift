import UIKit
import CoreLocation


class MainScene: UIViewController {


    @IBOutlet weak var main_IMG_east: UIImageView!
    
    @IBOutlet weak var main_LBL_east: UILabel!
    
    @IBOutlet weak var main_IMG_west: UIImageView!
    
    @IBOutlet weak var main_LBL_west: UILabel!
    
    @IBOutlet weak var main_LBL_name: UILabel!
    
    @IBOutlet weak var main_BTN_enterName: UIButton!
    
    @IBOutlet weak var main_BTN_startGame: UIButton!
    
    
    var lat: Double = 0.0
    
    var location: Bool = false // false - west , true - east
    
    private var canPlay: Bool = false
    
    private let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
    
    var playerName : String = UserDefaults.standard.string(forKey: "playerName") ?? ""
    
    private let locationManager = CLLocationManager()
    
        
    // MARK: Start Of Class
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLaunch()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        
    }
    
    func firstLaunch(){
        if !hasLaunchedBefore || playerName.isEmpty {
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
        else
            {
            main_BTN_enterName.isHidden = true
            main_LBL_name.isHidden = false
            main_LBL_name.text = "Hello \(playerName)"
            
        }
    }
    
    @IBAction func startGameClicked(_ sender: UIButton) {
          performSegue(withIdentifier: "goToGame", sender: self)
      }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToGame" {
            let gameVC = segue.destination as! GameScene
            gameVC.playerName = self.playerName
            gameVC.location = self.location
        }
    }
    
    
    
    //MARK: Name
    
    @IBAction func enterNameClicked(_ sender: Any) {
        if playerName.isEmpty {
            chooseNameBox()
            
        }
    }
    
    func chooseNameBox(){
             let alertController = UIAlertController(title: "", message: "Enter your name", preferredStyle: .alert)

             alertController.addTextField { (textField) in
                 textField.placeholder = "Name"
             }
        
             // add the buttons/actions to the view controller
        
             let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
             let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

                 // this code runs when the user hits the "save" button

                 if alertController.textFields![0].text!.isEmpty{
                     
                     self.showToast(message: "Must Enter A Name")
                     
                 }
                 else {
                     
                     let inputName = alertController.textFields![0].text?.capitalized
                     
                     UserDefaults.standard.set(inputName, forKey: "playerName")
                     
                     self.playerName = inputName!
                     
                     self.showToast(message: "Hello \(inputName!)")
                     
                     self.main_BTN_enterName.isHidden = true
                     self.main_BTN_startGame.isHidden = false
                     self.main_LBL_name.isHidden = false
                     self.main_LBL_name.text = "Hello \(inputName!)"
                     
                 }

             }

             alertController.addAction(cancelAction)
             alertController.addAction(saveAction)

             present(alertController, animated: true, completion: nil)
         
    }
    
    
    //MARK: Location
    
    func getLocation(){
 
        if lat >= 34.18754916832433 {
        location = false
            main_LBL_west.backgroundColor = UIColor(named: "BackgroundLocationColor")

        }
        else {
            location = true
            main_LBL_east.backgroundColor = UIColor(named: "BackgroundLocationColor")

            
        }
        
        canPlay = checkIfCanPlay()
        if canPlay{
            main_BTN_startGame.isHidden = false
        }
    }
    
    
    //MARK: Can Play?
    public func checkIfCanPlay() -> Bool{
        return !playerName.isEmpty && lat != 0.0

    }


    @IBAction func myUnwindAction(unwindSegue: UIStoryboardSegue){
    }
    
}



