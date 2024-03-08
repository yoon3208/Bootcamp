class Calculator{
    let firstNumber: Double
    let secondNumber: Double
    
    init(_ firstNumber: Double, _ secondNumber: Double) {
        self.firstNumber = firstNumber
        self.secondNumber = secondNumber
    }
    func calculate(operator: String, firstNumber: Double, secondNumber: Double ) -> Double{
        switch `operator` {
        case "+":
            return firstNumber + secondNumber
        case "-":
            return firstNumber - secondNumber
        case "*":
            return firstNumber * secondNumber
        case "/":
            return firstNumber / secondNumber
//        case "%":
//            return firstNumber.truncatingRemainder(dividingBy: secondNumber)
        default:
            return 0
        }
    }
        
    func printResult(){
    let calculator = Calculator (10, 20)
        
        let addResult = calculator.calculate(operator: "+", firstNumber: 10, secondNumber: 20)
        let subtractResult = calculator.calculate(operator: "-", firstNumber: 10, secondNumber: 20)
        let multiplyResult = calculator.calculate(operator: "*", firstNumber: 10, secondNumber: 20)
        let divideResult = calculator.calculate(operator: "/", firstNumber: 10, secondNumber: 20)
//        let remainderResult = calculator.calculate(operator: "%", firstNumber: 10, secondNumber: 20)
      
        
   
        print("addResult : \(addResult)")
        print("subtractResult : \(subtractResult)")
        print("multiplyResult : \(multiplyResult)")
        print("divideResult : \(divideResult)")
//       print("remainderResult : \(remainderResult)")
    }
}
let myObject = Calculator()
myObject.printResult()

