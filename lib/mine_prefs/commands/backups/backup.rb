module MinePrefs
  module Commands
    module Backups
      class Backup
        attr_reader :filesystem

        def initialize(filesystem: LoggingFileUtils.new(MinePrefs::FileUtils.new))
          @filesystem = filesystem
        end

        FILE_NOT_FOUND = Errno::ENOENT

        def execute(installation_bundle)
          installation_bundle.each do |file|
            source = file.target
            destination = MinePrefs::Commands::Backups::File.new(source).to_s

            filesystem.mv(source, destination)
          end
        end

        def undo(installation_bundle)
          installation_bundle.each do |file|
            destination = file.target
            source = MinePrefs::Commands::Backups::File.new(destination).to_s

            filesystem.mv(source, destination)
          end
        end
      end
    end
  end
end