import 'package:bs_admin/constants/constants.dart';
import 'package:bs_admin/presenters/product_presenter.dart';
import 'package:bs_admin/views/masters/product/source/datasource.dart';
import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter/cupertino.dart';

class ProductFormModal extends StatefulWidget {
  ProductFormModal(
      {Key? key, required this.presenter, this.onClose, this.onSubmit})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductFormModalState();
  }

  final ProductPresenter presenter;

  final VoidCallback? onClose;

  final VoidCallback? onSubmit;
}

class _ProductFormModalState extends State<ProductFormModal> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();

  late ProductForm _productForm;

  @override
  void initState() {
    _productForm = ProductForm(context: context, presenter: widget.presenter);
    super.initState();
  }

  void updateState() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BsModal(
        context: context,
        dialog: BsModalDialog(
          child: Form(
            key: _formState,
            child: BsModalContent(
              children: [
                BsModalContainer(
                    title: Text(DBText.formTitle(ProductText.title)),
                    closeButton: true),
                BsModalContainer(
                  child: Column(
                    children: [
                      _productForm.selectTypeId(),
                      _productForm.inputCode(),
                      _productForm.inputName(),
                      _productForm.inputDescription()
                    ],
                  ),
                ),
                BsModalContainer(
                    mainAxisAlignment: MainAxisAlignment.end,
                    actions: [
                      BsButton(
                        disabled: widget.presenter.isLoading,
                        margin: EdgeInsets.only(right: 5.0),
                        label: Text(DBText.buttonModalCancel),
                        prefixIcon: DBIcon.buttonModalCancel,
                        style: BsButtonStyle.danger,
                        size: BsButtonSize.btnMd,
                        onPressed: () {
                          Navigator.pop(context);
                          if (widget.onClose != null) widget.onClose!();
                        },
                      ),
                      BsButton(
                        disabled: widget.presenter.isLoading,
                        label: Text(widget.presenter.isLoading
                            ? DBText.buttonProcessing
                            : DBText.buttonModalSave),
                        prefixIcon: DBIcon.buttonModalSave,
                        style: BsButtonStyle.primary,
                        size: BsButtonSize.btnMd,
                        onPressed: () {
                          if (widget.onSubmit != null) widget.onSubmit!();
                        },
                      ),
                    ])
              ],
            ),
          ),
        ));
  }
}
