import 'package:app/core/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsView extends StatefulWidget {
  final int itemNumber, categoryNumber;

  const DetailsView(
      {super.key, required this.itemNumber, required this.categoryNumber});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool(_getFavoriteKey()) ?? false;
    });
  }

  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = !_isFavorite;
    });
    await prefs.setBool(_getFavoriteKey(), _isFavorite);
  }

  String _getFavoriteKey() {
    return 'favorite_${widget.categoryNumber}_${widget.itemNumber}';
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(modelList[widget.categoryNumber][widget.itemNumber]
                  ['title_ar']),
              centerTitle: true,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              actions: [
                IconButton(
                  icon: Icon(
                    _isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: _isFavorite ? Colors.red : null,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  modelList[widget.categoryNumber][widget.itemNumber]['image'],
                  fit: BoxFit.cover,
                ),
              ),
              pinned: true,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).colorScheme.primary,
              expandedHeight: MediaQuery.of(context).size.height * 0.60,
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                _Title(textTitle: 'المقــادير'),
                _Ingredients(
                    categoryNumber: widget.categoryNumber,
                    itemNumber: widget.itemNumber),
                SizedBox(height: 16),
                _Title(textTitle: 'طريقة العمل'),
                _Steps(
                  categoryNumber: widget.categoryNumber,
                  itemNumber: widget.itemNumber,
                )
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String textTitle;

  const _Title({required this.textTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          Text(
            textTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'font',
            ),
          ),
          const SizedBox(width: 20), // Added spacing
          const Expanded(
            child: Divider(
              color: Color(0xFFA9A9A9),
              thickness: 1, // Added for visibility
            ),
          ),
          const SizedBox(width: 20), // Added spacing
        ],
      ),
    );
  }
}

class _Ingredients extends StatefulWidget {
  final int categoryNumber, itemNumber;

  const _Ingredients({
    required this.categoryNumber,
    required this.itemNumber,
  });

  @override
  State<_Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<_Ingredients> {
  late List<bool> checkedStates;

  @override
  void initState() {
    super.initState();
    checkedStates = List.generate(
      modelList[widget.categoryNumber][widget.itemNumber]['ingredients'].length,
      (index) => false,
    );
    loadCheckedStates();
  }

  Future<void> loadCheckedStates() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'ingredients_${widget.categoryNumber}_${widget.itemNumber}';
    final savedStates = prefs.getStringList(key);

    if (savedStates != null) {
      setState(() {
        checkedStates = savedStates.map((e) => e == 'true').toList();
      });
    }
  }

  Future<void> saveCheckedStates() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'ingredients_${widget.categoryNumber}_${widget.itemNumber}';
    await prefs.setStringList(
      key,
      checkedStates.map((e) => e.toString()).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemCount: modelList[widget.categoryNumber][widget.itemNumber]
                ['ingredients']
            .length,
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(modelList[widget.categoryNumber][widget.itemNumber]
                    ['ingredients'][index]['item']),
                subtitle: Text(
                  modelList[widget.categoryNumber][widget.itemNumber]
                      ['ingredients'][index]['quantity'],
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.75),
                  ),
                ),
                value: checkedStates[index],
                // Use individual state
                onChanged: (bool? value) {
                  setState(() {
                    checkedStates[index] =
                        value ?? false; // Update individual state
                    saveCheckedStates(); // Save states when changed
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Steps extends StatefulWidget {
  final int categoryNumber, itemNumber;

  const _Steps({
    required this.categoryNumber,
    required this.itemNumber,
  });

  @override
  State<_Steps> createState() => _StepsState();
}

class _StepsState extends State<_Steps> {
  late List<bool> checkedStates;

  @override
  void initState() {
    super.initState();
    checkedStates = List.generate(
      modelList[widget.categoryNumber][widget.itemNumber]['steps'].length,
      (index) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.all(16),
        itemCount:
            modelList[widget.categoryNumber][widget.itemNumber]['steps'].length,
        separatorBuilder: (context, index) => SizedBox(height: 16.h),
        itemBuilder: (context, index) => Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(modelList[widget.categoryNumber][widget.itemNumber]
                    ['steps'][index]),
                value: checkedStates[index],
                onChanged: (bool? value) {
                  setState(() {
                    checkedStates[index] = value ?? false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
