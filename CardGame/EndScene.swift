import UIKit

class EndScene: UIViewController {
    
    @IBOutlet weak var end_LBL_winnerName: UILabel!
    
    @IBOutlet weak var end_LBL_endScore: UILabel!
    
    @IBOutlet weak var end_BTN_menu: UIButton!
    
    var winner: String = ""
    
    var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (winner == "PC")
            {
            SoundManager.shared.playSoundEffect("GameLost")
        }
        else {
            SoundManager.shared.playSoundEffect("GameWon")
        }
        
        end_LBL_endScore.text = "\(score)"
        
        end_LBL_winnerName.text = "\(winner) Won!"
        
    }
    



        
        
    
    
}

