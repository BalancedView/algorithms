class HanoiTower

  attr_reader :tower1, :tower2, :tower3

  def initialize(tower1, tower2, tower3)
    @tower1 = tower1
    @tower2 = tower2
    @tower3 = tower3
  end

  def solve(n_disks, from_tower, to_tower)
    return if n_disks <= 0

    spare_tower = get_spare_tower(from_tower, to_tower)

    solve(n_disks-1, from_tower, spare_tower)
    move_disk(from_tower, to_tower)
    render_tower
    solve(n_disks-1, spare_tower, to_tower)
  end

  def get_spare_tower(from_tower, to_tower)
    ( [:tower1, :tower2, :tower3] - [from_tower, to_tower] ).first
  end

  def move_disk(from_tower, to_tower)
    self.send(to_tower) << self.send(from_tower).pop
  end

  def render_tower
    p @tower1
    p @tower2
    p @tower3
    puts "-" * 50
  end
end

tower = HanoiTower.new([5,4,3,2,1],[],[])
tower.solve(5, :tower1, :tower3)
