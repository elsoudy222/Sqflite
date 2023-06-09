class Person {
   int id;
   String name;
   int age;

  Person({required this.id, required this.name, required this.age});

  factory Person.getNewEmpty() {
    return Person(id: 0, name: '', age: 0);
  }

  factory Person.fromMap(Map<dynamic, dynamic> map) {
    return Person(
      id: map["id"] ?? 0,
      name: map["name"] ?? "",
      age: map["age"] ?? 0,
    );
  }
}
