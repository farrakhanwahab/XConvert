class ConverterService {
  // Length units: symbol to full name
  static const Map<String, String> lengthSymbols = {
    'm': 'Meter',
    'km': 'Kilometer',
    'cm': 'Centimeter',
    'mm': 'Millimeter',
    'mi': 'Mile',
    'yd': 'Yard',
    'ft': 'Foot',
    'in': 'Inch',
  };
  static const Map<String, double> lengthFactors = {
    'm': 1.0,
    'km': 1000.0,
    'cm': 0.01,
    'mm': 0.001,
    'mi': 1609.344,
    'yd': 0.9144,
    'ft': 0.3048,
    'in': 0.0254,
  };

  // Area units: symbol to full name
  static const Map<String, String> areaSymbols = {
    'm²': 'Square Meter',
    'km²': 'Square Kilometer',
    'mi²': 'Square Mile',
    'ft²': 'Square Foot',
    'yd²': 'Square Yard',
    'ac': 'Acre',
    'ha': 'Hectare',
  };
  static const Map<String, double> areaFactors = {
    'm²': 1.0,
    'km²': 1e6,
    'mi²': 2.589988e6,
    'ft²': 0.092903,
    'yd²': 0.836127,
    'ac': 4046.8564224,
    'ha': 10000.0,
  };

  // Volume units: symbol to full name
  static const Map<String, String> volumeSymbols = {
    'L': 'Liter',
    'mL': 'Milliliter',
    'm³': 'Cubic Meter',
    'cm³': 'Cubic Centimeter',
    'in³': 'Cubic Inch',
    'ft³': 'Cubic Foot',
    'gal (US)': 'Gallon (US)',
    'gal (UK)': 'Gallon (UK)',
    'qt': 'Quart',
    'pt': 'Pint',
    'cup': 'Cup',
    'fl oz': 'Fluid Ounce',
  };
  static const Map<String, double> volumeFactors = {
    'L': 1.0,
    'mL': 0.001,
    'm³': 1000.0,
    'cm³': 0.001,
    'in³': 0.0163871,
    'ft³': 28.3168,
    'gal (US)': 3.78541,
    'gal (UK)': 4.54609,
    'qt': 0.946353,
    'pt': 0.473176,
    'cup': 0.24,
    'fl oz': 0.0295735,
  };

  // Speed units: symbol to full name
  static const Map<String, String> speedSymbols = {
    'm/s': 'Meters per second',
    'km/h': 'Kilometers per hour',
    'mph': 'Miles per hour',
    'ft/s': 'Feet per second',
    'kn': 'Knots',
  };
  static const Map<String, double> speedFactors = {
    'm/s': 1.0,
    'km/h': 0.277778,
    'mph': 0.44704,
    'ft/s': 0.3048,
    'kn': 0.514444,
  };

  // Time units: symbol to full name
  static const Map<String, String> timeSymbols = {
    's': 'Second',
    'min': 'Minute',
    'h': 'Hour',
    'd': 'Day',
    'wk': 'Week',
    'mo': 'Month',
    'yr': 'Year',
  };
  static const Map<String, double> timeFactors = {
    's': 1.0,
    'min': 60.0,
    'h': 3600.0,
    'd': 86400.0,
    'wk': 604800.0,
    'mo': 2.62974e6,
    'yr': 3.15569e7,
  };

  // Weight units: symbol to full name
  static const Map<String, String> weightSymbols = {
    'kg': 'Kilogram',
    'g': 'Gram',
    'mg': 'Milligram',
    'lb': 'Pound',
    'oz': 'Ounce',
    't': 'Ton',
  };
  static const Map<String, double> weightFactors = {
    'kg': 1.0,
    'g': 0.001,
    'mg': 0.000001,
    'lb': 0.45359237,
    'oz': 0.028349523125,
    't': 1000.0,
  };

  // Energy units: symbol to full name
  static const Map<String, String> energySymbols = {
    'J': 'Joule',
    'kJ': 'Kilojoule',
    'cal': 'Calorie',
    'kcal': 'Kilocalorie',
    'Wh': 'Watt-hour',
    'kWh': 'Kilowatt-hour',
    'BTU': 'BTU',
  };
  static const Map<String, double> energyFactors = {
    'J': 1.0,
    'kJ': 1000.0,
    'cal': 4.184,
    'kcal': 4184.0,
    'Wh': 3600.0,
    'kWh': 3.6e6,
    'BTU': 1055.06,
  };

  // Power units: symbol to full name
  static const Map<String, String> powerSymbols = {
    'W': 'Watt',
    'kW': 'Kilowatt',
    'hp': 'Horsepower',
    'MW': 'Megawatt',
  };
  static const Map<String, double> powerFactors = {
    'W': 1.0,
    'kW': 1000.0,
    'hp': 745.7,
    'MW': 1e6,
  };

  // Data units: symbol to full name
  static const Map<String, String> dataSymbols = {
    'b': 'Bit',
    'B': 'Byte',
    'KB': 'Kilobyte',
    'MB': 'Megabyte',
    'GB': 'Gigabyte',
    'TB': 'Terabyte',
  };
  static const Map<String, double> dataFactors = {
    'b': 0.125,
    'B': 1.0,
    'KB': 1024.0,
    'MB': 1048576.0,
    'GB': 1073741824.0,
    'TB': 1099511627776.0,
  };

  // Frequency units: symbol to full name
  static const Map<String, String> frequencySymbols = {
    'Hz': 'Hertz',
    'kHz': 'Kilohertz',
    'MHz': 'Megahertz',
    'GHz': 'Gigahertz',
  };
  static const Map<String, double> frequencyFactors = {
    'Hz': 1.0,
    'kHz': 1000.0,
    'MHz': 1e6,
    'GHz': 1e9,
  };

  /// Convert length from one unit to another
  static double convertLength(double value, String fromUnit, String toUnit) {
    final fromFactor = lengthFactors[fromUnit];
    final toFactor = lengthFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid length unit: $fromUnit or $toUnit');
    }

    // Convert to meters then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert area from one unit to another
  static double convertArea(double value, String fromUnit, String toUnit) {
    final fromFactor = areaFactors[fromUnit];
    final toFactor = areaFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid area unit: $fromUnit or $toUnit');
    }

    // Convert to square meters then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert volume from one unit to another
  static double convertVolume(double value, String fromUnit, String toUnit) {
    final fromFactor = volumeFactors[fromUnit];
    final toFactor = volumeFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid volume unit: $fromUnit or $toUnit');
    }

    // Convert to liters then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert speed from one unit to another
  static double convertSpeed(double value, String fromUnit, String toUnit) {
    final fromFactor = speedFactors[fromUnit];
    final toFactor = speedFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid speed unit: $fromUnit or $toUnit');
    }

    // Convert to meters per second then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert time from one unit to another
  static double convertTime(double value, String fromUnit, String toUnit) {
    final fromFactor = timeFactors[fromUnit];
    final toFactor = timeFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid time unit: $fromUnit or $toUnit');
    }

    // Convert to seconds then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert weight from one unit to another
  static double convertWeight(double value, String fromUnit, String toUnit) {
    final fromFactor = weightFactors[fromUnit];
    final toFactor = weightFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid weight unit: $fromUnit or $toUnit');
    }

    // Convert to kilograms then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert energy from one unit to another
  static double convertEnergy(double value, String fromUnit, String toUnit) {
    final fromFactor = energyFactors[fromUnit];
    final toFactor = energyFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid energy unit: $fromUnit or $toUnit');
    }

    // Convert to joules then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert power from one unit to another
  static double convertPower(double value, String fromUnit, String toUnit) {
    final fromFactor = powerFactors[fromUnit];
    final toFactor = powerFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid power unit: $fromUnit or $toUnit');
    }

    // Convert to watts then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert data storage from one unit to another
  static double convertData(double value, String fromUnit, String toUnit) {
    final fromFactor = dataFactors[fromUnit];
    final toFactor = dataFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid data unit: $fromUnit or $toUnit');
    }

    // Convert to bytes then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert frequency from one unit to another
  static double convertFrequency(double value, String fromUnit, String toUnit) {
    final fromFactor = frequencyFactors[fromUnit];
    final toFactor = frequencyFactors[toUnit];
    
    if (fromFactor == null || toFactor == null) {
      throw ArgumentError('Invalid frequency unit: $fromUnit or $toUnit');
    }

    // Convert to hertz then to target unit
    return value * fromFactor / toFactor;
  }

  /// Convert temperature from one unit to another
  static double convertTemperature(double value, String fromUnit, String toUnit) {
    // First convert to Celsius
    double celsius;
    switch (fromUnit) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32.0) * 5.0 / 9.0;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      case 'Rankine':
        celsius = (value - 491.67) * 5.0 / 9.0;
        break;
      default:
        throw ArgumentError('Invalid temperature unit: $fromUnit');
    }

    // Then convert from Celsius to target unit
    switch (toUnit) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return celsius * 9.0 / 5.0 + 32.0;
      case 'Kelvin':
        return celsius + 273.15;
      case 'Rankine':
        return (celsius + 273.15) * 9.0 / 5.0;
      default:
        throw ArgumentError('Invalid temperature unit: $toUnit');
    }
  }

  /// Convert currency using exchange rate
  static double convertCurrency(double value, double rate) {
    return value * rate;
  }

  /// Format result based on magnitude
  static String formatResult(double value) {
    if (value.abs() < 0.01 || value.abs() >= 1000000) {
      return value.toStringAsExponential(2);
    } else {
      return value.toStringAsFixed(value.truncateToDouble() == value ? 0 : 2);
    }
  }

  // Get available units (symbols) for each type
  static List<String> getLengthUnits() => lengthSymbols.keys.toList();
  static List<String> getAreaUnits() => areaSymbols.keys.toList();
  static List<String> getVolumeUnits() => volumeSymbols.keys.toList();
  static List<String> getSpeedUnits() => speedSymbols.keys.toList();
  static List<String> getTimeUnits() => timeSymbols.keys.toList();
  static List<String> getWeightUnits() => weightSymbols.keys.toList();
  static List<String> getEnergyUnits() => energySymbols.keys.toList();
  static List<String> getPowerUnits() => powerSymbols.keys.toList();
  static List<String> getDataUnits() => dataSymbols.keys.toList();
  static List<String> getFrequencyUnits() => frequencySymbols.keys.toList();

  // Lookup full name for a symbol
  static String getLengthFullName(String symbol) => lengthSymbols[symbol] ?? symbol;
  static String getAreaFullName(String symbol) => areaSymbols[symbol] ?? symbol;
  static String getVolumeFullName(String symbol) => volumeSymbols[symbol] ?? symbol;
  static String getSpeedFullName(String symbol) => speedSymbols[symbol] ?? symbol;
  static String getTimeFullName(String symbol) => timeSymbols[symbol] ?? symbol;
  static String getWeightFullName(String symbol) => weightSymbols[symbol] ?? symbol;
  static String getEnergyFullName(String symbol) => energySymbols[symbol] ?? symbol;
  static String getPowerFullName(String symbol) => powerSymbols[symbol] ?? symbol;
  static String getDataFullName(String symbol) => dataSymbols[symbol] ?? symbol;
  static String getFrequencyFullName(String symbol) => frequencySymbols[symbol] ?? symbol;

  /// Get available temperature units
  static List<String> getTemperatureUnits() {
    return ['Celsius', 'Fahrenheit', 'Kelvin', 'Rankine'];
  }
} 