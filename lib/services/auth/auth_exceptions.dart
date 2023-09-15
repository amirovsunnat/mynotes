// login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// sign up exceptions
class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

//  for both login and sign up
class TooManyRequestsAuthException implements Exception {}

class UserDisabledAuthException implements Exception {}

class ChannelErrorAuthException implements Exception {}

class InvalidEmaildAuthException implements Exception {}

// generic exceptions
class GenericAuthExceptions implements Exception {}

class UserNotLoggedInAuthExceptions implements Exception {}
