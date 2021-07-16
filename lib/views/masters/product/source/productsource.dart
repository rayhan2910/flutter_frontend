part of datasource;

class ProductDataSource extends BsDatatableSource {
  ValueChanged<int> onEditListener = (productid) {};
  ValueChanged<int> onDeleteListener = (productid) {};

  static List<BsDataColumn> columns = <BsDataColumn>[
    BsDataColumn(
        label: Text(DBText.tableCellNo),
        width: 100.0,
        searchable: false,
        orderable: false),
    BsDataColumn(
        label: Text(ProductText.formCode), columnName: ProductText.tableCode),
    BsDataColumn(
        label: Text(DBText.formName), columnName: ProductText.tableName),
    BsDataColumn(
        label: Text(ProductText.formType), columnName: ProductText.tableTypeId),
    BsDataColumn(
        label: Text(DBText.tableCellAction),
        width: 200.0,
        searchable: false,
        orderable: false),
  ];

  List<ProductModel> get products => List<ProductModel>.from(
      response.data.map((e) => ProductModel.fromJson(e)).toList());

  @override
  BsDataRow getRow(int index) {
    ProductModel product = products[index];
    return BsDataRow(index: index, cells: <BsDataCell>[
      BsDataCell(Text('${controller.start + index + 1}')),
      BsDataCell(SelectableText('${notNull(product.productcd)}')),
      BsDataCell(SelectableText('${notNull(product.productnm)}')),
      BsDataCell(SelectableText('${notNull(product.type.typenm)}')),
      BsDataCell(Row(children: [
        BsButton(
          margin: EdgeInsets.only(right: 5.0),
          prefixIcon: DBIcon.buttonEdit,
          size: BsButtonSize.btnIconSm,
          style: BsButtonStyle.primary,
          onPressed: () => onEditListener(product.id),
        ),
        BsButton(
          prefixIcon: DBIcon.buttonDelete,
          size: BsButtonSize.btnIconSm,
          style: BsButtonStyle.danger,
          onPressed: () => onDeleteListener(product.id),
        ),
      ]))
    ]);
  }
}
