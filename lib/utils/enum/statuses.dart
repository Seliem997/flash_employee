enum Status {
  success("success"),
  error('error'),
  loading('loading'),
  codeSent('codeSent'),
  emailAlreadyInUse('emailAlreadyInUse'),
  invalidEmailOrPass('invalidEmailOrPass'),
  employeeNotActive('employeeNotActive'),
  emailNotRegistered('emailNotRegistered'),
  codeNotCorrect('codeNotCorrect'),
  phoneAlreadyInUse('phoneAlreadyInUse');

  const Status(this.key);
  final String key;
}
