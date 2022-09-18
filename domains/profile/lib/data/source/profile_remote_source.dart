abstract class ProfileRemoteSource {
  const ProfileRemoteSource();

  Future<UserResponseDTO> getUser();
}