import Foundation

class ClockUtil{
    
    private var count :Int = 0
    
    var callBackClock: CallBackClock?
    
    var timer: Timer?
        
    func start(){
        
        timer = Timer.scheduledTimer(
        timeInterval: 1.0,
         target: self,
         selector: #selector(tickAccourd),
         userInfo: nil,
         repeats: true)
        
    }
    
    func stop(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func tickAccourd(){
        
        count += 1
        
        if count > 8 {
            count = 1
        }
        
        callBackClock?.tick(ticks: count)
        print("Tick - \(count)")
        
        }
}

protocol CallBackClock{
    func tick(ticks: Int)
    
}
