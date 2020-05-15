
import Foundation



//MARK:- STACK

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


///This function tests using a stack to check for balanced parenthesis in an input string...
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


//MARK:- QUEUE

///Queue Implementation

protocol Queue{
    associatedtype Element
    
    mutating func enqueue(_ element : Element)
    mutating func dequeue()-> Element?
    var isEmpty : Bool{get}
    var peek : Element?{get}
}

///Queues implemented with an array
struct QueueArray<T> : Queue{
    private var array : [T] = []
    
    var isEmpty: Bool{
        return array.isEmpty
    }
    
    var peek : Element?{
        return array.first
    }
    
    mutating func enqueue(_ element: T) {
        array.append(element)
    }
    
    mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

///Queues implemented with a stack
struct QueueStack<T> : Queue{
    
    private var enqueueStack : [T] = []
    private var dequeueStack : [T] = []
    
    var isEmpty: Bool{
        return enqueueStack.isEmpty && dequeueStack.isEmpty
    }
    
    var peek : Element?{
        return dequeueStack.isEmpty ? enqueueStack.first : dequeueStack.last
    }
    
    mutating func enqueue(_ element: T) {
        enqueueStack.append(element)
    }
    
    @discardableResult
    mutating func dequeue() -> T? {
        if dequeueStack.isEmpty{
            dequeueStack = enqueueStack.reversed()
            enqueueStack.removeAll()
        }
        return dequeueStack.popLast()
    }
}


///This protocol is used to test an algorithm for the queue structure, check the next player of a board game of identical players
protocol BoardGameManager{
    associatedtype Player
    
    mutating func nextPlayer()-> Player?
}

extension QueueStack : BoardGameManager{
    typealias Player = T
    mutating func nextPlayer() -> Player? {//get the next player and add back to stack again to begin to await turn...
        guard let player = dequeue() else{
            return nil
        }
        enqueue(player)
        return player
    }
}
