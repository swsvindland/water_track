import 'package:flutter/material.dart';

class Drinks {
  int water;
  int coffee;
  int tea;
  int sparklingWater;
  int soda;
  int energyDrink;
  int sportsDrink;
  int alcohol;
  DateTime date;

  Drinks(
      {required this.water,
      required this.coffee,
      required this.tea,
      required this.sparklingWater,
      required this.soda,
      required this.energyDrink,
      required this.sportsDrink,
      required this.alcohol,
      required this.date,
      });

  static Drinks empty() {
    return Drinks(
        water: 0,
        coffee: 0,
        tea: 0,
        sparklingWater: 0,
        soda: 0,
        energyDrink: 0,
        sportsDrink: 0,
        alcohol: 0,
        date: DateUtils.dateOnly(DateTime.now()));
  }

  factory Drinks.fromMap(Map data) {
    data = data;
    return Drinks(
        water: data['water'] ?? 0,
        coffee: data['coffee'] ?? 0,
        tea: data['tea'] ?? 0,
        sparklingWater: data['sparklingWater'] ?? 0,
        soda: data['soda'] ?? 0,
        energyDrink: data['energyDrink'] ?? 0,
        sportsDrink: data['sportsDrink'] ?? 0,
        alcohol: data['alcohol'] ?? 0,
        date: data['date'].toDate());
  }

  static Map<String, dynamic> toMap(Drinks data) {
    data = data;
    return {
      'water': data.water,
      'coffee': data.coffee,
      'tea': data.tea,
      'sparklingWater': data.sparklingWater,
      'soda': data.soda,
      'energyDrink': data.energyDrink,
      'sportsDrink': data.sportsDrink,
      'alcohol': data.alcohol,
      'date': DateUtils.dateOnly(DateTime.now())
    };
  }

  void increment(String drink, int value) {
    switch (drink) {
      case 'water':
        {
          water += value;
        }
        break;
      case 'coffee':
        {
          coffee += value;
        }
        break;
      case 'tea':
        {
          tea += value;
        }
        break;
      case 'sparklingWater':
        {
          sparklingWater += value;
        }
        break;
      case 'soda':
        {
          soda += value;
        }
        break;
      case 'energyDrink':
        {
          energyDrink += value;
        }
        break;
      case 'sportsDrink':
        {
          sportsDrink += value;
        }
        break;
      case 'alcohol':
        {
          alcohol += value;
        }
        break;
    }
  }

  void decrement(String drink, int value) {
    switch (drink) {
      case 'water':
        {
          water -= value;
          if (water < 0) {
            water = 0;
          }
        }
        break;
      case 'coffee':
        {
          coffee -= value;
          if (coffee < 0) {
            coffee = 0;
          }
        }
        break;
      case 'tea':
        {
          tea -= value;
          if (tea < 0) {
            tea = 0;
          }
        }
        break;
      case 'sparklingWater':
        {
          sparklingWater -= value;
          if (sparklingWater < 0) {
            sparklingWater = 0;
          }
        }
        break;
      case 'soda':
        {
          soda -= value;
          if (soda < 0) {
            soda = 0;
          }
        }
        break;
      case 'energyDrink':
        {
          energyDrink -= value;
          if (energyDrink < 0) {
            energyDrink = 0;
          }
        }
        break;
      case 'sportsDrink':
        {
          sportsDrink -= value;
          if (sportsDrink < 0) {
            sportsDrink = 0;
          }
        }
        break;
      case 'alcohol':
        {
          alcohol -= value;
          if (alcohol < 0) {
            alcohol = 0;
          }
        }
        break;
    }
  }
}
