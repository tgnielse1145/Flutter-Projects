import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listings/constants.dart';
import 'package:flutter_listings/model/FilterModel.dart';
import 'package:flutter_listings/services/FirebaseHelper.dart';

class FiltersScreen extends StatefulWidget {
  final Map<String, String>? filtersValue;

  const FiltersScreen({Key? key, this.filtersValue}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Future<List<FilterModel>> _filtersFuture;
  List<FilterModel> _filters = [];

  @override
  void initState() {
    _filtersFuture = FireStoreUtils().getFilters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: .9,
      initialChildSize: .9,
      minChildSize: .2,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<FilterModel>>(
                  future: _filtersFuture,
                  initialData: [],
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator.adaptive());
                    if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
                      return Center(child: Text('No filters found.'.tr()));
                    } else {
                      _filters = snapshot.data!;
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _filters.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            FilterModel filter = _filters[index];
                            return ListTile(
                              title: Text(filter.name),
                              trailing: DropdownButton<String>(
                                  selectedItemBuilder: (BuildContext context) {
                                    return filter.options
                                        .cast<String>()
                                        .map<Widget>((String item) {
                                      return SizedBox(
                                        width: MediaQuery.of(context).size.width / 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            item,
                                          ),
                                        ),
                                      );
                                    }).toList();
                                  },
                                  hint: SizedBox(
                                    width: MediaQuery.of(context).size.width / 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${filter.name}',
                                      ),
                                    ),
                                  ),
                                  value: widget.filtersValue?['${filter.name}'],
                                  underline: Container(),
                                  items: filter.options
                                      .map<DropdownMenuItem<String>>(
                                        (value) => DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  icon: Container(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      widget.filtersValue?['${filter.name}'] =
                                          value ?? '';
                                    });
                                  }),
                            );
                          });
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  primary: Color(COLOR_PRIMARY),
                  shape: StadiumBorder(),
                ),
                child: Text(
                  'Save Filters'.tr(),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pop(context, widget.filtersValue);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
