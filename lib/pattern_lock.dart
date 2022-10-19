import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:pattern_lock/pattern_lock.dart';

class PatternMyLock extends StatefulWidget {
  const PatternMyLock({Key? key}) : super(key: key);

  @override
  _PatternMyLockState createState() => _PatternMyLockState();
}

class _PatternMyLockState extends State<PatternMyLock> {
  Future<void> localAuth(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final didAuthenticate = await localAuth.authenticate(
        localizedReason: 'Please authenticate',
        // biometricOnly: true,
        options: AuthenticationOptions(
            sensitiveTransaction: true, stickyAuth: true));
    if (didAuthenticate) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Screen Lock'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Wrap(
          spacing: 10,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) {
                  return ScreenLock(
                    correctString: '1234',
                    didCancelled: Navigator.of(context).pop,
                    didUnlocked: Navigator.of(context).pop,
                  );
                },
              ),
              child: const Text('Manualy open'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                canCancel: false,
              ),
              child: const Text('Not cancelable'),
            ),
            ElevatedButton(
              onPressed: () {
                // Define it to control the confirmation state with its own events.
                final inputController = InputController();
                screenLock(
                  context: context,
                  correctString: '',
                  confirmation: true,
                  inputController: inputController,
                  didConfirmed: (matchedText) {
                    // ignore: avoid_print
                    print(matchedText);
                  },
                  footer: TextButton(
                    onPressed: () {
                      // Release the confirmation state and return to the initial input state.
                      inputController.unsetConfirmed();
                    },
                    child: const Text('Return enter mode.'),
                  ),
                );
              },
              child: const Text('Confirm mode'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                customizedButtonChild: const Icon(
                  Icons.fingerprint,
                ),
                customizedButtonTap: () async {
                  await localAuth(context);
                },
                didOpened: () async {
                  await localAuth(context);
                },
              ),
              child: const Text(
                'use local_auth \n(Show local_auth when opened)',
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '123456',
                digits: '123456'.length,
                canCancel: false,
                footer: Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: OutlinedButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              child: const Text('Using footer'),
            ),
            ElevatedButton(
              onPressed: () {
                screenLock(
                  context: context,
                  title: const Text('change title'),
                  confirmTitle: const Text('change confirm title'),
                  correctString: '',
                  confirmation: true,
                  screenLockConfig: const ScreenLockConfig(
                    backgroundColor: Colors.deepOrange,
                  ),
                  secretsConfig: SecretsConfig(
                    spacing: 15, // or spacingRatio
                    padding: const EdgeInsets.all(40),
                    secretConfig: SecretConfig(
                      borderColor: Colors.amber,
                      borderSize: 2.0,
                      disabledColor: Colors.black,
                      enabledColor: Colors.amber,
                      height: 15,
                      width: 15,
                      build: (context, {required config, required enabled}) {
                        return SizedBox(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: enabled
                                  ? config.enabledColor
                                  : config.disabledColor,
                              border: Border.all(
                                width: config.borderSize,
                                color: config.borderColor,
                              ),
                            ),
                            padding: const EdgeInsets.all(10),
                            width: config.width,
                            height: config.height,
                          ),
                          width: config.width,
                          height: config.height,
                        );
                      },
                    ),
                  ),
                  keyPadConfig: KeyPadConfig(
                    buttonConfig: StyledInputConfig(
                      textStyle: StyledInputConfig.getDefaultTextStyle(context)
                          .copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                      buttonStyle: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.deepOrange,
                      ),
                    ),
                    displayStrings: [
                      '零',
                      '壱',
                      '弐',
                      '参',
                      '肆',
                      '伍',
                      '陸',
                      '質',
                      '捌',
                      '玖'
                    ],
                  ),
                  cancelButton: const Icon(Icons.close),
                  deleteButton: const Icon(Icons.delete),
                );
              },
              child: const Text('Customize styles'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                didUnlocked: () {
                  Navigator.pop(context);
                  NextPage.show(context);
                },
              ),
              child: const Text('Next page with unlock'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                withBlur: false,
                screenLockConfig: const ScreenLockConfig(
                  /// If you don't want it to be transparent, override the config
                  backgroundColor: Colors.black,
                ),
              ),
              child: const Text('Not blur'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                maxRetries: 2,
                retryDelay: const Duration(seconds: 3),
                delayBuilder: (context, delay) => Text(
                  'Cannot be entered for ${(delay.inMilliseconds / 1000).ceil()} seconds.',
                ),
              ),
              child: const Text('Delay next retry'),
            ),
            ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) {
                  return ScreenLock(
                    correctString: '1234',
                    keyPadConfig: const KeyPadConfig(
                      clearOnLongPressed: true,
                    ),
                    didUnlocked: Navigator.of(context).pop,
                  );
                },
              ),
              child: const Text('Delete long pressed to clear input'),
            ),
            ElevatedButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) {
                  return ScreenLock(
                    correctString: '1234',
                    secretsBuilder: (
                      context,
                      config,
                      length,
                      input,
                      verifyStream,
                    ) =>
                        SecretsWithCustomAnimation(
                      verifyStream: verifyStream,
                      config: config,
                      input: input,
                      length: length,
                    ),
                    didUnlocked: Navigator.of(context).pop,
                  );
                },
              ),
              child: const Text('Secrets custom animation widget'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                correctString: '1234',
                useLandscape: false,
              ),
              child: const Text('Disable landscape mode'),
            ),
            ElevatedButton(
              onPressed: () => screenLock(
                context: context,
                digits: 4,
                correctString: '',
                onValidate: (x) async {
                  // sleep(Duration(milliseconds: 500));
                  return '1234' == x;
                },
              ),
              child: const Text('Callback validation'),
            ),

          ],
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  static show(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NextPage()));
  }

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  bool authenicate = false;

  List<int> input = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    print(authenicate);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Next Page'),
        ),
        body: authenicate
            ? Text("You are authenicated")
            : PatternLock(
                // color of selected points.
                selectedColor: Colors.red,
                // radius of points.
                pointRadius: 8,
                // whether show user's input and highlight selected points.
                // showInput: true,
                // count of points horizontally and vertically.
                dimension: 3,
                // padding of points area relative to distance between points.
                relativePadding: 0.7,
                // needed distance from input to point to select point.
                selectThreshold: 25,
                // whether fill points.
                fillPoints: true,

                // callback that called when user's input complete. Called if user selected one or more points.
                onInputComplete: (List<int> inputS) {
                  print("pattern is $input");
                  print("inpurtn is $inputS");
                  print(input == inputS);
                  if (listEquals<int>(input, inputS)) {
                    setState(() {
                      authenicate = true;
                    });
                  }
                },
              ));
  }
}

class SecretsWithCustomAnimation extends StatefulWidget {
  const SecretsWithCustomAnimation({
    Key? key,
    required this.config,
    required this.length,
    required this.input,
    required this.verifyStream,
  }) : super(key: key);
  final SecretsConfig config;
  final int length;
  final ValueListenable<String> input;
  final Stream<bool> verifyStream;

  @override
  State<SecretsWithCustomAnimation> createState() =>
      _SecretsWithCustomAnimationState();
}

class _SecretsWithCustomAnimationState extends State<SecretsWithCustomAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    widget.verifyStream.listen((valid) {
      if (!valid) {
        // scale animation.
        _animationController.forward();
      }
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );

    _animation = Tween<double>(begin: 1, end: 2).animate(_animationController)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          }
        },
      );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Secrets(
        input: widget.input,
        length: widget.length,
        config: widget.config,
      ),
    );
  }
}
