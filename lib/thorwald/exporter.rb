require 'safe_attribute_assignment'

class Thorwald::Exporter
  include SafeAttributeAssignment

  attr_reader :clazz, :params
  attr_accessor :includes, :attribute, :type

  def initialize(clazz, params, options = {})
    @clazz = clazz
    @params = params

    options = {
      includes: [],
      attribute: :id
    }.merge(options)

    assign_attributes(options)
  end

  def as_json(*args) 
    export.as_json(include: includes)
  end

  private

  def scoped
    @scoped ||= clazz.where(where, last_record_id).order(attribute)
  end

  def export
    scoped.limit(count)
  end

  def last_record_id
    params[:last_record] || clazz.last.try(attribute)
  end

  def count
    params[:count] || 100
  end

  def where
    "#{attribute} #{comparator} ?"
  end

  def comparator
    if is_datetime? || params[:last_record].blank?
      ">="
    else
      ">"
    end
  end

  def is_datetime?
    type == :datetime
  end

  def type
    @type ||= %w(updated_at created_at).include?(attribute.to_s) ? :datetime : :id
  end
end
