import UIKit

class GameScene: UIViewController {
    
    @IBOutlet weak var game_LBL_time: UILabel!
    
    @IBOutlet weak var game_IMG_timer: UIImageView!
    
    @IBOutlet weak var game_IMG_eastCard: UIImageView!
    
    @IBOutlet weak var game_LBL_eastName: UILabel!
    
    @IBOutlet weak var game_LBL_eastScore: UILabel!
    
    @IBOutlet weak var game_IMG_westCard: UIImageView!
    
    @IBOutlet weak var game_LBL_westName: UILabel!
    
    @IBOutlet weak var game_LBL_westScore: UILabel!
    
    private let POINTS_TO_WIN: Int = 0
    
    var playerName: String = ""
    
    var playerScore: Int = 0
    
    var pcScore: Int = 0
    
    var location: Bool = false
    
    private var clock = ClockUtil()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if location {
            game_LBL_eastName.text = playerName
            game_LBL_westName.text = "PC"
        }
        else {
            game_LBL_eastName.text = "PC"
            game_LBL_westName.text = playerName
        }
        
        clock.callBackClock = self
        clock.start()
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clock.stop()
    }

    
    func updateUI(value: Int) {
        game_LBL_time.text = "Time: \(value)"
        
        if pcScore == POINTS_TO_WIN || playerScore == POINTS_TO_WIN {
            endGame()
        }
    }
    
    func endGame() {
        showToast(message: "Game Ended!!!")
        clock.stop()
        performSegue(withIdentifier: "goToEnd", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEnd" {
            let gameOverVC = segue.destination as! EndScene
            
            if pcScore > playerScore {
                gameOverVC.score = POINTS_TO_WIN
                gameOverVC.winner = playerName

            }
            else {
                gameOverVC.score = POINTS_TO_WIN
                gameOverVC.winner = "PC"
            }
        }
    }
    
    
    
    
    
    
    
}

extension  GameScene: CallBackClock {

    func tick(ticks: Int) {
        updateUI(value: ticks)
    }
}
