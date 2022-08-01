part of sakura_button;

///
/// [LoadingButton] is a widget that provides an indicator at run time.
///
/// use it:
/// ```
/// LoadingButton(
///   "Login",
///   onPressed: () async {
///     // Asynchronous processing
///     await Login();
///   },
/// )
/// ```
///
class LoadingButton extends HookWidget {
  const LoadingButton(
    this.title, {
    Key? key,
    this.buttonType = ButtonType.primary,
    this.buttonSize = ButtonSize.medium,
    required this.onPressed,
    this.onLongPress,
    this.enabled = true,
    this.child,
    this.padding,
  }) : super(key: key);

  final String title;
  final Future Function() onPressed;
  final VoidCallback? onLongPress;

  final ButtonType buttonType;
  final ButtonSize buttonSize;

  final bool enabled;
  final Widget? child;

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return LazyFutureBuilder(
      lazyFuture: () async {
        await onPressed();
      },
      builder: (context, future, isFutureExecuting) {
        return Button(
          title,
          enabled: enabled,
          buttonType: buttonType,
          buttonSize: buttonSize,
          onPressed: future,
          onLongPress: onLongPress,
          padding: padding,
          child: isFutureExecuting
              ? Indicator(
                  radius: buttonSize.indicatorSize,
                  color: buttonType.indicatorColor(themeData),
                )
              : child,
        );
      },
    );
  }
}
