class Product{
  int? id;
  late String name;
  late String description;
  late double unitPrice;


  Product.withoutId(this.name,this.description,this.unitPrice); 
  Product.withId(this.id,this.name,this.description,this.unitPrice);
  Product.toObjectfromMap(dynamic o){
    this.id=int.tryParse(o["id"].toString());
    this.name=o["name"];
    this.description=o["description"];
    this.unitPrice = double.tryParse(o["unitPrice"].toString()) ?? 0.0;
  }


  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map["name"]=name;
    map["description"]=description;
    map["unitPrice"]=unitPrice;
    if(id != null){
      map["id"]=id;
    }
    return map; 
  }

Product({
    this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
  });

  // Diğer constructorlar ve metodlar buraya eklenebilir

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? unitPrice,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

   
}