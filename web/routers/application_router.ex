defmodule ApplicationRouter do
  use Dynamo.Router

  prepare do
    # Pick which parts of the request you want to fetch
    # You can comment the line below if you don't need
    # any of them or move them to a forwarded router
    conn.fetch([:cookies, :params])
  end

  # It is common to break your Dynamo into many
  # routers, forwarding the requests between them:
  # forward "/posts", to: PostsRouter

  get "/" do
    conn = conn.assign(:title, "Welcome to Concurrenty Story Teller v0.1!")
    render conn, "index.html"
  end

  get "/:file_name" do
    normalized_title = String.capitalize(String.replace(conn.params[:file_name], "-", " "))
    conn = conn.assign :title, normalized_title
    conn = conn.assign :file_name, conn.params[:file_name]
    render conn, "story.html"
  end
end
