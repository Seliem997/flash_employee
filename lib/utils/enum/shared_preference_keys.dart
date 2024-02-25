enum CacheKey {
  loggedIn('loggedIn'),
  showOnBoarding('showOnBoarding'),
  language('language'),
  hasVehicle('hasVehicle'),
  userName('userName'),
  userImage('userImage'),
  userId('userId'),
  email('email'),
  token('token'),
  phoneNumber('phoneNumber'),
  countryCode('countryCode'),
  empId('empId'),
  busNo('busNo'),
  madaMachineId('madaMachineId'),
  stcId('stcId'),
  rate('rate'),
  position('position'),
  address('address'),
  hasAddress('hasAddress'),
  darkMode('darkMode'),
  rentalBalance('rentalBalance');

  const CacheKey(this.key);
  final String key;
}
