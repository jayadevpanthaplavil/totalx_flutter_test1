import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:totalx_flutter_test1/ui/screens/login_and_verify_otp/login_and_verify_otp_viewmodel.dart';
import '../ui/screens/home/home_viewmodel.dart';


List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => LoginAndVerifyOtpViewModel()),
  ChangeNotifierProvider(create: (_) => HomeViewModel()),
];