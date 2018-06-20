// decodeString(s): Given an encoded string, return its corresponding decoded string.
// The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is repeated exactly k times.
// Note: k is guaranteed to be a positive integer.
// For s = "4[ab]", the output should be decodeString(s) = "abababab"
// For s = "2[b3[a]]", the output should be decodeString(s) = "baaabaaa"

import Foundation

func decodeString(s: String) -> String {
    
    let stack = Stack()
    var outputString = ""
    
    for char in s {
        if char != "]" {
            stack.push(char: char)
        } else {
            // forming encoded_string
            var k = ""
            var encodedString = outputString
            var isCurrentEncodedString = true
            repeat {
                if let lastCharInStack = stack.peek() {
                    if lastCharInStack == "[" {
                        isCurrentEncodedString = false
                    } else if isDigit(char: lastCharInStack) {
                        k = "\(lastCharInStack)" + k
                    } else if isCurrentEncodedString {
                            encodedString = "\(lastCharInStack)" + encodedString
                    } else {
                        break
                    }
                    stack.pop()
                }
            } while true
            
            // make segment repeated k times
            if let k = Int(k) {
                for _ in 0..<k {
                    for char in encodedString {
                        stack.push(char: char)
                    }
                }
            } else {
                for char in encodedString {
                    stack.push(char: char)
                }
            }
        }
    }
        
    while !stack.isEmpty() {
        outputString = String(stack.peek()!) + outputString
        stack.pop()
    }
    
    return outputString
}
    
func isDigit(char: Character) -> Bool {
    let digits = NSCharacterSet.decimalDigits
    let s = String(char).unicodeScalars
    let uni = s[s.startIndex]
    
    if digits.contains(uni) {
        return true
    }
    return false
}


class Stack {
    
    var stack: [Character] = []
    
    func push(char: Character) {
        self.stack.append(char)
    }

    func peek() -> Character? {
        if self.stack.count == 0 {
            return nil
        } else {
            return self.stack.last!
        }
    }

    func pop() {
        if self.stack.count > 0 {
            self.stack.remove(at: self.stack.count-1)
        }
    }

    func isEmpty() -> Bool {
        if stack.count > 0 {
            return false
        }
    return true
    }
}



print(decodeString(s: "a"))     // a
print(decodeString(s: "a2[b]"))     // abb
print(decodeString(s: "a2[b3[c]]")) // abcccbccc
print(decodeString(s: "a3[b3[c]d2[e]]")) // abcccdeebcccdeebcccdee

