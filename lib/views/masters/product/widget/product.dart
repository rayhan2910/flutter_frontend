import 'package:bs_admin/constants/constants.dart';
import 'package:bs_admin/presenters/product_presenter.dart';
import 'package:bs_admin/routes.dart';
import 'package:bs_admin/routes/home_route.dart';
import 'package:bs_admin/routes/masters/product_route.dart';
import 'package:bs_admin/utils/styles.dart';
import 'package:bs_admin/views/masters/product/source/datasource.dart';
import 'package:bs_admin/views/skins/widgets/breadcrumbs.dart';
import 'package:bs_admin/views/skins/wrapper.dart';
import 'package:bs_flutter/bs_flutter.dart';
import 'package:flutter/material.dart';

class ProductView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductViewState();
  }
}

class _ProductViewState extends State<ProductView>
    implements ProductPresenterContract {
  late ProductPresenter _presenter;

  bool isLoading = false;

  @override
  void initState() {
    _presenter = ProductPresenter(this);
    super.initState();
  }

  @override
  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      menuKey: ProductRoute.routeKey,
      title: ProductText.title,
      subTitle: ProductText.subTitle,
      breadcrumbs: [
        Breadcrumbs(
            label: DBText.home,
            icon: Icons.home,
            onPressed: () => Routes.redirect(context, HomeRoute.home)),
        Breadcrumbs(label: DBText.master),
        Breadcrumbs(label: ProductText.title),
      ],
      child: Container(
        padding: EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            BsCard(
              style: Styles.boxCard,
              children: [
                BsCardContainer(
                    title: Text(DBText.masterTitle(ProductText.title)),
                    actions: [
                      BsButton(
                        label: Text(DBText.buttonAdd),
                        prefixIcon: DBIcon.buttonAdd,
                        style: BsButtonStyle.primary,
                        onPressed: () => _presenter.add(context),
                      )
                    ]),
                BsCardContainer(
                    child: Column(
                  children: [
                    BsDatatable(
                      title: Text(DBText.dataTitle(ProductText.title)),
                      columns: ProductDataSource.columns,
                      pagination: BsPagination.simplyButtons,
                      source: _presenter.productSource,
                      serverSide: (params) =>
                          _presenter.datatables(context, params),
                    )
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
