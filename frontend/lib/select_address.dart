import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectAddress extends StatefulWidget {
  const SelectAddress({Key? key}): super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}
Future<String?> getClipBoardData() async {
  ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
  return data!.text;
}
class _SelectAddressState extends State<SelectAddress> {
  Map addressFromOCRInfo={};
  String addressFromOCR='';


  @override
  Widget build(BuildContext context) {
    addressFromOCRInfo = ModalRoute.of(context)!.settings.arguments as Map;
    addressFromOCR=addressFromOCRInfo['address'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select address'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 16.0),
        child: Column(
          children: <Widget>[
            SelectableText(
                addressFromOCR,
                toolbarOptions: const ToolbarOptions(copy: true),
                style: TextStyle(fontSize: 20)
            ),
            const SizedBox(height: 40,),
            MaterialButton(
              onPressed:()async{
                String? Address= await getClipBoardData();
                if(Address!=null){
                  Navigator.pushNamed(context, '/validateCurrentAddress',arguments: {'address':Address});
                }

                // if(Address!=null){
                //   Navigator.pushNamed(context, '/editAddress',arguments: {'address':Address});
                // }
              },
              color: Colors.redAccent,

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)
              ),
              child: const Text("Choose selected text as address",style:TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color:Colors.black,

              ),),

            )
          ],
        ),
      ),
    );
  }
}


