// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungoschekstork/models/product_model.dart';
import 'package:ungoschekstork/utility/my_constant.dart';
import 'package:ungoschekstork/utility/my_dialog.dart';
import 'package:ungoschekstork/widgets/show_icon_button.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:ungoschekstork/widgets/show_image_network.dart';
import 'package:ungoschekstork/widgets/show_text.dart';

class MainService extends StatefulWidget {
  const MainService({
    Key? key,
  }) : super(key: key);

  @override
  State<MainService> createState() => _MainServiceState();
}

class _MainServiceState extends State<MainService> {
  ProductModel? productModel;
  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ShowIconButton(
            iconData: Icons.qr_code_scanner,
            pressFunc: () async {
              print('You Press QR button');
              await scanner.scan().then((value) async {
                print('## value => $value');

                if (productModel != null) {}

                await FirebaseFirestore.instance
                    .collection('product')
                    .where('qrcode', isEqualTo: value)
                    .get()
                    .then((value2) {
                  print('## value2 ==>  ${value2.docs}');

                  if (value2.docs.isNotEmpty) {
                    for (var item in value2.docs) {
                      productModel = ProductModel.fromMap(item.data());
                    }
                    
                    setState(() {});
                  } else {
                    MyDialog(context: context).myShowModalButtonSheet(
                        title: 'No $value',
                        subTitle: 'In my Database',
                        firstButton: 'OK',
                        pressFunc: () {
                          Navigator.pop(context);
                        });
                  }
                });
              });
            },
          )
        ],
      ),
      body: productModel == null
          ? const SizedBox()
          : LayoutBuilder(builder: (context, constraints) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  newTitle(head: 'Name :', value: productModel!.name),
                  newTitle(head: 'Address :', value: productModel!.address),
                  newTitle(head: 'QRcode :', value: productModel!.qrcode),
                  newTitle(
                      head: 'Stock :',
                      value: '${productModel!.stock} ${productModel!.unit}'),
                  ShowImageNetWork(
                    path: productModel!.urlpic,
                  ),
                  newTitle(
                      head: 'Position :',
                      value:
                          'lat = ${productModel!.latlng.latitude} \n lng = ${productModel!.latlng.longitude}'),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(border: Border.all()),
                    width: constraints.maxWidth - 32,
                    height: constraints.maxWidth - 32,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          productModel!.latlng.latitude,
                          productModel!.latlng.longitude,
                        ),
                        zoom: 14,
                      ),
                      onMapCreated: (value) {
                        googleMapController = value;
                        setState(() {});
                      },
                      markers: mySetMarkers(),
                    ),
                  ),
                ],
              );
            }),
    );
  }

  Set<Marker> mySetMarkers() {
    // ignore: prefer_collection_literals
    return <Marker>[
      Marker(
        markerId: const MarkerId('id'),
        position: LatLng(
            productModel!.latlng.latitude, productModel!.latlng.longitude),
      ),
    ].toSet();
  }

  Row newTitle({required String head, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ShowText(
            text: head,
            textStyle: MyConstant().h2Style(),
          ),
        ),
        Expanded(
          flex: 2,
          child: ShowText(text: value),
        ),
      ],
    );
  }
}
