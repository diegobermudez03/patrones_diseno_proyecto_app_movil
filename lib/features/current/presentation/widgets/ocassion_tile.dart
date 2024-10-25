import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

class OcassionTile extends StatelessWidget{

  final OcassionEntity ocassion;

  OcassionTile({
    super.key,
    required this.ocassion,
  });

  @override
  Widget build(BuildContext context) {
    final String type = ocassion.event != null ? AppStrings.event : AppStrings.booking;
    late final String content;
    if(ocassion.event != null){
      content = '${ocassion.event!.name} : ${ocassion.event!.address}';
    }
    else{
      String house = ocassion.booking!.isHouse ? AppStrings.house : AppStrings.apartment;
      content = '${house} : ${ocassion.booking!.address}';
    }
    final Color buttonColor = ocassion.isInside ? Colors.green : Colors.red;
    final String action = ocassion.isInside ? AppStrings.exit : AppStrings.enter;
    return Container(
      child: Column(
        children: [
          Text(type),
          Text(content),
          TextButton(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(buttonColor)
            ),
            onPressed: (){}, 
            child: Text(action)
          ),
        ],
      ),
    );
  }
}