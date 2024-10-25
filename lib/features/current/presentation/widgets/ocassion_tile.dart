import 'package:flutter/material.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/domain/entities/ocassion_entity.dart';

class OcassionTile extends StatelessWidget{

  final OcassionEntity ocassion;
  final void Function(int) callback;
  final int? loadingOcassionId;

  OcassionTile({
    super.key,
    required this.ocassion,
    required this.callback,
    required this.loadingOcassionId,
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
    final Color buttonColor = ocassion.isInside ? Colors.red : Colors.green;
    final String action = ocassion.isInside ? AppStrings.exit : AppStrings.enter;
    return Container(
      child: Column(
        children: [
          Text(type),
          Text(content),
          (loadingOcassionId != ocassion.ocassionId ? 
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(buttonColor)
              ),
              onPressed: ()=>callback(ocassion.ocassionId), 
              child: Text(action)
            ) :
            const CircularProgressIndicator()
          )
        ],
      ),
    );
  }
}