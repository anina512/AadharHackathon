import 'package:flutter/material.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({Key? key}) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  Map addressInfo={};
  String address='';
  List addressParts=[];
  var addressPartsLength=0;
  List modifiedAddressParts=List.filled(8, "", growable: false);
  List finalAddress=[];



  @override

  Widget build(BuildContext context) {
    addressInfo = ModalRoute.of(context)!.settings.arguments as Map;
    address=addressInfo['address'];
    addressParts=address.split(',');
    addressPartsLength=addressParts.length;
    print(modifiedAddressParts);

    for(int i =0;i<addressPartsLength;i++){print(addressParts[i]);}
    modifiedAddressParts=List.from(addressParts);
    print(addressPartsLength);
    if(addressPartsLength<8){
      for(int i=0;i<(8-addressPartsLength);i++){
        modifiedAddressParts.add(null);
      }
    }
    print(modifiedAddressParts);
    return Scaffold(
            appBar: AppBar(
              title: const Text('Edit your address'),
            ),
            body: Padding(
                padding: const EdgeInsets.all(32),
                child: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("House / Bldg./Apt"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[0],
                                onChanged: (text){finalAddress[0]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Street/Road/Lane"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[1],
                                onChanged: (text){finalAddress[1]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: <Widget>[
                            Text("Landmark"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[2],
                                onChanged: (text){finalAddress[2]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: <Widget>[
                            Text("Area/locality/sector"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[3] ,
                                onChanged: (text){finalAddress[3]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: <Widget>[
                            Text("Village/Town /City"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[4],
                                onChanged: (text){finalAddress[4]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("District"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[5] ,
                                onChanged: (text){finalAddress[5]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: <Widget>[
                            Text("State"), SizedBox(width: 40,),
                            Container(
                              width: 200,
                              child: TextFormField(
                                initialValue: modifiedAddressParts[6],
                                onChanged: (text){finalAddress[6]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: Maharashtra',
                                ),
                              ),
                            ),
                          ],
                        ),SizedBox(height: 40,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: <Widget>[
                            Text("PIN CODE"), SizedBox(width: 40,),
                            Container(
                              alignment: Alignment.center,
                              width: 200,
                              child: TextFormField(

                                initialValue: modifiedAddressParts[7],
                                onChanged: (text){finalAddress[7]=text;},

                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Eg: 1201',
                                ),
                              ),
                            ),
                          ],
                        ),
                        MaterialButton(
                          onPressed:()async{


                          },
                          color: Colors.redAccent,

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: const Text("Submit Edited Address",style:TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color:Colors.black,

                          ),),

                        )
                      ]

                  ),
                )

            )
        );
      }
  }

