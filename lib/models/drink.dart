class Drinks {
  int water;
  int coffee;
  int tea;
  int sparklingWater;
  int soda;
  int energyDrink;

  Drinks({this.water, this.coffee, this.tea, this.sparklingWater, this.soda, this.energyDrink});

  static Drinks empty() {
    return Drinks(water: 0, coffee: 0, tea: 0, sparklingWater: 0, soda: 0, energyDrink: 0);
  }

  factory Drinks.fromMap(Map data) {
    data = data ?? { };
    return Drinks(
      water: data['water'] ?? 0,
      coffee: data['coffee'] ?? 0,
      tea: data['tea'] ?? 0,
      sparklingWater: data['sparklingWater'] ?? 0,
      soda: data['soda'] ?? 0,
      energyDrink: data['energyDrink'] ?? 0
    );
  }

  static Map<String, dynamic> toMap(Drinks data) {
    data = data ?? { };
    return {
      'water': data.water,
      'coffee': data.coffee,
      'tea': data.tea,
      'sparklingWater': data.sparklingWater,
      'soda': data.soda,
      'energyDrink': data.energyDrink
    };
  }

  void increment(String drink) {
    switch (drink) {
      case 'water': {
        this.water += 8;
      }
      break;
      case 'coffee': {
        this.coffee += 8;
      }
      break;
      case 'tea': {
        this.tea += 8;
      }
      break;
      case 'sparklingWater': {
        this.sparklingWater += 8;
      }
      break;
      case 'soda': {
        this.soda += 8;
      }
      break;
      case 'energyDrink': {
        this.energyDrink += 8;
      }
      break;
    }
  }

  void decrement(String drink) {
    switch (drink) {
      case 'water': {
        this.water -= 8;
        if(this.water < 0) {
          this.water = 0;
        }
      }
      break;
      case 'coffee': {
        this.coffee -= 8;
        if(this.coffee < 0) {
          this.coffee = 0;
        }
      }
      break;
      case 'tea': {
        this.tea -= 8;
        if(this.tea < 0) {
          this.tea = 0;
        }
      }
      break;
      case 'sparklingWater': {
        this.sparklingWater -= 8;
        if(this.sparklingWater < 0) {
          this.sparklingWater = 0;
        }
      }
      break;
      case 'soda': {
        this.soda -= 8;
        if(this.soda < 0) {
          this.soda = 0;
        }
      }
      break;
      case 'energyDrink': {
        this.energyDrink -= 8;
        if(this.energyDrink < 0) {
          this.energyDrink = 0;
        }
      }
      break;
    }
  }
}