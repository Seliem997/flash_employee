enum ServiceType {
  wash('Wash'),
  otherService('Other Service');

  const ServiceType(this.key);
  final String key;
}

const serviceTypes = [ServiceType.wash, ServiceType.otherService];
