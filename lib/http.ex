defmodule Allbud.Http do
  @moduledoc false
  use Tesla

  require Logger

  @primary_url "https://www.allbud.com"
  @search_url "/marijuana-strains/search?sort=alphabet&letter="

  plug(Tesla.Middleware.BaseUrl, @primary_url)

  def fetch_strains_by_letter(params, results \\ 25) do
    Logger.info("Fetching strains by letter: " <> String.upcase(params))
    get(@search_url <> String.upcase(params) <> "&results=#{results}")
  end

  def fetch_strain_profile({name, url} = _params) do
    Logger.info("Fetching strain profile: " <> name)
    get("#{url}")
  end
end
