class Drinks {
  int water;
  int coffee;
  int tea;
  int sparklingWater;
  int soda;
  int energyDrink;
  int sportsDrink;
  int alcohol;

  Drinks({this.water, this.coffee, this.tea, this.sparklingWater, this.soda, this.energyDrink, this.sportsDrink, this.alcohol});

  static Drinks empty() {
    return Drinks(water: 0, coffee: 0, tea: 0, sparklingWater: 0, soda: 0, energyDrink: 0, sportsDrink: 0, alcohol: 0);
  }

  factory Drinks.fromMap(Map data) {
    data = data ?? { };
    return Drinks(
      water: data['water'] ?? 0,
      coffee: data['coffee'] ?? 0,
      tea: data['tea'] ?? 0,
      sparklingWater: data['sparklingWater'] ?? 0,
      soda: data['soda'] ?? 0,
      energyDrink: data['energyDrink'] ?? 0,
      sportsDrink: data['sportsDrink'] ?? 0,
      alcohol: data['alcohol'] ?? 0
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
      'energyDrink': data.energyDrink,
      'sportsDrink': data.sportsDrink,
      'alcohol': data.alcohol
    };
  }

  void increment(String drink, int value) {
    switch (drink) {
      case 'water': {
        this.water += value;
      }
      break;
      case 'coffee': {
        this.coffee += value;
      }
      break;
      case 'tea': {
        this.tea += value;
      }
      break;
      case 'sparklingWater': {
        this.sparklingWater += value;
      }
      break;
      case 'soda': {
        this.soda += value;
      }
      break;
      case 'energyDrink': {
        this.energyDrink += value;
      }
      break;
      case 'sportsDrink': {
        this.sportsDrink += value;
      }
      break;
      case 'alcohol': {
        this.alcohol += value;
      }
      break;
    }
  }

  void decrement(String drink, int value) {
    switch (drink) {
      case 'water': {
        this.water -= value;
        if(this.water < 0) {
          this.water = 0;
        }
      }
      break;
      case 'coffee': {
        this.coffee -= value;
        if(this.coffee < 0) {
          this.coffee = 0;
        }
      }
      break;
      case 'tea': {
        this.tea -= value;
        if(this.tea < 0) {
          this.tea = 0;
        }
      }
      break;
      case 'sparklingWater': {
        this.sparklingWater -= value;
        if(this.sparklingWater < 0) {
          this.sparklingWater = 0;
        }
      }
      break;
      case 'soda': {
        this.soda -= value;
        if(this.soda < 0) {
          this.soda = 0;
        }
      }
      break;
      case 'energyDrink': {
        this.energyDrink -= value;
        if(this.energyDrink < 0) {
          this.energyDrink = 0;
        }
      }
      break;
      case 'sportsDrink': {
        this.sportsDrink -= value;
        if(this.sportsDrink < 0) {
          this.sportsDrink = 0;
        }
      }
      break;
      case 'alcohol': {
        this.alcohol -= value;
        if(this.alcohol < 0) {
          this.alcohol = 0;
        }
      }
      break;
    }
  }
}