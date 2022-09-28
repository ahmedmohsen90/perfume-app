import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfume/core/components/dropdown_widget.dart';
import 'package:perfume/core/components/loader_widget.dart';
import 'package:perfume/core/components/register_button.dart';
import 'package:perfume/core/components/register_field.dart';
import 'package:perfume/core/components/scaffold_widget.dart';
import 'package:perfume/core/components/sized_box_helper.dart';
import 'package:perfume/user/addresses/viewModel/areas/areas_cubit.dart';
import 'package:perfume/user/addresses/viewModel/cities/cities_cubit.dart';
import 'package:perfume/user/addresses/viewModel/createNewAddress/create_new_address_cubit.dart';

class CreateNewAddressScreen extends StatefulWidget {
  const CreateNewAddressScreen({super.key});
  static const routeName = '/create-new-address';

  @override
  State<CreateNewAddressScreen> createState() => _CreateNewAddressScreenState();
}

class _CreateNewAddressScreenState extends State<CreateNewAddressScreen> {
  late CreateNewAddressCubit createNewAddressCubit;
  late CitiesCubit citiesCubit;
  late AreasCubit areasCubit;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    createNewAddressCubit = context.read<CreateNewAddressCubit>();
    citiesCubit = context.read<CitiesCubit>()..getCities();
    areasCubit = context.read<AreasCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      scaffoldKey: scaffoldKey,
      body: SingleChildScrollView(
        child: Form(
          key: createNewAddressCubit.formKey,
          child: Column(
            children: [
              BlocBuilder<CitiesCubit, CitiesState>(
                builder: (context, state) {
                  if (state is CitiesLoading) {
                    return const LoaderWidget();
                  }
                  return DropDownWidget(
                    validator: createNewAddressCubit.cityValidate,
                    // enabled: citiesCubit.cities.isNotEmpty,
                    values: citiesCubit.cities.map((e) => e.name).toList(),
                    labelText: 'city',
                    onChanged: (index) {
                      if (index == null) {
                        return;
                      }
                      var city = citiesCubit.cities[index];
                      createNewAddressCubit.cityId = city.id;
                      areasCubit.getAreasByCityId(cityId: city.id);
                    },
                  );
                },
              ),
              BlocBuilder<AreasCubit, AreasState>(
                builder: (context, state) {
                  if (state is AreasLoading) {
                    return const LoaderWidget();
                  }
                  return DropDownWidget(
                    validator: createNewAddressCubit.areaValidate,
                    // enabled: areasCubit.areas.isNotEmpty,
                    values: areasCubit.areas.map((e) => e.name).toList(),
                    labelText: 'area',
                    onChanged: (index) {
                      if (index == null) {
                        return;
                      }
                      var area = areasCubit.areas[index];
                      createNewAddressCubit.areaId = area.id;
                    },
                  );
                },
              ),
              RegisterField(
                hintText: 'title',
                controller: createNewAddressCubit.titleController,
                validator: createNewAddressCubit.titleValidate,
              ),
              RegisterField(
                hintText: 'name',
                controller: createNewAddressCubit.nameController,
                validator: createNewAddressCubit.nameValidate,
              ),
              RegisterField(
                hintText: 'email',
                keyboardType: TextInputType.emailAddress,
                controller: createNewAddressCubit.emailController,
                validator: createNewAddressCubit.emailValidate,
              ),
              RegisterField(
                hintText: 'mobile',
                keyboardType: TextInputType.phone,
                controller: createNewAddressCubit.mobileController,
                validator: createNewAddressCubit.mobileValidate,
              ),
              RegisterField(
                hintText: 'street',
                controller: createNewAddressCubit.streetController,
                validator: createNewAddressCubit.streetValidate,
              ),
              RegisterField(
                hintText: 'apartment',
                controller: createNewAddressCubit.apartmentController,
                validator: createNewAddressCubit.apartmentValidate,
              ),
              RegisterField(
                hintText: 'block',
                controller: createNewAddressCubit.blockController,
                validator: createNewAddressCubit.blockValidate,
              ),
              const BoxHelper(
                height: 20,
              ),
              BlocBuilder<CreateNewAddressCubit, CreateNewAddressState>(
                builder: (context, state) {
                  if (state is CreateNewAddressLoading) {
                    return const LoaderWidget();
                  }
                  return RegisterButton(
                    color: Colors.white,
                    radius: 13,
                    onPressed: () => createNewAddressCubit.addNewAddress(
                      context,
                    ),
                    title: 'submit',
                  );
                },
              ),
              const BoxHelper(
                height: 250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
