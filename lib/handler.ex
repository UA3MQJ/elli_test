defmodule ElliTest.Handler do
  @behaviour :elli_handler
  require Logger

  # Record.defrecord :req, Record.extract(:req, from_lib: "elli/include/elli.hrl")

  def handle(req, _args) do
    # path = :elli_request.path(req)
    # Logger.debug "#{inspect path}"
    handle(:elli_request.method(req), :elli_request.path(req), req)
  end
  
  def handle(:GET, [], _req), do: ok("")
  def handle(:GET, [path], _req), do: ok(path)


  def handle(_, _, _), do: not_found()

  def handle_event(:elli_startup, [], _) do
    Logger.info ":elli starting up"
    :ok
  end

  # def handle_event(
  #   :request_complete,
  #   [req, response_code, _response_headers, _response_body, {timings, _}],
  #   _) do
  #   Logger.debug fn ->
  #     req_time = (timings[:request_end] - timings[:request_start]) / 1000
  #     send_time = (timings[:send_end] - timings[:send_start]) / 1000
  #     hdr_time = (timings[:headers_end] - timings[:headers_start]) / 1000
  #     body_time = (timings[:body_end] - timings[:body_start]) / 1000
  #     user_time = (timings[:user_end] - timings[:user_start]) / 1000
  #     "#{:elli_request.method(req)} #{:elli_request.path(req) |> Enum.join("/")} : #{response_code} req:#{req_time} send:#{send_time} user:#{user_time} hdr:#{hdr_time} body:#{body_time}"
  #   end
  #   :ok
  # end

  def handle_event(_event, _, _), do: :ok

  defp not_found(), do: {404, [{"Server", "round1 (ets, jiffy, elli)"}], ""}


  defp ok(resp) do
    {200,
     [{"Server", "elli"},
      {"Content-Type", "text/plain"},
      {"Connection", "close"}],
      "Hi there, I love " <> resp <> "!"}
  end

end