require 'database'

describe Database do
  describe '#connect' do
    it 'connects using PG.connect' do
      expect(PG).to receive(:connect).with(dbname: 'database_name').and_return(described_class.connection)
      described_class.connect('database_name')
    end
  end

  describe '#connection' do
    it 'returns the connection received from #connect' do
      allow(PG).to receive(:connect).and_return(described_class.connection)
      connection = described_class.connect('database_name')
      expect(described_class.connection).to eq(connection)
    end
  end

  describe '#query' do
    it 'executes a query using exec_params' do
      expect(described_class.connection).to receive(:exec_params).with('INSERT INTO table_name VALUES ($1);', [1])
      described_class.query('INSERT INTO table_name VALUES ($1);', [1])
    end
  end
end
