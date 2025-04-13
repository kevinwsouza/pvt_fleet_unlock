import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/custom_app_bar.dart';
import '../bloc/vehicles_list_controller.dart';
import '../bloc/vehicles_list_state.dart';
import '../../../../shared/mocks/vehicle_model.dart';

class VehiclesListPage extends StatelessWidget {
  final List<VehicleModel> vehicles;

  const VehiclesListPage({super.key, required this.vehicles});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesListController, VehiclesListState>(
      builder: (context, state) {
        if (state is VehiclesListLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is VehiclesListErrorState) {
          return const Center(child: Text('Erro ao carregar veículos.'));
        }

        return Scaffold(
          appBar: const CustomAppBar(
            showBackButton: true,
            showLogoutButton: true,
          ),
          body: ListView.builder(
            itemCount: vehicles.isEmpty ? 1 : vehicles.length,
            itemBuilder: (context, index) {
              if (vehicles.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Nenhum veículo disponível.',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }

              final vehicle = vehicles[index];
              return ListTile(
                title: Text(vehicle.fleet),
                subtitle: Text(vehicle.carId),
              );
            },
          ),
        );
      },
    );
  }
}