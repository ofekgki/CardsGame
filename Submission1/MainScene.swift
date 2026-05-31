import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var main_IMG_east: UIImageView!
    
    @IBOutlet weak var main_LBL_east: UILabel!
    
    @IBOutlet weak var main_IMG_west: UIImageView!
    
    @IBOutlet weak var main_LBL_west: UILabel!
    
    @IBOutlet weak var main_LBL_name: UILabel!
    
    @IBOutlet weak var main_BTN_enterName: UIButton!
    
    @IBOutlet weak var main_BTN_startGame: UIButton!
    
    
    var lat: Double = 0.0
    
    var location: Bool = false // false - west , true - east
    
    var canPlay: Bool = false
    
    let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
    
    let playerName : String = UserDefaults.standard.string(forKey: "playerName") ?? ""

    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLaunch()
        getLocation()
        canPlay = checkIfCanPlay()
        if canPlay{
            main_BTN_startGame.isHidden = false
        }
        
    }
    
    func firstLaunch(){
        if !hasLaunchedBefore || playerName.isEmpty {
            chooseName()
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
        else
            {
            main_BTN_enterName.isHidden = true
            main_LBL_name.isHidden = false
            main_LBL_name.text = "Hello \(playerName)"
            
        }
    }
    
    func chooseName(){
        
    }
    
    func getLocation(){
        
    }
    
    func checkIfCanPlay() -> Bool{
        if !(playerName.isEmpty && lat == 0.0){
            return true
        }
        else{
            return false
        }
    }


}

