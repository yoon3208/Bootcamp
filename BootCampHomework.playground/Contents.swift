class Calculator{
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
        default:
            return 0
        }
    }
        
        func printResults() {
        let calculator = Calculator()
        let addResult = calculator.calculate(operator: "+", firstNumber: 10, secondNumber: 20)
        let subtractResult = calculator.calculate(operator: "-", firstNumber: 10, secondNumber: 20)
        let multiplyResult = calculator.calculate(operator: "*", firstNumber: 10, secondNumber: 20)
        let divideResult = calculator.calculate(operator: "/", firstNumber: 10, secondNumber: 20)
        
   
        print("addResult : \(addResult)")
        print("subtractResult : \(subtractResult)")
        print("multiplyResult : \(multiplyResult)")
        print("divideResult : \(divideResult)")
    }
}
let myObject = Calculator()
myObject.printResults()

