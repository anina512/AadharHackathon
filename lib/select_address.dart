import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SelectAddress extends StatefulWidget {
  final String address;
  const SelectAddress({Key? key,required this.address}): super(key: key);

  @override
  _SelectAddressState createState() => _SelectAddressState();
}
Future<String?> getClipBoardData() async {
  ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
  return data!.text;
}
class _SelectAddressState extends State<SelectAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SelectableText(
                widget.address,
                toolbarOptions: const ToolbarOptions(copy: false)
            ),
            const SizedBox(height: 40,),
            MaterialButton(
              onPressed:()async{
                String? Address= await getClipBoardData();
                if(Address!=null){
                  print("address: "+Address);
                }
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

