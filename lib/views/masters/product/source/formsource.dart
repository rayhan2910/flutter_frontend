part of datasource;

abstract class ProductFormSource {
  String typeid = '';
  late bool isLoading;

  BsSelectBoxController selectTypeId = BsSelectBoxController();

  TextEditingController inputCode = TextEditingController();
  TextEditingController inputName = TextEditingController();
  TextEditingController inputDescription = TextEditingController();
}

class ProductForm {
  ProductForm({required this.context, required this.presenter});

  final BuildContext context;

  final ProductPresenter presenter;

  Widget selectTypeId() {
    return BsFormGroup(
      label: Text(ProductText.formType),
      child: BsSelectBox(
        searchable: true,
        disabled: presenter.isLoading,
        hintText: DBText.placeholderSelect(ProductText.formType),
        selectBoxController: presenter.selectTypeId,
        serverSide: (params) => selectType(params, typeid: presenter.typeid),
      ),
    );
  }

  Widget inputCode() {
    return BsFormGroup(
      label: Text(ProductText.formCode),
      child: BsInput(
        disabled: presenter.isLoading,
        controller: presenter.inputCode,
        hintText: DBText.placeholder(ProductText.formCode),
      ),
    );
  }

  Widget inputName() {
    return BsFormGroup(
      label: Text(DBText.formName),
      child: BsInput(
        disabled: presenter.isLoading,
        controller: presenter.inputName,
        hintText: DBText.placeholder(DBText.formName),
      ),
    );
  }

  Widget inputDescription() {
    return BsFormGroup(
      label: Text(DBText.formDescription),
      child: BsInput(
        disabled: presenter.isLoading,
        controller: presenter.inputDescription,
        hintText: DBText.placeholder(DBText.formDescription),
        minLines: 5,
        maxLines: 5,
      ),
    );
  }
}