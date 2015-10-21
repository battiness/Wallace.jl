"""
Holds a specification for composing a simple species.
"""
type SimpleSpeciesSpecification
  """
  The fitness scheme used by members of this species.
  Defaults to (maximised) scalar fitness if unspecified.
  """
  fitness::FitnessScheme

  """
  The representation used by members of this species.
  """
  representation::Representation

  SimpleSpeciesSpecification() =
    new(fitness.scalar())
end

"""
Composes a simple specification from a provided specification.
Operates by transforming the simple specification into a complex one and then
composing that specification.
"""
function compose!(spec::SimpleSpeciesSpecification)
  cspec = ComplexSpeciesSpecification()
  cspec.stages = [stage("genome", spec.representation)]
  cspec.fitness = spec.fitness
  compose!(cspec)
end

"""
A simple species uses only a single representation, and defaults to using
scalar fitness if no fitness scheme is specified. For most problems, simple
species will suffice.

The genome of an individual belonging to a simple species may be retrieved
through its `genome` property.

**Properties:**

* `representation::Representation`, the solution represented used by members
of this species.
* `fitness::FitnessScheme`, the fitness scheme used by members of this
species. Defaults to (maximised) scalar fitness if unspecified.
"""
function simple(def::Function)
  spec = SimpleSpeciesSpecification
  def(spec)
  spec
end