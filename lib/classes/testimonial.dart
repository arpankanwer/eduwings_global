class Testimonials {
  final String stuName;
  final String collegeName;
  final String courseName;
  final String countryName;
  final String remarks;
  final String testimonialImage;

  Testimonials._({
    required this.stuName,
    required this.collegeName,
    required this.courseName,
    required this.countryName,
    required this.remarks,
    required this.testimonialImage,
  });
  factory Testimonials.fromJson(Map<String, dynamic> json) {
    return Testimonials._(
      stuName: json['student_name'],
      collegeName: json['college_name'],
      courseName: json['course_name'],
      countryName: json['country_name'],
      remarks: json['remarks'],
      testimonialImage: json['imagename'],
    );
  }
}
