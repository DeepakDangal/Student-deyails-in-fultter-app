import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SQLite Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        // Add hamburger icon to the app bar
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: Drawer(
        // Add navigation drawer
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // You can add actions here when Home is tapped
              },
            ),
            ListTile(
              title: Text('Add Student'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddStudentPage()),
                );
              },
            ),
            ListTile(
              title: Text('Add Course'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddCoursePage()),
                );
              },
            ),
            ListTile(
              title: Text('View Students'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewStudentsPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue[100], // Set the background color here
        ),
        child: Center(
          child: Text(
            'Flutter App By Deepak Dangal',
            style: TextStyle(
              fontSize: 24.0, // Adjust font size as needed
              fontWeight: FontWeight.bold, // Adjust font weight as needed
              fontStyle: FontStyle.italic, // Adjust font style as needed
              color: Colors.black, // Adjust font color as needed
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Add Student',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Add Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View Students',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStudentPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCoursePage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ViewStudentsPage()),
            );
          }
        },
      ),
    );
  }
}

class AddStudentPage extends StatefulWidget {
  @override
  _AddStudentPageState createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _feesPaidController = TextEditingController();

  void _addStudent() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    int feesPaid = int.tryParse(_feesPaidController.text) ?? 0;

    // Insert student into database
    await DatabaseHelper.instance.insertStudent({
      'firstName': firstName,
      'lastName': lastName,
      'feesPaid': feesPaid,
    });

    Navigator.pop(context as BuildContext);
    // Go back to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Student'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _feesPaidController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Fees Paid'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addStudent,
              child: Text('Add Student'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCoursePage extends StatefulWidget {
  @override
  _AddCoursePageState createState() => _AddCoursePageState();
}

class _AddCoursePageState extends State<AddCoursePage> {
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController = TextEditingController();

  void _addCourse() async {
    String courseName = _courseNameController.text;
    String courseDescription = _courseDescriptionController.text;

    // Insert course into database
    await DatabaseHelper.instance.insertCourse({
      'courseName': courseName,
      'courseDescription': courseDescription,
    });

    Navigator.pop(context as BuildContext);
    // Go back to previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Course'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _courseNameController,
              decoration: InputDecoration(labelText: 'Course Name'),
            ),
            TextFormField(
              controller: _courseDescriptionController,
              decoration: InputDecoration(labelText: 'Course Description'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _addCourse,
              child: Text('Add Course'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewStudentsPage extends StatefulWidget {
  @override
  _ViewStudentsPageState createState() => _ViewStudentsPageState();
}

class _ViewStudentsPageState extends State<ViewStudentsPage> {
  late Future<List<Map<String, dynamic>>> _studentsFuture;

  @override
  void initState() {
    super.initState();
    _studentsFuture = DatabaseHelper.instance.queryAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Students'),
      ),
      body: FutureBuilder(
        future: _studentsFuture,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> students = snapshot.data!;
            return ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${students[index]['firstName']} ${students[index]['lastName']}'),
                  subtitle: Text('Fees Paid: ${students[index]['feesPaid']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentDetailPage(student: students[index])),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class StudentDetailPage extends StatelessWidget {
  final Map<String, dynamic> student;

  StudentDetailPage({required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Detail'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Student Number: ${student['id']}'),
            Text('First Name: ${student['firstName']}'),
            Text('Last Name: ${student['lastName']}'),
            Text('Fees Paid: ${student['feesPaid']}'),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentCoursesPage(studentId: student['id'])),
                );
              },
              child: Text('View Courses'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StudentCoursesPage extends StatefulWidget {
  final int studentId;

  StudentCoursesPage({required this.studentId});

  @override
  _StudentCoursesPageState createState() => _StudentCoursesPageState();
}

class _StudentCoursesPageState extends State<StudentCoursesPage> {
  late Future<List<Map<String, dynamic>>> _coursesFuture;

  @override
  void initState() {
    super.initState();
    _coursesFuture = DatabaseHelper.instance.queryCoursesByStudent(widget.studentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Courses'),
      ),
      body: FutureBuilder(
        future: _coursesFuture,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Map<String, dynamic>> courses = snapshot.data!;
            return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Course Name: ${courses[index]['courseName']}'),
                  subtitle: Text('Description: ${courses[index]['courseDescription']}'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'university_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        feesPaid INTEGER
      )
    ''');
    await db.execute('''
      CREATE TABLE courses(
        courseNumber INTEGER PRIMARY KEY AUTOINCREMENT,
        courseName TEXT,
        courseDescription TEXT
      )
    ''');
    await db.execute('''
      CREATE TABLE student_courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        studentId INTEGER,
        courseNumber INTEGER,
        FOREIGN KEY (studentId) REFERENCES students(id),
        FOREIGN KEY (courseNumber) REFERENCES courses(courseNumber)
      )
    ''');
  }

  Future<void> insertSampleData() async {
    final db = await database;

    // Clear existing data
    await db.delete('students');
    await db.delete('courses');
    await db.delete('student_courses');

    // Insert sample students
    for (var i = 0; i < 10; i++) {
      String firstName = _generateFirstName();
      String lastName = _generateLastName();
      int feesPaid = Random().nextInt(1000);
      await db.insert('students', {
        'firstName': firstName,
        'lastName': lastName,
        'feesPaid': feesPaid,
      });
    }

    // Insert sample courses
    List<String> courseNames = [
      'Nepali Literature and Culture',
      'Computer Science Fundamentals',
      'Financial Accounting',
      'Business Management',
      'Environmental Science',
      'Mechanical Engineering',
      'Psychology',
      'Marketing Management',
      'Public Health',
      'Civil Engineering',
    ];
    List<String> courseDescriptions = [
      'Explore the rich literary heritage and cultural traditions of Nepal through this course.',
      'Learn the basic principles and concepts of computer science, including algorithms, data structures, and programming languages.',
      'Understand the principles of financial accounting, including recording, summarizing, and reporting financial transactions.',
      'Gain knowledge and skills in managing organizations, including leadership, decision-making, and strategic planning.',
      'Study the interactions between organisms and their environment, and learn about environmental issues and conservation practices.',
      'Explore the principles of mechanical engineering, including mechanics, thermodynamics, and materials science.',
      'Understand human behavior and mental processes, including cognition, emotion, and motivation.',
      'Learn about marketing concepts, strategies, and techniques for creating, communicating, and delivering value to customers.',
      'Study the promotion of health and prevention of diseases in communities, including epidemiology, biostatistics, and health policy.',
      'Gain knowledge and skills in designing, constructing, and maintaining infrastructure and public works projects.',
    ];
    for (var i = 0; i < 10; i++) {
      await db.insert('courses', {
        'courseName': courseNames[i],
        'courseDescription': courseDescriptions[i],
      });
    }
  }

  Future<void> insertStudent(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert('students', row);
  }

  Future<void> insertCourse(Map<String, dynamic> row) async {
    final db = await database;
    await db.insert('courses', row);
  }

  Future<List<Map<String, dynamic>>> queryAllStudents() async {
    final db = await database;
    return await db.query('students');
  }

  Future<List<Map<String, dynamic>>> queryCoursesByStudent(int studentId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseNumber, courses.courseName, courses.courseDescription
      FROM courses
      JOIN student_courses ON courses.courseNumber = student_courses.courseNumber
      WHERE student_courses.studentId = $studentId
    ''');
  }

  String _generateFirstName() {
    List<String> firstNames = [
      'Sita', 'Rajesh', 'Anjali', 'Ramesh', 'Maya',
      'Bikash', 'Nirmala', 'Dinesh', 'Kamala', 'Hari',
    ];
    return firstNames[Random().nextInt(firstNames.length)];
  }

  String _generateLastName() {
    List<String> lastNames = [
      'Shrestha', 'Gurung', 'Tamang', 'Rai', 'Thapa',
      'Dahal', 'Basnet', 'Sharma', 'Acharya', 'Magar',
    ];
    return lastNames[Random().nextInt(lastNames.length)];
  }
}
