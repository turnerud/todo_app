class ToDo {
  String id;
  String todoText;
  String category;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    required this.category, // maybe add dropdown menu that allows user to pick category?
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(
          id: '01',
          todoText: 'Take Final Exams',
          category: 'School',
          isDone: true),
      ToDo(
          id: '02',
          todoText: 'Read the Aeneid',
          category: 'School',
          isDone: true),
      ToDo(
        id: '03',
        todoText: 'Finish Project 3',
        category: 'School',
      ),
    ];
  }
}
