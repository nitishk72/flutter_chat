import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onTap;

  const MyListTile({
    Key key,
    @required this.title,
    this.subtitle,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 6.0,
            horizontal: 4.0,
          ),
          child: Row(
            children: [
              CircleAvatar(
                child: Text('${title[0]}'),
              ),
              SizedBox(width: 10.0),
              subtitle == null
                  ? Text(
                      '$title',
                      style: TextStyle(fontSize: 18.0),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$title',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Text(
                          '$subtitle',
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
