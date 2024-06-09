part of 'widgets.dart';

class ListStockPage extends StatelessWidget {
  const ListStockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 420,
        child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 22, right: 22),
                  decoration: BoxDecoration(
                    color: accentColor2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'cc',
                              style: mainTextFont.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'conttoh',
                              style: grayTextFont.copyWith(fontSize: 13),
                            ),
                          ],
                        ),
                        Text('asd')
                      ]),
                ))));
  }
}
