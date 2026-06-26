class Project {
  final String title;
  final String description;
  final List<String> techStack;
  final Map<String, String> links;

  Project({required this.title, required this.description, required this.techStack, required this.links});
}

class Education {
  final String degree;
  final String institution;
  final String duration;

  Education({required this.degree, required this.institution, required this.duration});
}

class ResumeData {
  static const String name = "ABHINAV S";
  static const String title = "Flutter Developer";
  static const String summary = "Dedicated and enthusiastic Flutter mobile app developer with a passion for crafting efficient, user-friendly applications. Proficient in both beginner and professional-level concepts, I bring a strong foundation in Dart programming language coupled with a keen eye for UI/UX design principles. Committed to staying updated with the latest trends and technologies in mobile app development, I strive to deliver high-quality solutions that exceed client expectations. Eager to contribute to dynamic projects and collaborate with like-minded professionals to create impactful mobile experiences.";

  static final List<String> skills = [
    "Dart", "Flutter", "Hive", "Firebase", "Bloc", "GetX", "Provider", "REST API", "Data Structures"
  ];

  static final List<Project> projects = [
    Project(
      title: "Bee Player",
      description: "Robust music and video player using Flutter for Android platforms with Hive for local storage to allow offline access. Designed with a focus on personal data confidentiality.",
      techStack: ["Dart", "Flutter", "Hive"],
      links: {"Live Link": "https://abhinav8158.itch.io/bee-player", "GitHub": "https://github.com/abhinav/beeplayer"},
    ),
    Project(
      title: "AXIOM",
      description: "Real-estate property management app for renting, selling, and PG properties. Integrated Firebase for real-time data synchronization, secure authentication, and cloud-based storage.",
      techStack: ["Dart", "Flutter", "Firebase", "Bloc", "GetX"],
      links: {"Live Link (User)": "https://abhinav8158.itch.io/axiom-user","Live Link (Provider)": "https://abhinav8158.itch.io/axiom-service", "Live Link (admin)": "https://axiom-serviceprovider.web.app","GitHub": "https://github.com/abhinav/axiom"},
    ),
    Project(
      title: "Student Management App",
      description: "Streamlines administration of student data. Developed using GetX/Provider and Hive database for robust handling of information.",
      techStack: ["Flutter", "GetX", "Provider", "Hive"],
      links: {"GitHub": "https://github.com/abhinav/studentmanagement"},
    ),
  ];

  static final List<Education> education = [
    Education(
      degree: "Master of computer application",
      institution: "AWH engineering college, Calicut",
      duration: "2021 - 2023",
    ),
    Education(
      degree: "Bachelor of Physics",
      institution: "Thunchan Memorial Govt College Tirur ,India",
      duration: "2016 - 2019",
    )
  ];
}
