import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 50.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 26.0,
                color: pageController.page.round() == page ? Colors.amberAccent : Colors.white,
              ),
              SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: pageController.page.round() == page ? Colors.amber : Colors.white,
                  fontWeight: pageController.page.round() == page ? FontWeight.bold : FontWeight.normal
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
