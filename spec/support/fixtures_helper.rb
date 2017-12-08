class FixturesHelper
  def self.read(path)
    File.open(File.join(FIXTURES_DIR, path), 'rb').read
  end
end
