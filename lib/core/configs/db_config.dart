/// Database name
const kDataBaseName = "sky_food.db";

/// Database table creation
const kInitializeTable = <String>[
  '''
  CREATE TABLE Supplier (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    is_show INTEGER 
  );
  ''',
  '''
  CREATE TABLE Product (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_supplier INTEGER,
    name TEXT,
    price REAL,
    img_path TEXT,
    description TEXT,
    is_show INTEGER
  );
  ''',
  '''
  CREATE TABLE OrderProduct (
    id INTEGER PRIMARY KEY,
    id_supplier INTEGER,
    name TEXT,
    price REAL,
    img_path TEXT,
    description TEXT,
    customers TEXT,
    quantity INTEGER,
    is_order_done INTEGER
  );
  ''',
];

/// Database table update
const kMigrations = <String>[];