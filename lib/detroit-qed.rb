module Detroit

  # QED test tool.
  def Qed(options={})
    Qed.new(options)
  end

  # Run QED tests.
  class Qed < Tool

    # Demonstration files (or globs).
    attr_reader :files

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

    # Attach test method to test assembly station.
    def assembly_test
      test
    end

    private

    #
    def initialize_requires
      require 'qed'
    end

  end

end
