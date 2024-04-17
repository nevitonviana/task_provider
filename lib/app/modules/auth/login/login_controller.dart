import '../../../core/notifier/default_change_notifier.dart';
import '../../../excption/auth_exception.dart';
import '../../../services/user/user_service.dart';

class LoginController extends DefaultChangeNotifier {
  final UserService _userService;
  String? infoMessage;

  LoginController({required UserService userService})
      : _userService = userService;

  bool get hasInfo => infoMessage != null;

  Future<void> login({required String email, required String password}) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
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

  Future<void> forgotPassword(String email) async {
    try {
      showLoadingAndResetState();
      infoMessage = null;
      notifyListeners();
      await _userService.forgotPassword(email);
      infoMessage = "resete de senha enviado para seu e-mail";
    } on AuthException catch (e) {
      setError(e.message);
    } catch (e) {
      setError("erro ao resetar da senha ");
    } finally {
      hideLoading();
      notifyListeners();
    }
  }
}
