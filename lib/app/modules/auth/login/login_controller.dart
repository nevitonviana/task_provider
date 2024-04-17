import '../../../core/notifier/default_change_notifier.dart';
import '../../../excption/auth_exception.dart';
import '../../../services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;

  LoginController({required UserService userService})
      : _userService = userService;

  Future<void> login({required String email, required String password}) async {
    try {
      showLoadingAndResetState();

      notifyListeners();
      final user = await _userService.login(email, password);

      if (user != null) {
        success();
      } else {
        setError("Usuario ou senha inlavido");
      }
    } on AuthException catch (e) {
      setError(e.message);
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
