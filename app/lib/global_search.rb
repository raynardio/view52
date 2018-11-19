class GlobalSearch
  include Elasticsearch::API

  CONNECTION = ::Faraday::Connection.new url: 'http://127.0.0.1:9200'

  def generate_id
    SecureRandom.base58 32
  end

  def put_item(db, type, item)
    index(
        index: db,
        type: type,
        id: item['Integer.id'],
        body: item
    )
  end

  def put_global_item(item)
    user_id = item.is_a?(User) ? item.id : item.user_id
    attrs = { 'Integer.user_id' => user_id }
    item.attributes.each do |k,v|
      unless v.nil?
        attrs["#{item.send(k).class.name}.#{k}"] = v
      end
    end
    put_item 'view52', item.class.name, attrs
  end

  def global_search(term, user_id)
    query =  {
      query: {
        bool: {
          must: [
            {
              match:
                {
                  'Integer.user_id': user_id
                }
            },
            {
              multi_match:
                {
                  query: term,
                  type: 'phrase_prefix',
                  fields: ['String.*']
                }
            }
          ]
        }
      }
    }
    (MultiJson.load search(
        index: 'view52',
        body: query
    ))['hits']['hits']
  end

  def perform_request(method, path, params, body, headers = nil)
    p "#{method} #{path} #{params} #{body} #{headers}"

    CONNECTION.run_request(
      method.downcase.to_sym,
      path,
      body ? MultiJson.dump(body) : nil,
      { 'Content-Type' => 'application/json' }
    )
  end
end
