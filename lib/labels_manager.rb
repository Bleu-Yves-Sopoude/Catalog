require 'json'
require_relative '../classes/label'

class LabelsManager
  def initialize
    @labels_list = []
  end

  attr_reader :labels_list

  def add_label(title, color)
    label = Label.new(title, color)
    @labels_list.push(label)
    label
  end

  def save_to_file
    labels_data = @labels_list.map(&:to_hash)
    File.open('labels.json', 'w') do |file|
      file.puts JSON.generate(labels_data)
    end
  end

  def load_from_file
    return unless File.exist?('labels.json')

    label_data = JSON.parse(File.read('labels.json'))
    label_data.each do |label_hash|
      label = add_label(label_hash['title'], label_hash['color'])
      label.id = label_hash['id']
    end
  end
end
