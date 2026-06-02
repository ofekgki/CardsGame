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
    
    private let POINTS_TO_WIN: Int = 10
    
    var playerName: String = ""
    
    var playerScore: Int = 0
    
    var pcScore: Int = 0
    
    var location: Bool = false
    
    private var roundTimer: Int = 1
    
    private var clock = ClockUtil()
    
    private var isFirst: Bool = true

    private var Deck: [Card] = [
        Card(name: "The Magician", value: 1, imageName: "01-TheMagician"),
        Card(name: "The High Priestess", value: 2, imageName: "02-TheHighPriestess"),
        Card(name: "The Empress", value: 3, imageName: "03-TheEmpress"),
        Card(name: "The Emperor", value: 4, imageName: "04-TheEmperor"),
        Card(name: "The Hierophant", value: 5, imageName: "05-TheHierophant"),
        Card(name: "The Lovers", value: 6, imageName: "06-TheLovers"),
        Card(name: "The Chariot", value: 7, imageName: "07-TheChariot"),
        Card(name: "Strength", value: 8, imageName: "08-Strength"),
        Card(name: "The Hermit", value: 9, imageName: "09-TheHermit"),
        Card(name: "Wheel Of Fortune", value: 10, imageName: "10-WheelOfFortune"),
        Card(name: "Justice", value: 11, imageName: "11-Justice"),
        Card(name: "The Hanged Man", value: 12, imageName: "12-TheHangedMan"),
        Card(name: "Death", value: 13, imageName: "13-Death"),
        Card(name: "Temperance", value: 14, imageName: "14-Temperance"),
        Card(name: "The Devil", value: 15, imageName: "15-TheDevil"),
        Card(name: "The Tower", value: 16, imageName: "16-TheTower"),
        Card(name: "The Star", value: 17, imageName: "17-TheStar"),
        Card(name: "The Moon", value: 18, imageName: "18-TheMoon"),
        Card(name: "The Sun", value: 19, imageName: "19-TheSun"),
        Card(name: "Judgement", value: 20, imageName: "20-Judgement"),
        Card(name: "The World", value: 21, imageName: "21-TheWorld"),
        Card(name: "The Fool" , value: 22, imageName: "00-TheFool")
    ]
    
    private let BlankCard = Card(name: "", value: 0, imageName: "CardBacks")
    
    private var randomIndexEast: Int = 0
    
    private var randomIndexWest: Int = 0

    
    
    // MARK: Start Of Class
    
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
        
        if value <= 5 {
            game_LBL_time.text = "\(value)"
        } else {
            game_LBL_time.text = "\(value - 5)"
        }
        
        // 5 seconds passed -> show cards
        if value == 5 {
            print("Show")
            gameMove()
        }
        
        // 3 seconds after show -> hide cards
        if value == 8 {
            print("Hide")
            hideCards()
            game_LBL_time.text = "0"
            
            if pcScore == POINTS_TO_WIN || playerScore == POINTS_TO_WIN {
                endGame()
            }
        }
    }
        
  
    // MARK: game logic
    
    func showCard(){
        randomIndexEast = Int.random(in: 0..<Deck.count)
        
        randomIndexWest = Int.random(in: 0..<Deck.count)
        
        while randomIndexEast == randomIndexWest {
             randomIndexWest = Int.random(in: 0..<Deck.count)
        }

        game_IMG_eastCard.image = UIImage(named: Deck[randomIndexEast].imageName)
        game_IMG_westCard.image = UIImage(named: Deck[randomIndexWest].imageName)
        
    }
    
    func hideCards() {
        game_IMG_eastCard.image = UIImage(named: BlankCard.imageName)
        game_IMG_westCard.image = UIImage(named: BlankCard.imageName)
    }
    
    func gameMove() {
        
        showCard()
        
        let eastValue = Deck[randomIndexEast].value
        let westValue = Deck[randomIndexWest].value
        
        if eastValue > westValue {
            scoreWinner(isEastWinner: true)
        } else if westValue > eastValue {
            scoreWinner(isEastWinner: false)
        } else {
            showToast(message: "Tie!")
        }
    }
    
    func endGame() {
        showToast(message: "Game Ended!!!")
        clock.stop()
        performSegue(withIdentifier: "goToEnd", sender: self)
    }
    
    func scoreWinner(isEastWinner: Bool) {
        
        let playerIsEast = location
        let playerWon = isEastWinner == playerIsEast
        
        if playerWon {
            playerScore += 1
            showToast(message: "Player Scored!")
        } else {
            pcScore += 1
            showToast(message: "PC Scored!")
        }
        
        updateScoreLabels()
    }
    
    func updateScoreLabels() {
        
        if location {
            game_LBL_eastScore.text = "\(playerScore)"
            game_LBL_westScore.text = "\(pcScore)"
        } else {
            game_LBL_eastScore.text = "\(pcScore)"
            game_LBL_westScore.text = "\(playerScore)"
        }
    }
    
    // MARK: Scene Change
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEnd" {
            let gameOverVC = segue.destination as! EndScene
            
            if pcScore > playerScore {
                gameOverVC.score = POINTS_TO_WIN
                gameOverVC.winner = "PC"
            }
            else {
                gameOverVC.score = POINTS_TO_WIN
                gameOverVC.winner = playerName
            }
        }
    }
}
