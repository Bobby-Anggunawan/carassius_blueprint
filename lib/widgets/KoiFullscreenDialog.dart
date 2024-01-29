import "package:carassius_blueprint/carassius_blueprint.dart";
import "package:flutter/material.dart";

void KoiFullscreenDialog(
    {required BuildContext context,
      required Function onConfirm,
      required String penjelasanDialog,
      required String judulDataDialog,
      required Widget content,
      String confirmButtonText = "Confirm",
      IconData confirmButtonIcon = Icons.edit}){
  showDialog(context: context, builder: (context){
    return Dialog.fullscreen(
      backgroundColor: context.koiThemeColor.primaryContainer,
      child: Padding(
        padding: EdgeInsets.all(context.koiSpacing.autoFromScreenEdge),
        child: Column(
          children: [
            // bagian teratas (tombol tutup dan tombol simpan)
            Row(
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: context.koiThemeColor.onPrimaryContainer,
                    )
                ),

                Expanded(child: Container()),

                TextButton.icon(
                  onPressed: (){
                    onConfirm();
                  },
                  style: ButtonStyle(
                      iconColor: MaterialStateProperty.resolveWith((states){
                        return context.koiThemeColor.onPrimaryContainer;
                      })
                  ),
                  label: Text(
                    confirmButtonText,
                    style: TextStyle(
                        color: context.koiThemeColor.onPrimaryContainer
                    ),
                  ),
                  icon: Icon(confirmButtonIcon),
                )
              ],
            ),

            Padding(padding: EdgeInsets.only(top: context.koiSpacing.autoBeetweenPane)),

            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                    padding: EdgeInsets.only(left: context.koiSpacing.autoBeetweenPane*3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          penjelasanDialog.toUpperCase(),
                          style: context.koiThemeText.body(size: TextStyleSize.Small).apply(color: context.koiThemeColor.onPrimaryContainer),
                        ),

                        Padding(padding: EdgeInsets.only(top: context.koiSpacing.smallest)),

                        Text(
                          judulDataDialog,
                          style: context.koiThemeText.title(size: TextStyleSize.Large).apply(color: context.koiThemeColor.onPrimaryContainer,),
                        ),
                      ],
                    )
                ),

                Padding(padding: EdgeInsets.only(top: context.koiSpacing.medium)),

                Divider(),
              ],
            ),

            Expanded(child: content)
          ],
        ),
      ),
    );
  });
}