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
    DB[:conn].execute(sql, name).map { |dog| new_from_db(dog)}.first
  end

  def update
    sql = <<-SQL
    UPDATE dogs set name = ?, breed = ? where id = ?;
    SQL
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  def save
  end

  def self.create(name:, breed:)
    new_dog = new(name: name, breed: breed)
    new_dog.save
  end

  def self.find_by_id(id)
    sql =<<-SQL
    SELECT id, name, breed from dogs where id = ? limit 1;
    SQL
    DB[:conn].execute(sql, id).map { |dog| new_from_db(dog)}.first
  end

  def self.find_or_create_by(name:, breed:)
  end

end
