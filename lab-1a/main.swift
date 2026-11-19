import Foundation

// ==========================================
// TASK 3: Separate Operator Demonstrations
// ==========================================
func demonstrateOperators() {
    print("=== OPERATOR DEMONSTRATIONS ===")
    
    // 1. Arithmetic Operators (+, -, *, /, %)
    let baseScore = 80
    let bonus = 5
    let arithmeticResult = (baseScore + bonus) * 2 / 2 - 1
    let remainder = 10 % 3
    print("Arithmetic: (80 + 5) * 2 / 2 - 1 = \(arithmeticResult), Remainder (10 % 3) = \(remainder)")
    
    // 2. Comparison Operators (==, !=, >, <, >=, <=)
    let isHigher = baseScore > 75
    let isExact = baseScore == 80
    print("Comparison: Is \(baseScore) > 75? \(isHigher) | Is \(baseScore) == 80? \(isExact)")
    
    // 3. Logical Operators (&&, ||, !)
    let hasGoodAttendance = true
    let submittedProject = false
    let eligibleForHonors = hasGoodAttendance && submittedProject
    let eligibleForPass = hasGoodAttendance || submittedProject
    print("Logical: Honors (&&) = \(eligibleForHonors) | Pass (||) = \(eligibleForPass) | Negation (!) = \(!submittedProject)")
    
    // 4. Compound-Assignment Operators (+=, -=, *=, /=)
    var runningPoints = 50
    runningPoints += 15  // 65
    runningPoints -= 5   // 60
    print("Compound-Assignment: Final running points = \(runningPoints)")
    
    // 5. Nil-Coalescing Operator (??)
    let optionalNickname: String? = nil
    let displayNickname = optionalNickname ?? "No Nickname Provided"
    print("Nil-Coalescing: Student Nickname = \(displayNickname)\n")
}

// ==========================================
// TASKS 1, 2, 4, & 5: Student Evaluation Logic
// ==========================================
func evaluateStudent(
    name: String,
    rollNumber: Int,
    subjectMarks: [Double],
    attendancePercentage: Double
) {
    print("--------------------------------------------------")
    print("Evaluating Student: \(name) (Roll No: \(rollNumber))")
    
    // TASK 5: Validate boundary values (0 to 100 for marks and attendance)
    guard subjectMarks.count == 5 else {
        print("Validation Error: Exactly 5 subject marks are required.\n")
        return
    }
    
    for (index, mark) in subjectMarks.enumerated() {
        if mark < 0.0 || mark > 100.0 {
            print("Validation Error: Invalid mark (\(mark)) in Subject \(index + 1). Must be between 0 and 100.\n")
            return
        }
    }
    
    if attendancePercentage < 0.0 || attendancePercentage > 100.0 {
        print("Validation Error: Invalid attendance value (\(attendancePercentage)%). Must be between 0 and 100.\n")
        return
    }
    
    // TASK 1 & 2: Constants, Variables, and Calculations
    let maxMarksPerSubject: Double = 100.0
    let passingMarkThreshold: Double = 40.0
    let minimumAttendance: Double = 75.0
    let totalMaxMarks: Double = maxMarksPerSubject * Double(subjectMarks.count)
    
    var totalObtained: Double = 0.0
    var hasFailedAnySubject: Bool = false
    
    for mark in subjectMarks {
        totalObtained += mark
        if mark < passingMarkThreshold {
            hasFailedAnySubject = true
        }
    }
    
    let average: Double = totalObtained / Double(subjectMarks.count)
    let percentage: Double = (totalObtained / totalMaxMarks) * 100.0
    
    // TASK 4: Use if/else and switch to assign grade and pass/fail status
    var isPassed: Bool = false
    var statusReason: String = ""
    
    if hasFailedAnySubject {
        isPassed = false
        statusReason = "Failed (Scored below \(Int(passingMarkThreshold)) in one or more subjects)"
    } else if attendancePercentage < minimumAttendance {
        isPassed = false
        statusReason = "Failed (Attendance below \(Int(minimumAttendance))%)"
    } else {
        isPassed = true
        statusReason = "Passed"
    }
    
    // Assign letter grade using switch
    let grade: String
    if !isPassed {
        grade = "F"
    } else {
        switch percentage {
        case 90.0...100.0:
            grade = "A+"
        case 80.0..<90.0:
            grade = "A"
        case 70.0..<80.0:
            grade = "B"
        case 60.0..<70.0:
            grade = "C"
        case 40.0..<60.0:
            grade = "D"
        default:
            grade = "F"
        }
    }
    
    // Formatted Output
    print(String(format: "Marks: %@", subjectMarks.map { String(format: "%.1f", $0) }.joined(separator: ", ")))
    print(String(format: "Total: %.1f / %.1f | Average: %.2f | Percentage: %.2f%%", totalObtained, totalMaxMarks, average, percentage))
    print(String(format: "Attendance: %.1f%%", attendancePercentage))
    print("Status: \(statusReason)")
    print("Final Grade: \(grade)\n")
}

// ==========================================
// EXECUTION & TEST CASES
// ==========================================

// Run Task 3 demonstrations
demonstrateOperators()

print("=== STUDENT EVALUATION TEST CASES ===")

// Case 1: Standard High Performer
evaluateStudent(name: "Aarav Sharma", rollNumber: 101, subjectMarks: [92, 88, 95, 91, 89], attendancePercentage: 94.0)

// Case 2: Boundary Value - Maximum Marks (100) & Attendance (100)
evaluateStudent(name: "Diya Patel", rollNumber: 102, subjectMarks: [100, 100, 100, 100, 100], attendancePercentage: 100.0)

// Case 3: Boundary Value - Minimum Passing Marks (40) & Attendance (75)
evaluateStudent(name: "Rohan Verma", rollNumber: 103, subjectMarks: [40, 40, 40, 40, 40], attendancePercentage: 75.0)

// Case 4: Boundary Value - Zero Marks (0)
evaluateStudent(name: "Kabir Singh", rollNumber: 104, subjectMarks: [0, 50, 60, 70, 80], attendancePercentage: 85.0)

// Case 5: Single Failing Mark (< 40) despite high average
evaluateStudent(name: "Ananya Iyer", rollNumber: 105, subjectMarks: [95, 92, 39, 90, 88], attendancePercentage: 90.0)

// Case 6: Low Attendance (< 75%) despite good marks
evaluateStudent(name: "Vikram Rao", rollNumber: 106, subjectMarks: [80, 85, 78, 82, 79], attendancePercentage: 74.9)

// Case 7: Invalid Mark Boundary (> 100 or < 0)
evaluateStudent(name: "Meera Nair", rollNumber: 107, subjectMarks: [85, 105, 78, 82, 79], attendancePercentage: 88.0)

// Case 8: Invalid Attendance Boundary (< 0 or > 100)
evaluateStudent(name: "Arjun Das", rollNumber: 108, subjectMarks: [75, 80, 70, 85, 90], attendancePercentage: -5.0)
