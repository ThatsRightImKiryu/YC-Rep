json.extract! page, :id, :page_number, :text, :writing_id, :created_at, :updated_at
json.url page_url(page, format: :json)
json.text page.text.to_s
