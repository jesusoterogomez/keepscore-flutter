import 'package:flutter/material.dart';
import 'package:keepscore/bloc/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = AuthProvider.of(context);

    return StreamBuilder(
      stream: bloc.status,
      // initialData: bloc.,
      builder: (BuildContext context, AsyncSnapshot<AuthStatus> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Me'),
          ),
          body: Center(
            child: Stack(
              children: [
                Text(
                  'Status:' + snapshot.data.toString(),
                ),
                ElevatedButton(
                  onPressed: () => bloc.logInWithGoogle(),
                  child: Text('Log in with Google'),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     child: BlocBuilder<AuthBloc, AuthState>(
  //       // buildWhen: (previous, current) => previous.status != current.status,
  //       builder: (context, state) {
  //         return Column(
  //           children: [
  //             Text(
  //               state.status.toString(),
  //             ),
  //             ElevatedButton(
  //               onPressed: onPressed,
  //               child: Text('Press me, bitch'),
  //             ),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }
}

// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: BlocListener<AuthBloc, AuthState>(

//         listener: (context, state) {
//           switch (state.status) {
//             case AuthStatus.authenticated:
//               log('authenticated');
//               break;
//             case AuthStatus.unauthenticated:
//               log('unauthenticated 2');
//               break;
//             default:
//               break;
//           }
//         },
//         child: Center(
//           child: Text('non woot'),
//         ),
//       ),
//     );
//   }
// }
