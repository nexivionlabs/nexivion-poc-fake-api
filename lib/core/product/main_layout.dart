import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
    this.appBar,
    this.content,
    this.padding,
    this.alignment,
    this.backgroundColor,
    this.safeAreaBottomActivated = false,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomSheet,
    this.disableSafeArea = true,
    this.disableTopSafeArea = false, // YENİ: Sadece üst safe area'yı kontrol et
    this.resizeToAvoidBottomInset,
    this.isScrollable = false,
    this.defaultHorizontalPadding = 16.0,
    this.useDefaultPadding = true,
  });

  final PreferredSizeWidget? appBar;
  final Widget? content;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final bool safeAreaBottomActivated;
  final bool disableSafeArea;
  final bool disableTopSafeArea; // YENİ: Üst safe area kontrolü
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool isScrollable;
  final double defaultHorizontalPadding;
  final bool useDefaultPadding;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  @override
  void initState() {
    super.initState();
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  EdgeInsetsGeometry _getDefaultPadding() {
    if (!widget.useDefaultPadding) {
      return widget.padding ?? EdgeInsets.zero;
    }

    final defaultPadding = EdgeInsets.symmetric(
      horizontal: widget.defaultHorizontalPadding,
    );

    if (widget.padding != null) {
      return widget.padding!;
    }

    return defaultPadding;
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        bottomSheet: widget.bottomSheet,
        backgroundColor: widget.backgroundColor ?? Colors.white,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        appBar: widget.appBar,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButton: widget.floatingActionButton,
        body: Stack(
          children: [
            SafeArea(
              bottom: widget.safeAreaBottomActivated,
              top: !widget.disableSafeArea &&
                  !widget.disableTopSafeArea, // Üst safe area kontrolü
              left: !widget.disableSafeArea,
              right: !widget.disableSafeArea,
              child: Container(
                alignment: widget.alignment,
                child: _buildContentWithConditionalPadding(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentWithConditionalPadding() {
    if (widget.content == null) return Container();

    return widget.isScrollable
        ? SingleChildScrollView(
      child: Container(
        padding: _getDefaultPadding(),
        child: widget.content,
      ),
    )
        : Container(
      padding: _getDefaultPadding(),
      child: widget.content,
    );
  }
}