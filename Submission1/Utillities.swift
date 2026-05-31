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
        
        if count < 5{
            count += 1
            callBackClock?.tick(ticks: count)
        }
        
        else {
            count = 0
            callBackClock?.tick(ticks: count)

        }
    
    }
    
}

class LocationUtil{
    
    private var lat :Double = 0.0
    
    private var lon :Double = 0.0
    
    var callBackLocation: CallBackLocation?
    
    func getLocation(){
        
    }
    
    
}

protocol CallBackClock{
    func tick(ticks: Int)
    
}

protocol CallBackLocation{
    func updateLocation(lat: Double, lon: Double)
}
