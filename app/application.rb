class Application
    
    @@items = []

    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            item_name = req.path.split("/items/").last
            found_item = @@items.find { |item| item.name == item_name }
            if found_item
                resp.write found_item.price
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end