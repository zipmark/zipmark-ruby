def http_fixture(file_name)
  fixture("#{file_name}.http")
end

def fixture(file_name)
  File.new(File.join(File.dirname(__FILE__), '../fixtures/', "#{file_name}"))
end
