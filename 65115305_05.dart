void addStudent(students, name) {
  students.add(name);
  print("Student $name added.");
}

void removeStudent(students, name) {
  if (students.contains(name)) {
    students.remove(name);
    print("Student $name removed.");
  } else {
    print("Student $name Not found.");
  }
}

void displayStudents(students) {
  if (students.isEmpty) {
    print("No students in the list");
  } else {
    print("student $students");
  }
}

void main() {
  List<String> students = [];
  addStudent(students, "Chanankorn");
  addStudent(students, "Jonksuk");
  addStudent(students, "Sirirat");
  addStudent(students, "Birawit");
  displayStudents(students);
  removeStudent(students, "CJ");
  removeStudent(students, "Jonksuk");
  displayStudents(students);
}
