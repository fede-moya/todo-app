describe SingletonStorer do
  class Simulation
    PERSISTED_ATTRIBUTES = %i[attr_1 attr_2]

    attr_accessor(*PERSISTED_ATTRIBUTES)

    include Singleton
    include SingletonStorer
  end

  after do
    FileUtils.rm('simulation.mp') if File.exist?('simulation.mp')
  end

  describe '.dump' do
    it 'creates a persistence file named simulation.mp' do
      Simulation.dump
      _(File.exist?('simulation.mp')).must_be(:===, true)
    end

    it 'persists instance attributes as a hash in the persistence file' do
      attr_1, attr_2 = 'foo', 'bar'
      Simulation.instance.attr_1 = attr_1
      Simulation.instance.attr_2 = attr_2
      Simulation.dump
      attrs = Marshal.load(File.read('simulation.mp'))
      _(attrs).must_equal({ attr_1: attr_1, attr_2: attr_2 })
    end
  end

  describe '.load' do
    it 'loads instance attributes with information extracted from a 
      file named simulation.mp' do
      attr_1, attr_2 = 'attr_1', 'attr_2'
      File.write('simulation.mp', Marshal.dump({ attr_1: attr_1, attr_2: attr_2 }))
      Simulation.load
      _(Simulation.instance.attr_1).must_equal(attr_1)
      _(Simulation.instance.attr_2).must_equal(attr_2)
    end
  end
end
