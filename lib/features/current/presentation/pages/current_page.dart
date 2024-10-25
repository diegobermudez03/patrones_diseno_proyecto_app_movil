import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/core/app_strings.dart';
import 'package:mobile_app/features/current/presentation/state/current_bloc.dart';
import 'package:mobile_app/features/current/presentation/state/current_states.dart';
import 'package:mobile_app/features/current/presentation/widgets/ocassion_tile.dart';

class CurrentPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentBloc,CurrentState>(builder: (context, state){
        final provider = BlocProvider.of<CurrentBloc>(context);
        if(state is CurrentInitialState){
          provider.seekOcassions();
        }
        return switch(state){
          CurrentLoadingState _ => Center(child: CircularProgressIndicator(),),
          CurrentRetrieveFailure _ => Center(child: Text(AppStrings.apiError),),
          CurrentRetrieveSuccess(ocassions: final ocassions) => SingleChildScrollView(
            child: Column(
              children: ocassions.map((oc)=> OcassionTile(ocassion: oc)).toList(),
            ),
          ),
          CurrentState _ =>  Center(child: CircularProgressIndicator(),),
        };
      }),
    );
  }
}