require 'detroit/tool'

module Detroit

  # QED documentation tool.
  def Qedoc(options={})
    Qedoc.new(options)
  end

  # QED documentation tool.
  #
  # QED can generate an HTML representation of the QED documents.
  class Qedoc < Tool

    #  A T T R I B U T E S

    # Demonstration files (or globs).
    attr_accessor :files

    # Relative reference to css stylesheet for QEDocs.
    # (Only useful to HTML format.)
    attr_accessor :stylesheet

    # Optional title to use in QEDdocs.
    attr_accessor :title

    # Output file(s) to generate QEDocs.
    attr_reader :output

    #
    def output=(output)
      case output
      when Array
        output.each{ |path| assert_path(path) }
      else
        assert_path(path)
      end
      @output = output
    end

    #  A S S E M B L Y - S T A T I O N S

    #
    def station_document
      document
    end

    #
    def station_reset
      reset
    end

    #
    def station_clean
      clean
    end

    #
    def station_purge
      purge
    end

    #  S E R V I C E  M E T H O D S

    #
    def document
      options = {}
      options[:paths]  = files
      options[:css]    = stylesheet
      options[:title]  = title
      options[:dryrun] = dryrun?
      options[:quiet]  = quiet?

      output_files.each do |f|
        options[:output] = f

        doc = QED::Document.new(options)
        doc.generate
      end
    end

    # Mark the output directory as out of date.
    def reset
      if directory?(output)
        utime(0, 0, output)
        report "Reset #{output}" #unless trial?
      end
    end

    # noop
    def clean
    end

    # Remove qedoc output directory.
    def purge
      if directory?(output)
        rm_r(output)
        status "Removed #{output}" unless trial?
      end
    end

  private

    def initialize_requires
      require 'qed/document'
    end

    #
    def output_files
      [output].flatten
    end

    #
    def assert_path(path)
      valid = true
      valid = false if not String === path
      valid = false if path.empty?
      raise "qedoc: not a valid path -- #{path.inspect}" unless valid
    end
  end

end
