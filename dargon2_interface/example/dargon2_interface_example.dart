import 'package:dargon2_interface/dargon2_interface.dart';

void main() {
  // Create an instance of TestDArgon2
  var dargon2 = TestDArgon2();
}

class TestDArgon2 extends DArgon2 {
  @override
  Future<DArgon2Result> hashPasswordBytes(List<int> password, {required Salt salt, int iterations = 32, int memory = 256, int parallelism = 2, int length = 32, Argon2Type type = Argon2Type.i, Argon2Version version = Argon2Version.V13}) {
    // Create an implementation for hashing passwords with the given parameters
    throw UnimplementedError();
  }

  @override
  Future<bool> verifyHashBytes(List<int> password, List<int> encodedHash, {Argon2Type type = Argon2Type.i}) {
    // Create an implementation for verifying passwords with the given parameters
    throw UnimplementedError();
  }
}
