class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning Workout', isDone: true ),
      ToDo(id: '02', todoText: 'Cook Breakfast', isDone: true ),
      ToDo(id: '03', todoText: 'Check USTEP', ),
      ToDo(id: '04', todoText: 'AppDev Online Meeting at 1PM', ),
    ];
  }
}