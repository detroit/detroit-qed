module Detroit

  # QED documentation tool.
  def Qedoc(options={})
    Qedoc.new(options)
  end

  # QED documentation tool.
  #
  # QED can generate an HTML representation of the QED documents.
  class Qedoc < Tool

    # Demonstration files (or globs).
    attr_reader :files

    # Output directory to generate QEDocs.
    attr_accessor :output

    # Relative reference to css stylesheet for QEDocs.
    attr_accessor :stylsheet

    # Optional title to use in QEDdocs.
    attr_accessor :title

    #
    def document
      options = {}
      options[:paths]  = files
      options[:output] = output
      options[:css]    = styleheet
      options[:title]  = title
      options[:dryrun] = dryrun?
      options[:quiet]  = quiet?

      doc = QED::Document.new(options)
      doc.generate
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

    #
    def assembly_document
      document
    end

    #
    def assembly_reset
      reset
    end

    #
    def assembly_clean
      clean
    end

    #
    def assembly_purge
      purge
    end

    private

    def initialize_requires
      require 'qedoc/document'
    end

  end

end
