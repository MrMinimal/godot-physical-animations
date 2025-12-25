class_name PidController

enum DerivativeMeasurement {Velocity, ErrorRateOfChange}

# PID coefficients
@export
var proportionalGain: float = 1.0

@export
var integralGain: float = 0

@export
var derivativeGain: float = .3

var outputMin: float = -1
var outputMax: float = 1
var integralSaturation: float = 1.0
var derivativeMeasurement: DerivativeMeasurement = DerivativeMeasurement.Velocity

var valueLast: float
var errorLast: float
var integrationStored: float
var velocity: float
var derivativeInitialized: bool

func update(dt: float,currentValue: float, targetValue: float) -> float:
	var error: float = targetValue - currentValue

	# calculate P term
	var P: float = proportionalGain * error

	# calculate I term
	integrationStored = clampf(integrationStored + (error * dt), -integralSaturation, integralSaturation)
	var I: float = integralGain * integrationStored

	# calculate both D terms
	var errorRateOfChange: float = (error - errorLast) / dt
	errorLast = error

	var valueRateOfChange: float = (currentValue - valueLast) / dt
	valueLast = currentValue
	velocity = valueRateOfChange

	# choose D term to use
	var deriveMeasure: float = 0

	if (derivativeInitialized):
		match derivativeMeasurement:
			DerivativeMeasurement.Velocity:
				deriveMeasure = -valueRateOfChange
			DerivativeMeasurement.ErrorRateOfChange:
				deriveMeasure = errorRateOfChange
	else:
		derivativeInitialized = true

	var D: float = derivativeGain * deriveMeasure

	var result: float = P + I + D

	return clampf(result, outputMin, outputMax)
