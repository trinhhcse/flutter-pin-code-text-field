import 'package:flutter/material.dart';

class PinCodeTextField extends StatefulWidget {
  int numberOfCharacters;
  double characterWidth;
  double characterHorizontalSpacing;
  double fontSize;
  bool isTextObscure;
  Color placeHolderColor;
  Color characterColor;
  Color obscureColor;

  PinCodeTextField({this.numberOfCharacters : 6, this.characterWidth : 40.0, this.characterHorizontalSpacing = 10,
    this.fontSize : 45.0, this.isTextObscure: false, this.placeHolderColor : Colors.black26,this.characterColor : Colors.black,this.obscureColor : Colors.black});


  @override
  State<StatefulWidget> createState() {
    return _PinCodeTextFieldState();
  }
}
class _PinCodeTextFieldState extends State<PinCodeTextField>{

  List<String> _pin = [];
  TextEditingController _textController;


  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }


  @override
  void dispose() {

  }

  Widget getPinCodeWidget(int i, BuildContext context){

    if (_pin.length <= i  || widget.isTextObscure) {
      return getPlaceHolderOrObsecureWidgetForIndex(i);
    }
    return getCharacterWidgetForIndex(i);

  }

  Widget getPlaceHolderOrObsecureWidgetForIndex(int i) {
    return Container(
        width: widget.characterWidth,
        margin: getEdgeInsetDefaultForIndex(i),
        child: Center(
          child: Container(
            height: widget.characterWidth/1.5,
            width: widget.characterWidth/1.5,
            decoration: BoxDecoration(
                color:  i >= _pin.length ?  widget.placeHolderColor : widget.isTextObscure ? widget.obscureColor : widget.placeHolderColor,
                borderRadius: BorderRadius.circular(widget.characterWidth/2)
            ),
          ),
        )
    );
  }

  Widget getCharacterWidgetForIndex(int i) {

    return
      Container(
          width: widget.characterWidth,

          margin: getEdgeInsetDefaultForIndex(i),
          child: Center(
            child:  Text(
              _pin[i],
              style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.characterColor),
            ),
          )
      )
    ;
  }

  EdgeInsets getEdgeInsetDefaultForIndex(int i) {
    return i == 0 ? EdgeInsets.only( right: widget.characterHorizontalSpacing) : i == widget.numberOfCharacters - 1  ? EdgeInsets.only( left: widget.characterHorizontalSpacing) : EdgeInsets.symmetric(horizontal: widget.characterHorizontalSpacing);
  }

  Widget getMainTextFieldWidget() {
    return TextField(
      controller: _textController,
      decoration: InputDecoration(
          hintText: "",
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          counterText: ''
      ),

      textAlign: TextAlign.center,
      maxLength: widget.numberOfCharacters,
      style: TextStyle(
        color: Colors.transparent,
      ),
      cursorColor: Colors.transparent,
      onChanged: (String str) {
        setState(() {
          _pin = str.split("");
          print(_pin);
        });
      },
    );
  }

  Widget getPinCodeWidgets(BuildContext context){

    List<Widget> textFields = List.generate(widget.numberOfCharacters, (int i){
      return getPinCodeWidget(i, context);
    });

    return Stack(
      children: <Widget>[
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: textFields
        ),
        getMainTextFieldWidget()
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      child: getPinCodeWidgets(context),
    );
  }


}