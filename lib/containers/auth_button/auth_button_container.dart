import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:water_track/actions/auth_actions.dart';
import 'package:water_track/models/app_state.dart';
import 'package:water_track/containers/auth_button/google_auth_button.dart';
import 'package:redux/redux.dart';

class GoogleAuthButtonContainer extends StatelessWidget {
  GoogleAuthButtonContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        builder: (BuildContext context, _ViewModel vm){
          return new GoogleAuthButton(
            buttonText: vm.buttonText,
            onPressedCallback: vm.onPressedCallback,
          );
        },
        converter: _ViewModel.fromStore,
    );
  }
}

class _ViewModel {
  final String buttonText;
  final Function onPressedCallback;

  _ViewModel({this.buttonText, this.onPressedCallback});

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(
      buttonText:
      store.state.currentUser != null ? 'Log Out' : 'Log In with Google',
      onPressedCallback: () {
        if (store.state.currentUser != null) {
          store.dispatch(new LogOut());
        } else {
          store.dispatch(new LogIn());
        }
      }
    );
  }
}