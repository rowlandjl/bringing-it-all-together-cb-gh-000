class Dog
  attr_accessor :name, :breed
  attr_reader :id

  def initialize(name:, breed:, id: nil)
    @id = id
    @name = name
    @breed = breed
  end

  def self.create_table
    sql =<<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
      id integer primary key,
      name text,
      breed text
    );
    SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
    DROP TABLE dogs;
    SQL
    DB[:conn].execute(sql)
  end

  def self.new_from_db(row)
    new(id: row[0], name: row[1], breed: row[2])
  end

  def self.find_by_name(name)
    sql =<<-SQL 
    SELECT * FROM dogs where name = ?;
    SQL 
  end

  def update
  end

  def save
  end

  def self.create(name:, breed:)
    new_dog = new(name: name, breed: breed)
    new_dog.save
  end

  def self.find_by_id(id)
  end

  def self.find_or_create_by(name:, breed:)
  end

end
