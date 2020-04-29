require '../minutes'
require 'rspec'

describe '#add_minutes', :multiple_expectations do
  it 'works' do
    # Same hour
    expect(add_minutes('12:57 AM', 2)).to eql('12:59 AM')

    # Next hour, same AM/PM
    expect(add_minutes('2:45 PM', 45)).to eql('3:30 PM')

    # Different AM/PM
    expect(add_minutes('10:57 AM', 129)).to eql('1:06 PM')
  end


  context 'when adding minutes going into the next day' do
    it 'works' do
      expect(add_minutes('10:57 PM', 187)).to eql('2:04 AM')

      # Same AM/PM
      expect(add_minutes('10:57 PM', 787)).to eql('12:04 PM')
    end
  end

  context 'when adding minutes that go beyond the next day' do
    it 'works' do
      expect(add_minutes('11:57 PM', 1447)).to eql('12:04 AM')

      # 2 days later, same AM/PM
      expect(add_minutes('11:57 PM', 2167)).to eql('12:04 PM')
    end
  end

  context 'with bad parameters' do
    it 'returns the time string if the minutes are bad' do
      expect(add_minutes('12:01 AM', nil)).to eql('12:01 AM')
      expect(add_minutes('12:01 AM', 'something bad')).to eql('12:01 AM')
    end

    it 'returns nil if the time string is bad' do
      expect(add_minutes('12: AM', 10)).to be_nil
      expect(add_minutes(':01 AM', 10)).to be_nil
      expect(add_minutes('12:01 XXX', 10)).to be_nil
      expect(add_minutes('something bad', 10)).to be_nil
    end
  end
end
