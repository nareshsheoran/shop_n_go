// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, avoid_print, library_prefixes

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_place/google_place.dart';
import 'package:google_maps_webservice/places.dart' as Component;
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shop_n_go/home_page_dir/map_dir/model/near_by_stores_req.dart';
import 'package:shop_n_go/home_page_dir/map_dir/model/vendor_profile_req.dart';
import 'package:shop_n_go/shared/auth/constant.dart';
import 'package:shop_n_go/shared/auth/routes.dart';
import 'package:shop_n_go/shared/shared_preference_data/address_localdb.dart';


class MapSearchPage extends StatefulWidget {
  const MapSearchPage({Key? key}) : super(key: key);

  @override
  State<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends State<MapSearchPage> {
  List<Placemark> placeMarks = [];
  TextEditingController searchController = TextEditingController();
  String googleApikey = "AIzaSyCY-SmJ29RYyqiwa3S8I9WblOlnR-Eqbhw";
  String location = "Search Location";
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  final Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  static const LatLng _center = LatLng(28.601147, 75.662925);

  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;

  MapType _currentMapType = MapType.normal;
  double? longitude;
  double? latitude;

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    dataNearByStoresList.clear();
    vendorProfileList.clear();
    _markers.clear();
    _lastMapPosition.longitude;
    _lastMapPosition.latitude;
    setState(() {
      _markers.add(Marker(
        position: _lastMapPosition,
        draggable: true,
        flat: true,
        markerId: MarkerId(_lastMapPosition.toString()),
        visible: true,
        // infoWindow: InfoWindow(
        //   title: placeMarks.first.subAdministrativeArea.toString(),
        // snippet: '5 Star Rating',
        // ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      longitude = _lastMapPosition.longitude;
      latitude = _lastMapPosition.latitude;

      fetchNearByStoresDetails(
          _lastMapPosition.longitude, _lastMapPosition.latitude);
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    setState(() {
      controller = mapController!;
    });
  }

  void autoCompleteSearch(String value) async {
    // var result = await googlePlace?.autocomplete.get(value);
    var result = await googlePlace?.queryAutocomplete.get(value);
    // var result = await googlePlace?.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  GooglePlace? googlePlace;
  List<AutocompletePrediction> predictions = [];

  Future dotEnv() async {
    await dotenv.load(fileName: 'assets/.env');
  }

  @override
  void initState() {
    // String? apiKey = dotenv.env[googleApikey];
    dotEnv();
    // String? apiKey = DotEnv().env[googleApikey];
    // String? apiKey =googleApikey;
    // print("apiKey $apiKey");
    // googlePlace = GooglePlace(apiKey!);
    _onAddMarkerButtonPressed();
    print("googlePlace $googlePlace");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 350,
                  width: MediaQuery.of(context).size.width,
                  child: GoogleMap(
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,

                    // onMapCreated: _onMapCreated,
                    // onMapCreated: (GoogleMapController controller) {
                    //   setState(() {
                    //     _googleMapController.complete(controller);
                    //   });
                    // },
                    onMapCreated: (controller) {
                      setState(() {
                        mapController = controller;
                      });
                    },
                    mapType: _currentMapType,
                    markers: _markers,
                    onCameraMove: _onCameraMove,
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 11.0,
                    ),
                    onCameraIdle: () async {
                      // List<Placemark> placeMarks =
                      placeMarks = await placemarkFromCoordinates(
                          _lastMapPosition.latitude,
                          _lastMapPosition.longitude);
                      setState(() {
                        // location =
                        //     placeMarks.first.administrativeArea.toString() +
                        //         ", " +
                        //         placeMarks.first.street.toString();
                      });
                    },
                  ),
                ),
                Positioned(
                    top: 75,
                    right: 8,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: _onMapTypeButtonPressed,
                                child: Icon(
                                  Icons.map,
                                  size: 28,
                                  color: Colors.grey,
                                )),
                            Divider(
                                color: Constant.primaryColor,
                                thickness: 1,
                                endIndent: 2,
                                indent: 2),
                            InkWell(
                                onTap: _onAddMarkerButtonPressed,
                                child: Icon(
                                  Icons.add_location,
                                  size: 28,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    )),
                Positioned(
                  top: 4,
                  right: 6,
                  left: 6,
                  child: InkWell(
                    onTap: () async {
                      var place = await PlacesAutocomplete.show(
                          context: context,
                          apiKey: googleApikey,
                          mode: Mode.overlay,
                          types: [],
                          strictbounds: false,
                          components: [
                            Component.Component("Component.country", "ind")
                          ],
                          //google_map_webservice package
                          onError: (err) {
                            print(
                                "Error:$err       ,errorMessage:${err.errorMessage}");
                          });

                      if (place != null) {
                        setState(() {
                          location = place.description.toString();
                        });

                        //form google_maps_webservice package
                        final plist = GoogleMapsPlaces(
                          apiKey: googleApikey,
                          apiHeaders: await GoogleApiHeaders().getHeaders(),
                          //from google_api_headers package
                        );
                        String placeId = place.placeId ?? "0";
                        final detail = await plist.getDetailsByPlaceId(placeId);
                        final geometry = detail.result.geometry!;
                        final lat = geometry.location.lat;
                        final lang = geometry.location.lng;
                        var newLatLang = LatLng(lat, lang);

                        //move map camera to selected place with animation
                        mapController?.animateCamera(
                            CameraUpdate.newCameraPosition(
                                CameraPosition(target: newLatLang, zoom: 17)));
                      }
                    },
                    child: SingleChildScrollView(
                      child: Card(
                        child: Container(
                            padding: EdgeInsets.all(0),
                            width: MediaQuery.of(context).size.width - 40,
                            child: ListTile(
                              title: Text(
                                location,
                                style: TextStyle(fontSize: 18),
                              ),
                              trailing: Icon(Icons.search),
                              dense: true,
                            )),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  //   child: Card(
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //           // color: Colors.grey.shade200,
                  //           borderRadius: BorderRadius.circular(4)),
                  //       height: 40,
                  //       width: MediaQuery.of(context).size.width,
                  //       child: TextField(
                  //         controller: searchController,
                  //         onChanged: (value) {
                  //           if (value.isNotEmpty) {
                  //             autoCompleteSearch(value);
                  //           } else {
                  //             if (predictions.isNotEmpty && mounted) {
                  //               setState(() {
                  //                 predictions = [];
                  //               });
                  //             }
                  //           }
                  //         },
                  //         textCapitalization: TextCapitalization.sentences,
                  //         decoration: const InputDecoration(
                  //             prefixIcon: Icon(Icons.menu),
                  //             suffixIcon: Icon(Icons.search),
                  //             contentPadding: EdgeInsets.symmetric(
                  //                 horizontal: 16, vertical: 6),
                  //             hintText: 'Search Location',
                  //             border: InputBorder.none),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Near By Stores:",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                  ),
                  placeMarks.isEmpty
                      ? Text("")
                      : Text(placeMarks.first.subAdministrativeArea.toString())
                ],
              ),
            ),

            // (predictions.isNotEmpty)
            //     ? Expanded(
            //         child: ListView.builder(
            //           itemCount: predictions.length,
            //           itemBuilder: (context, index) {
            //             return ListTile(
            //               leading: CircleAvatar(
            //                 child: Icon(
            //                   Icons.pin_drop,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //               title: Text(predictions[index].description!),
            //               subtitle: Text(predictions[index].placeId!),
            //               onTap: () {
            //                 debugPrint(predictions[index].placeId);
            //                 // Navigator.push(
            //                 //   context,
            //                 //   MaterialPageRoute(
            //                 //     builder: (context) => DetailsPage(
            //                 //       placeId: predictions[index].placeId,
            //                 //       googlePlace: googlePlace,
            //                 //     ),
            //                 //   ),
            //                 // );
            //               },
            //             );
            //           },
            //         ),
            //       )
            //     :
            (isLoading || isProfileLoading)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 1.5,
                    child: Center(
                        child: CProgressIndicator.circularProgressIndicator))
                : Expanded(
                    child: ListView.builder(
                      itemCount: vendorProfileList.length,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.MapStoreDetailsPage,
                                arguments:
                                    // "${Images.baseUrl}${dataNearByStoresList[index].vendorProfile}");
                                    vendorProfileList[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            child: Card(
                              elevation: CardDimension.elevation,
                              shadowColor: CardDimension.shadowColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(
                                                "${vendorProfileList[index].vendorName}",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Icon(Icons.alarm,
                                            size: IconDimension.iconSize),
                                        SizedBox(width: 8),
                                        Text(
                                            "${vendorProfileList[index].openTime!.substring(0, 5)}-${vendorProfileList[index].closeTime!.substring(0, 5)}"),
                                      ],
                                    ),
                                    SizedBox(height: 6),
                                    Row(
                                      children: [
                                        Image(
                                            height: 70,
                                            width: 70,
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                "${Images.baseUrl}${vendorProfileList[index].vendorProfile}")),
                                        SizedBox(width: 14),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.directions,
                                                      size: IconDimension
                                                          .iconSize),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                      child: Text(
                                                          "${vendorProfileList[index].distance}")),
                                                  Icon(Icons.card_travel,
                                                      size: IconDimension
                                                          .iconSize),
                                                  SizedBox(width: 8),
                                                  vendorProfileList[index]
                                                              .noOfProducts! <=
                                                          1
                                                      ? Text(
                                                          "${vendorProfileList[index].noOfProducts} Item")
                                                      : Text(
                                                          "${vendorProfileList[index].noOfProducts} Items"),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.shopping_cart,
                                                      size: IconDimension
                                                          .iconSize),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                      child: Text(
                                                          "Min. order ${AppDetails.currencySign}${vendorProfileList[index].minimumOrder}")),
                                                ],
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(
                                                      Icons
                                                          .directions_bike_sharp,
                                                      size: IconDimension
                                                          .iconSize),
                                                  SizedBox(width: 8),
                                                  Text(vendorProfileList[index]
                                                      .isHomeDelivery!)
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
  }

  bool isLoading = false;
  List<NearByStoresReqData> dataNearByStoresList = [];

  Future fetchNearByStoresDetails(longitudeAxis, latitudeAxis) async {
    setState(() {
      isLoading = true;
    });

    String user = ProfileDetails.id!;
    // String longitude = longitudeAxis.toString();
    String longitude = (38.4313975).toString();
    // String latitude = latitudeAxis.toString();
    String latitude = (1.4419683).toString();

    var requestBody = {
      'consumer_id': user,
      'longitude': longitude,
      'latitude': latitude,
    };

    Uri myUri = Uri.parse(NetworkUtil.getNearByStoreUrl);
    http.Response response = await http.post(
      myUri,
      body: requestBody,
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      NearByStoresReq nearByStoresReq = NearByStoresReq.fromJson(jsonResponse);
      if (nearByStoresReq.statusCode == 200) {
        List<NearByStoresReqData> list = nearByStoresReq.data!;
        dataNearByStoresList.addAll(list);

        AddressLocalDataSaver.saveLongitude(longitude);
        AddressLocalDataSaver.saveLatitude(latitude);
        MapDetails.longitude = (await AddressLocalDataSaver.getLongitude())!;
        MapDetails.latitude = (await AddressLocalDataSaver.getLatitude())!;
        print("MapDetails.longitude:${MapDetails.longitude}");
        print("MapDetails.latitude:${MapDetails.latitude}");
        fetchVendorProfile();
      } else if (nearByStoresReq.statusCode == 400) {
        Fluttertoast.showToast(msg: nearByStoresReq.message!);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  VendorProfileReqData? vendorProfileReqData;
  List<VendorProfileReqData> vendorProfileList = [];
  bool isProfileLoading = false;

  Future fetchVendorProfile() async {
    setState(() {
      isProfileLoading = true;
    });
    for (int i = 0; i < dataNearByStoresList.length; i++) {
      Uri myUri = Uri.parse(
          "${NetworkUtil.getVendorProfileUrl}${dataNearByStoresList[i].vendorId}");
      Response response = await get(myUri);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        VendorProfileReq vendorProfileReq =
            VendorProfileReq.fromJson(jsonResponse);
        vendorProfileReqData = vendorProfileReq.data!;
        vendorProfileList.add(vendorProfileReqData!);

        setState(() {
          (dataNearByStoresList.length == vendorProfileList.length)
              ? isProfileLoading = false
              : isProfileLoading = true;
        });
      }
    }
  }
}
