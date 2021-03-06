defmodule EllieWeb.ResultController do
  use EllieWeb, :controller
  alias Data.Uuid
  alias Ellie.Domain.Embed
  alias Ellie.Domain.Workspace
  alias Ellie.Domain.Api
  alias Ellie.Types.PrettyId
  alias EllieWeb.Token

  def workspace(conn, params) do
    with {:ok, token} <- Map.fetch(params, "token"),
         {:ok, workspace_string} <- Token.verify(token),
         {:ok, workspace} <- Uuid.parse(workspace_string),
         {:ok, {path, hash}} <- Workspace.result(workspace)
    do
      etag = "W/" <> Integer.to_string(hash, 16)
      if etag in get_req_header(conn, "if-none-match") do
        send_resp(conn, 304, "")
      else
        conn
        |> delete_resp_header("cache-control")
        |> put_resp_header("cache-control", "private, must-revalidate")
        |> put_resp_header("etag", etag)
        |> put_resp_content_type("application/javascript")
        |> send_file(200, path)
      end
    else
      _ -> send_resp(conn, 404, "")
    end
  end

  def embed(conn, %{"id" => id_param}) do
    etag = "W/" <> id_param
    if etag in get_req_header(conn, "if-none-match") do
      send_resp(conn, 304, "")
    else
      with {:ok, id} <- PrettyId.cast(id_param),
           revision when not is_nil(revision) <- Api.retrieve_revision(id),
           {:ok, path} <- Embed.result(revision)
      do
        conn
        |> delete_resp_header("cache-control")
        |> put_resp_header("cache-control", "public, max-age=600")
        |> put_resp_header("etag", etag)
        |> put_resp_content_type("application/javascript")
        |> send_file(200, path)
      else
        _ -> send_resp(conn, 404, "")
      end
    end
  end
end
