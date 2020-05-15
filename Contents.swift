
import Foundation



///Stack implementation
struct Stack<Element : Equatable> : Equatable{
    
    
    private var storage : [Element] = []
    
    var isEmpty : Bool{
        return peek() == nil
    }
    
    func peek()->Element?{
        return storage.last
    }
    mutating func push(_ element : Element){
        storage.append(element)
    }
    
    @discardableResult
    mutating func pop()->Element?{
        return storage.popLast()
    }
}

extension Stack : CustomStringConvertible{
    var description : String{
        
        return storage.map{"\($0)"}.joined(separator : " ")
    }
}

var stack = Stack<String>()


///Test algorithm using a stack to check for balanced parenthesis in an input string...
func checkForBalancedParanthesisFunc(testString : String)->Bool{
    for str in testString{
        if str == "("{
            stack.push("(")
        } else if str == ")"{
            stack.pop()
        }
    }
    return stack.isEmpty
}

print(checkForBalancedParanthesisFunc(testString: "((())(meo))"))
