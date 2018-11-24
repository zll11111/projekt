class Team < ApplicationRecord
  def self.validates_uniqueness(*attr_names)
    # Set the default configuration
    configuration = { attribute_name: :name , message: I18n.t('validations.duplicate') }

    # Update defaults with any supplied configuration values
    configuration.update(attr_names.extract_options!)

    validates_each(attr_names) do |record, record_attr_name, value|
      duplicates = Set.new
      attr_name = configuration[:attribute_name]
      value.map do |obj|
        #be sure to not count the destroyed objects
        unless obj.marked_for_destruction?
          cur_attr_value = obj.try(attr_name)
          if duplicates.member?(cur_attr_value)
            # mark the record as in error so validation will detect a failure
            record.errors.add(record_attr_name, '')
            obj.errors.add(attr_name, configuration[:message])
          else
            duplicates.add(cur_attr_value)
          end
        end
      end
    end
  end

  def self.validate_nested_uniqueness_of(*nested_attrs)
    opts      = nested_attrs.extract_options!
    uniq_attr = opts[:uniq_attr]
    scope     = opts[:scope    ] || []
    error_key = opts[:error_key] || :nested_taken
    message   = opts[:message  ] || nil

    raise ArgumentError unless uniq_attr.present?

    validates_each(nested_attrs) do |record, nested_attr, nested_values|
      dupes = Set.new

      nested_values.reject(&:marked_for_destruction?).map do |nested_val|
        dupe            = scope.each.inject({}) { |memo, k| memo[k] = nested_val.try(k); memo }
        dupe[uniq_attr] = nested_val.try(uniq_attr)

        if dupes.member?(dupe)
          record.errors.add(nested_attr, error_key, message: message)
        else
          dupes.add(dupe)
        end
      end
    end
  end

  has_many :members, dependent: :destroy
  has_many :users, through: :members, validate: true
  belongs_to :creator, foreign_key:"created_by", class_name: "User", inverse_of: "creating_teams"
  has_many :projects

  accepts_nested_attributes_for :users, allow_destroy: true

  validate_nested_uniqueness_of :users, uniq_attr: "email"

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user },
          name: Proc.new{|controller, model| model.name}
end
