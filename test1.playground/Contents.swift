
// Question 1 -- sortByStrings(s,t): Sort the letters in the string s by the order they occur in the string t.
// You can assume t will not have repetitive characters. For s = "weather" and t = "therapyw",
// the output should be sortByString(s, t) = "theeraw". For s = "good" and t = "odg",
// the output should be sortByString(s, t) = "oodg".

func sortByStrings(s: String, t: String) -> String {
    
    var decoderDict: [Character: Int] = [:]
    var resultString = ""
    
    for char in t {
        // decoder will not have repetitive characters
        decoderDict[char] = 0
    }
    for char in s {
        if decoderDict[char] != nil {
            decoderDict[char]! += 1
        }
    }
    
    for char in t {
        let numberOfCharOccers: Int = decoderDict[char]!
        for _ in 0..<numberOfCharOccers {
            resultString.append(char)
        }
    }
    
    return resultString
}
