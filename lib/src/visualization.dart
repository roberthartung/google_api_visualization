part of google_api_visualization;

class SelectionItem {
  dynamic row;
  
  dynamic column;
  
  SelectionItem({this.row: null, this.column: null});
}

abstract class Visualization {
  JsObject _object;
  
  StreamController _onSelectStreamController;
  Stream<Event> get onSelect => _onSelectStreamController.stream;
  
  StreamController _onClickStreamController;
    Stream<Event> get onClick => _onClickStreamController.stream;
  
  Visualization(Element el) {
    _onSelectStreamController = new StreamController.broadcast(onListen: () {
      (context['google']['visualization']['events'] as JsObject).callMethod('addListener', [_object, 'select', _onSelect]);
    }, onCancel: () {
      (context['google']['visualization']['events'] as JsObject).callMethod('removeListener', [_object, 'select', _onSelect]);
    });
    
    _onClickStreamController = new StreamController.broadcast(onListen: () {
        (context['google']['visualization']['events'] as JsObject).callMethod('addListener', [_object, 'click', _onClick]);
      }, onCancel: () {
        (context['google']['visualization']['events'] as JsObject).callMethod('removeListener', [_object, 'click', _onClick]);
      });
    
    _object = new JsObject(context['google']['visualization'][this.runtimeType.toString()], [el]);
  }
  
  void _onSelect(_) {
    _onSelectStreamController.add(_);
  }
  
  void _onClick(targetId) {
    print('_onClick');
    _onClickStreamController.add(targetId);
  }
  
  void draw(dynamic data_table_or_view, [Map options]) {
    _object.callMethod('draw', [data_table_or_view._object, options]);
  }
  
  List<SelectionItem> getSelection() {
    dynamic selection_array = _object.callMethod('getSelection');
    List<SelectionItem> selection = new List<SelectionItem>();
    selection_array.forEach((JsObject a) {
      selection.add(new SelectionItem(row: a['row'], column: a['column']));
    });
    // selection.addAll(selection_array);
    return selection;
  }
}