require 'detroit/tool'

module Detroit

  # QED test tool.
  def Qed(options={})
    Qed.new(options)
  end

  # Run QED tests.
  class Qed < Tool

    # Demonstration files (or globs).
    attr_accessor :files

    # File patterns to omit.
    attr_accessor :omit

    # Output format.
    attr_accessor :format

    # Parse mode.
    attr_accessor :mode

    # Paths to be added to $LOAD_PATH.
    attr_reader :loadpath

    # Libraries to be required.
    attr_reader :requires

    # Operate from project root?
    attr_accessor :rooted

    # Selected profile.
    attr_accessor :profile

    #
    def loadpath=(paths)
      @loadpath = [paths].flatten
    end

    #
    def requires=(paths)
      @requires = [paths].flatten
    end


    #  A S S E M B L Y  M E T H O D S

    def assemble?(station, options={})
      case station
      when :test then true
      end
    end

    # Attach test method to test assembly station.
    def assemble(station, options={})
      case station
      when :test then test
      end
    end


    #  S E R V I C E  M E T H O D S

    #
    def test
      options = {
        :omit     => omit,
        :format   => format,
        :mode     => mode,
        :loadpath => loadpath,
        :requires => requires,
        :rooted   => rooted,
        :profile  => profile,
        :trace    => trace?
      }

      session = QED::Session.new(files, options)
      session.run
    end

  private

    #
    def initialize_requires
      require 'qed'
    end

  public

    def self.man_page
      File.dirname(__FILE__)+'/../man/detroit-qed.5'  
    end

  end

end
