
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kairos/models/event.dart';
import 'package:kairos/ui/Calendar/themes.dart';

class EventTile extends StatefulWidget {
  final Event? event;
  // EventTile(this.event)
  const EventTile({super.key, required this.event});

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(widget.event?.color??0),

        ),
        child: Row(children: [
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event?.title??"",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),

                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        "${widget.event!.starTime} - ${widget.event!.endTime}",
                        style: GoogleFonts.lato(
                          textStyle:
                            TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),

                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.event?.note??"",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 15,
                      color: Colors.grey[100])
                    ),
                  )
                ],
              ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            height:  60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
              quarterTurns: 3,
              child: Text(
                widget.event!.isConpleted == 1 ? "COMPLETED" : "TODO",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )
                ),
              ),
          )
        ],),

      ),

    );
  }

  _getBGClr(int no){
    switch(no){
      case 0:
        return bluishClr;
      case 1:
        return redClr;
      case 2:
        return orangeClr;

      default:
        return bluishClr;
    }
  }
}
