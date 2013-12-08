module MinePrefs
  module Commands
    class Symlink
      def initialize(filesystem: LoggingFileUtils.new(MinePrefs::FileUtils.new))
        @filesystem = filesystem
      end

      def execute(installation_bundle)
        installation_bundle.each do |installation_pair|
          filesystem.symlink(installation_pair.source, installation_pair.target)
        end
      end

      def undo(installation_bundle)
        installation_bundle.each do |file|
          filesystem.rm(file.target)
        end
      end

      private
      attr_reader :filesystem
    end
  end
end