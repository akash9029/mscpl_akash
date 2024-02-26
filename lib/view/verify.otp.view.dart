import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPView extends StatefulWidget {
  final String mobNumber;
  const VerifyOTPView({super.key, required this.mobNumber});

  @override
  State<VerifyOTPView> createState() => _VerifyOTPViewState();
}

class _VerifyOTPViewState extends State<VerifyOTPView> {
  TextEditingController otpController = TextEditingController();
  int _minutes = 2;
  int _seconds = 50;
  Timer? _timer;
  bool showResultCard = false;
  bool? validOtp;
  bool showVerificationTimer = true;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  startTimer() {
    _timer?.cancel();
    setState(() {
      _minutes = 2;
      _seconds = 50;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_minutes == 0 && _seconds == 0) {
          _timer!.cancel();
        } else if (_seconds == 0) {
          _minutes--;
          _seconds = 59;
        } else {
          _seconds--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Verify your phone",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Enter the verification code sent to',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              maskPhoneNumber(widget.mobNumber),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  color: !showResultCard
                      ? Colors.transparent
                      : validOtp == true
                          ? Colors.green
                          : Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: PinCodeTextField(
                      textStyle: Theme.of(context).textTheme.bodyLarge,
                      autoFocus: true,
                      autoDisposeControllers: false,
                      hapticFeedbackTypes: HapticFeedbackTypes.medium,
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      animationType: AnimationType.fade,
                      errorTextSpace: 10,
                      pinTheme: PinTheme(
                        selectedFillColor: Colors.white,
                        selectedColor: Colors.blue,
                        errorBorderWidth: 1,
                        activeColor: const Color.fromRGBO(242, 244, 247, 1),
                        inactiveFillColor:
                            const Color.fromRGBO(242, 244, 247, 1),
                        activeBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 50,
                        fieldWidth: 50,
                        activeFillColor: const Color.fromRGBO(242, 244, 247, 1),
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      controller: otpController,
                      keyboardType: TextInputType.number,
                      boxShadows: const [
                        BoxShadow(
                          offset: Offset(0, 1),
                          color: Colors.black12,
                          blurRadius: 10,
                        )
                      ],
                      onChanged: (value) {
                        if (value.length <= 4) {
                          setState(() {
                            showResultCard = false;
                          });
                        }
                      },
                      onCompleted: (v) {
                        showResultCard = true;
                        showVerificationTimer = false;
                        if (otpController.text == "934477") {
                          validOtp = true;
                        } else {
                          validOtp = false;
                        }
                        setState(() {});
                      },
                      beforeTextPaste: (text) {
                        return true;
                      },
                    ),
                  ),
                  showResultCard
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                validOtp == true ? Icons.done : Icons.close,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                validOtp == true ? 'Verified' : 'Invalid OTP',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      : const Offstage()
                ],
              ),
            ),
            showResultCard
                ? const SizedBox(
                    height: 15,
                  )
                : const Offstage(),
            showVerificationTimer
                ? Center(
                    child: Text(
                      'Verification code expires in $_minutes:${_seconds.toString().padLeft(2, '0')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : const Offstage(),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  startTimer();
                  setState(() {
                    showVerificationTimer = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.grey,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  side: BorderSide(
                      color: const Color.fromARGB(255, 210, 209, 209)
                          .withOpacity(0.6)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Resend Code',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.grey,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                      color: const Color.fromARGB(255, 210, 209, 209)
                          .withOpacity(0.6)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'Change number',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  String maskPhoneNumber(String phoneNumber) {
    String maskedNumber =
        '(${phoneNumber.substring(0, 1)}**) *** - **${phoneNumber.substring(8)}';

    return maskedNumber;
  }
}
