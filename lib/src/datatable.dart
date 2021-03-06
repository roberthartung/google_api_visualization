part of google_api_visualization;

class DataTable {
  JsObject _object;
  
  DataTable([opt_data, opt_version]) {
    _object =  new JsObject(context['google']['visualization']['DataTable']);
  }
  
  DataTable._fromJsObject(this._object);
  
  num addColumn(var type_or_description_object, [String label, String id]) {
    if(type_or_description_object is String) {
      return _object.callMethod('addColumn', [type_or_description_object, label, id]);
    } else {
      return _object.callMethod('addColumn', [type_or_description_object]);
    }
  }
  
  num addRow([cellArray]) {
    if(cellArray != null) {
      return _object.callMethod('cellArray');
    } else {
      return _object.callMethod('cellArray', [cellArray]);
    }
  }
  
  num addRows(var numOrArray) {
    return _object.callMethod('addRows', [new JsObject.jsify(numOrArray)]);
  }
  
  DataTable clone() {
    return new DataTable._fromJsObject(_object.callMethod('clone'));    
  }
  
  String getColumnId(columnIndex) {
    return _object.callMethod('getColumnId', [new JsObject.jsify(columnIndex)]);
  }
  
  void setCell(int rowIndex, int columnIndex, [value = null, formattedValue = null, properties = null]) {
    if(properties != null) {
      _object.callMethod('setCell', [rowIndex, columnIndex, value, formattedValue, new JsObject.jsify(properties)]);
    } else if(formattedValue != null) {
      _object.callMethod('setCell', [rowIndex, columnIndex, value, formattedValue]);
    } else if(value != null) {
      _object.callMethod('setCell', [rowIndex, columnIndex, value]);
    } else {
      _object.callMethod('setCell', [rowIndex, columnIndex]);
    }
  }
  
  void setValue(int rowIndex, int columnIndex, value) {
     _object.callMethod('setCell', [rowIndex, columnIndex, value]);
  }
}