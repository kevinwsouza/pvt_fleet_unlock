import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../shared/components/custom_app_bar.dart';
import '../../../../shared/components/custom_popup_unlock_car.dart';
import '../bloc/vehicles_list_controller.dart';
import '../bloc/vehicles_list_state.dart';
import '../../../../shared/mocks/vehicle_model.dart';

class VehiclesListPage extends StatefulWidget {
  final List<VehicleModel> vehicles;

  const VehiclesListPage({super.key, required this.vehicles});

  @override
  State<VehiclesListPage> createState() => _VehiclesListPageState();
}

class _VehiclesListPageState extends State<VehiclesListPage> {
  late List<VehicleModel> _filteredItems; // Lista filtrada
  final TextEditingController _searchController =
      TextEditingController(); // Controlador do campo de busca

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.vehicles; // Inicializa com todos os veículos
  }

  // Método para filtrar os veículos com base no texto digitado
  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = widget
            .vehicles; // Mostra todos os veículos se o campo de busca estiver vazio
      } else {
        _filteredItems = widget.vehicles
            .where((vehicle) => vehicle.carId
                .toLowerCase()
                .contains(query.toLowerCase())) // Filtra pela placa (carId)
            .toList();
      }
    });
  }

  // Método para exibir a popup
  void _showUnlockPopup(BuildContext context, VehicleModel vehicle) {
    showDialog(
      context: context,
      barrierDismissible: false, // Não permite fechar ao clicar fora
      builder: (context) => CustomPopupUnlockCar(
        carId: vehicle.carId,
        fleet: vehicle.fleet,
        onUnlock: () {
          // Ação de desbloqueio
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Veículo ${vehicle.carId} desbloqueado!')),
          );
        },
      ),
    );
  }

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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Campo de busca
                TextField(
                  controller: _searchController,
                  onChanged: _filterItems, // Chama o filtro ao digitar
                  decoration: InputDecoration(
                    hintText: 'Pesquisar veículo por placa',
                    suffixIcon: const Icon(Icons.search,
                        color: Colors.blue), // Ícone azul no final
                    filled: true, // Preenche o fundo do campo
                    fillColor: const Color(
                        0xFFEEEEEE), // Cinza um pouco mais escuro para o fundo
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none, // Remove a borda
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0), // Ajusta o espaçamento interno
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment:
                      Alignment.centerLeft, // Alinha o texto no canto direito
                  child: Text(
                    'Selecione o veículo\nque será desbloqueado', // Quebra de linha manual
                    textAlign: TextAlign.left, // Alinha o texto à direita
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Lista de veículos
                Expanded(
                  child: _filteredItems.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum veículo encontrado',
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.black54),
                          ),
                        )
                      : ListView.builder(
                          itemCount: _filteredItems.length,
                          itemBuilder: (context, index) {
                            final vehicle = _filteredItems[index];
                            return GestureDetector(
                              onTap: () {
                                _showUnlockPopup(context,
                                    vehicle); // Exibe a popup ao clicar
                              },
                              child: Card(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      12.0), // Bordas arredondadas
                                ),
                                elevation: 2, // Sombra do card
                                child: Padding(
                                  padding: const EdgeInsets.all(
                                      16.0), // Espaçamento interno
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/local_shipping.svg',
                                        width: 40,
                                        height: 40,
                                      ),
                                      const SizedBox(
                                          width:
                                              16), // Espaçamento entre o ícone e o texto
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${vehicle.carId} / ${vehicle.fleet}',
                                              style: const TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Co-piloto ${vehicle.serialCoPilot}',
                                              style: const TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
