import 'package:flutter/material.dart';

class Drinks {
  int water;
  int coffee;
  int tea;
  int milk;
  int sparklingWater;
  int soda;
  int dietSoda;
  int energyDrink;
  int dietEnergyDrink;
  int preWorkout;
  int sportsDrink;
  int dietSportsDrink;
  DateTime date;

  Drinks({
    required this.water,
    required this.coffee,
    required this.tea,
    required this.milk,
    required this.sparklingWater,
    required this.soda,
    required this.dietSoda,
    required this.energyDrink,
    required this.dietEnergyDrink,
    required this.preWorkout,
    required this.sportsDrink,
    required this.dietSportsDrink,
    required this.date,
  });

  static Drinks empty() {
    return Drinks(
        water: 0,
        coffee: 0,
        tea: 0,
        milk: 0,
        sparklingWater: 0,
        soda: 0,
        dietSoda: 0,
        energyDrink: 0,
        dietEnergyDrink: 0,
        preWorkout: 0,
        sportsDrink: 0,
        dietSportsDrink: 0,
        date: DateUtils.dateOnly(DateTime.now()));
  }

  factory Drinks.fromMap(Map data) {
    data = data;
    return Drinks(
        water: data['water'] ?? 0,
        coffee: data['coffee'] ?? 0,
        tea: data['tea'] ?? 0,
        milk: data['milk'] ?? 0,
        sparklingWater: data['sparklingWater'] ?? 0,
        soda: data['soda'] ?? 0,
        dietSoda: data['dietSoda'] ?? 0,
        energyDrink: data['energyDrink'] ?? 0,
        dietEnergyDrink: data['dietEnergyDrink'] ?? 0,
        preWorkout: data['preWorkout'] ?? 0,
        sportsDrink: data['sportsDrink'] ?? 0,
        dietSportsDrink: data['dietSportsDrink'] ?? 0,
        date: data['date'].toDate());
  }

  static Map<String, dynamic> toMap(Drinks data) {
    data = data;
    return {
      'water': data.water,
      'coffee': data.coffee,
      'tea': data.tea,
      'milk': data.milk,
      'sparklingWater': data.sparklingWater,
      'soda': data.soda,
      'dietSoda': data.dietSoda,
      'energyDrink': data.energyDrink,
      'dietEnergyDrink': data.dietEnergyDrink,
      'preWorkout': data.preWorkout,
      'sportsDrink': data.sportsDrink,
      'dietSportsDrink': data.dietSportsDrink,
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
      case 'milk':
        {
          milk += value;
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
      case 'dietSoda':
        {
          dietSoda += value;
        }
        break;
      case 'energyDrink':
        {
          energyDrink += value;
        }
        break;
      case 'dietEnergyDrink':
        {
          dietEnergyDrink += value;
        }
        break;
      case 'preWorkout':
        {
          preWorkout += value;
        }
        break;
      case 'sportsDrink':
        {
          sportsDrink += value;
        }
        break;
      case 'dietSportsDrink':
        {
          dietSportsDrink += value;
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
      case 'milk':
        {
          milk -= value;
          if (milk < 0) {
            milk = 0;
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
      case 'dietSoda':
        {
          dietSoda -= value;
          if (dietSoda < 0) {
            dietSoda = 0;
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
      case 'dietEnergyDrink':
        {
          dietEnergyDrink -= value;
          if (dietEnergyDrink < 0) {
            dietEnergyDrink = 0;
          }
        }
        break;
      case 'preWorkout':
        {
          preWorkout -= value;
          if (preWorkout < 0) {
            preWorkout = 0;
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
      case 'dietSportsDrink':
        {
          dietSportsDrink -= value;
          if (dietSportsDrink < 0) {
            dietSportsDrink = 0;
          }
        }
        break;
    }
  }
}
