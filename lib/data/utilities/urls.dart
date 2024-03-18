class Urls {
  static const String _baseUrl = 'https://task.teamrabbil.com/api/v1';
  static String registration = '$_baseUrl/registration';
  static String login = '$_baseUrl/login';
  static String createTask = '$_baseUrl/createTask';
  static String taskStatusCount = '$_baseUrl/taskStatusCount';
  static String newTaskList = '$_baseUrl/listTaskByStatus/New';
  static String completedTaskList = '$_baseUrl/listTaskByStatus/Completed';
  static String progressTaskList = '$_baseUrl/listTaskByStatus/Progress';
  static String canceledTaskList = '$_baseUrl/listTaskByStatus/Cancelled';
  static String deleteTaskList(String id) => '$_baseUrl/deleteTask/$id';
  static String updateTaskList(String id,String status) => '$_baseUrl/updateTaskStatus/${id}/$status';
  static String emailVerification(String email) => '$_baseUrl/RecoverVerifyEmail/$email';
  static String otpVerification(email, otp) => '$_baseUrl/RecoverVerifyOTP/$email/$otp';
  static String updateProfile = '$_baseUrl/profileUpdate';
  static String passwordSet = '$_baseUrl/RecoverResetPass';
}

