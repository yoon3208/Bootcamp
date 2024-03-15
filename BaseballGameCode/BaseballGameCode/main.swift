import Foundation

class BaseballGame {
    func start() {
        print("< 게임을 시작합니다 >")
        
        let answer = AnswerNumber().makeAnswer()
        
        class AnswerNumber {
            func makeAnswer() -> Int {
                var answer = 0
                for i in 123...987{
                    let number = String(i).map { String($0) }
                    if number[0] == number[1] || number[0] == number[2] || number[1] == number[2] || number.contains("0") {
                        continue
                    }
                    answer = i
                    break
                }
                return answer
                
                
                
                while true {
                    print("""
                          3자리 숫자를 입력하세요
                          입력하세요:
                          """, terminator: " ")
        
                    
                    
                    
                    guard let userInput: String = readLine(), !userInput.isEmpty else{
                        continue
                    }
                    guard let userInput = readLine() else {
                        print("올바르지 않은 입력값입니다")
                        continue
                    }
                                
                    
                    guard let userNum = Int(userInput) else {
                        print("올바르지 않은 입력값입니다")
                        continue
                    }
                    
                    let userNumber = String(userNum).compactMap { Int(String($0)) }
                    
                if userInput.count != 3 || userNumber.contains(0) || Set(userNumber).count != 3 {
                        print("올바르지 않은 입력값입니다")
                    
                    
                    }
                    
                    let (strike, ball) = compare(answer: answer, guess: userNumber)
                        print("\(strike) 스트라이크, \(ball) 볼")
                        
                    
                    
                    
                    
                        if strike == 3{
                            print("정답입니다!")
                            break
                    
                            }
                        }
                    }
                    
                        func compare(answer: Int, guess: [Int]) -> (strike: Int, ball: Int) {
                               var strike = 0
                               var ball = 0
                    
                    
                               return (strike, ball)
                }
            }
            
        }
    }
    
    let game = BaseballGame()
    game.start()
    
    

