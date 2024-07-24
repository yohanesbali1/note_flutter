part of 'shared.dart';

class ShareMedia {
  static void alert(status, message) {}
  static void share_data_transaction_detail(
      data_transaction_detail, data_transaction) async {
    String chat = "*FAKTUR TRANSAKSI*\n";
    chat += '${data_transaction!.company_name}\n';
    chat += '${data_transaction!.address}\n';
    chat += '${data_transaction!.phone}\n\n';

    chat += 'Tanggal : ${data_transaction!.date}\n\n';

    chat += '======================\n';
    chat += 'Detail Transaksi:\n';

    double total = 0.00;
    num qty = 0;

    data_transaction_detail.forEach((element) {
      total = total + (element.amount * element.price);
      qty += element.amount;
      chat += '${element.product_name}\n';
      chat +=
          'Jumlah: ${element.amount.toString()}, Harga: ${Helper.convertToIdr(element.price, 2).toString()} \n';
      chat +=
          'Sub Harga: ${Helper.convertToIdr((element.amount * element.price), 2).toString()} \n\n';
    });
    chat += '======================\n';
    chat += 'Total Barang: ${qty}\n';
    chat += 'Total Harga: ${Helper.convertToIdr(total, 2).toString()}\n\n\n';

    chat += 'Terima Kasih';

    Share.share(chat);
  }

  static void share_data_transaction(data_transaction) async {
    String chat = "*FAKTUR TRANSAKSI*\n";
    chat += '${data_transaction![0].company_name}\n';
    chat += '${data_transaction![0].address}\n';
    chat += '${data_transaction![0].phone}\n\n';

    DateFormat dateFormat = DateFormat('MMMM yyyy', 'id_ID');
    chat +=
        'Bulan : ${dateFormat.format(DateTime.parse(data_transaction![0].date))}\n\n';
    chat += '======================\n';
    chat += 'Detail Transaksi:\n';

    double total = 0.00;

    data_transaction.forEach((element) {
      DateFormat dateFormat = DateFormat('dd-MM-yyyy', 'id_ID');
      total = total + double.parse(element.totalprice.toString());
      chat += '${dateFormat.format(DateTime.parse(element.date))}         ';
      chat +=
          ' ${Helper.convertToIdr((element.totalprice), 0).toString()} \n\n';
    });
    chat += '======================\n';
    chat += 'Total: ${Helper.convertToIdr(total, 0).toString()}\n\n\n';

    chat += 'Terima Kasih';

    Share.share(chat);
  }
}
