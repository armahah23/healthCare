class Exercise {
  final String name;
  final int reps;
  final String duration;

  Exercise({
    required this.name,
    required this.reps,
    required this.duration,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'],
      reps: json['reps'],
      duration: json['duration'],
    );
  }
}