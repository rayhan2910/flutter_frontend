import 'package:bs_admin/helpers/helpers.dart';
import 'package:bs_admin/models/product_model.dart';
import 'package:bs_admin/services/product_service.dart';
import 'package:bs_admin/utils/utils.dart';
import 'package:bs_admin/views/components/dialog_confirm.dart';
import 'package:bs_admin/views/masters/product/source/datasource.dart';
import 'package:bs_admin/views/masters/product/widget/product_form.dart';
import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class ProductPresenterContract implements ViewContract {}

class ProductPresenter extends ProductFormSource {
  GlobalKey<State> _formState = GlobalKey<State>();

  final ProductPresenterContract viewContract;

  ProductPresenter(this.viewContract);

  ProductService productService = ProductService();
  ProductModel productModel = ProductModel();

  ProductDataSource productSource = ProductDataSource();

  Future datatables(BuildContext context, Map<String, String> params) async {
    return await productService.datatables(params).then((value) {
      if (value.result!) {
        productSource.response = BsDatatableResponse.createFromJson(value.data);
        productSource.onEditListener = (productid) => edit(context, productid);
        productSource.onDeleteListener =
            (productid) => delete(context, productid);
        setLoading(false);
      }
    });
  }

  void add(BuildContext context) {
    resetData();
    setLoading(false);

    showDialog(
        context: context,
        builder: (context) => ProductFormModal(
              key: _formState,
              presenter: this,
              onSubmit: () => store(context),
            ));
  }

  void edit(BuildContext context, int productid) {
    resetData();
    setLoading(true);

    showDialog(
        context: context,
        builder: (context) => ProductFormModal(
              key: _formState,
              presenter: this,
              onSubmit: () => update(context, productid),
            ));

    productService.show(productid).then((value) {
      if (value.result!) {
        setData(ProductModel.fromJson(value.data));
      }
    });
  }

  void delete(BuildContext context, int productid) {
    showDialog(
        context: context,
        builder: (context) => DialogConfirm(onPressed: (value) {
              if (value == DialogConfirmOption.YES_OPTION) {
                productService.delete(productid).then((value) {
                  setLoading(false);
                  Navigator.pop(context);
                  productSource.controller.reload();
                });
              }
            }));
  }

  void setLoading(bool bool) {
    isLoading = bool;
    viewContract.updateState();

    if (_formState.currentState != null)
      _formState.currentState!.setState(() {});
  }

  void resetData() {
    typeid = '';
    selectTypeId.clear();
    inputCode.clear();
    inputName.clear();
    inputDescription.clear();
  }

  void store(BuildContext context) {
    setLoading(true);
    productService.store(getDatas()).then((value) {
      setLoading(false);
      if (value.result!) {
        Navigator.pop(context);
        productSource.controller.reload();
      }
    });
  }

  update(BuildContext context, int productid) {
    setLoading(true);
    productService.update(productid, getDatas()).then((value) {
      setLoading(false);

      if (value.result!) {
        Navigator.pop(context);
        productSource.controller.reload();
      }
    });
  }

  Map<String, String> getDatas() {
    return {
      'typeid': selectTypeId.getSelectedAsString() != ''
          ? selectTypeId.getSelectedAsString()
          : '0',
      'productcd': inputCode.text,
      'productnm': inputName.text,
      'description': inputDescription.text,
    };
  }

  void setData(ProductModel product) {
    productModel = product;

    if (productModel.typeid != 0)
      selectTypeId.setSelected(BsSelectBoxOption(
          value: productModel.typeid,
          text: Text(parseString(productModel.type.typenm))));

    typeid = parseString(productModel.id);
    inputCode.text = parseString(productModel.productcd);
    inputName.text = parseString(productModel.productnm);
    inputDescription.text = parseString(productModel.description);

    setLoading(false);
  }
}
