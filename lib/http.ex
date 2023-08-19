defmodule Allbud.Http do
  @moduledoc false
  use Tesla

  require Logger

  @primary_url "https://www.allbud.com"
  @search_url "/marijuana-strains/search?sort=alphabet&letter="
  @image_url "https://media.allbud.com/media/feature/strain/"

  plug(Tesla.Middleware.BaseUrl, @primary_url)

  @doc """
  Fetch strains by letter.

    ## Examples

  ```elixir
  iex> Allbud.Http.fetch_strains_by_letter("A")
  ```
  """
  def fetch_strains_by_letter(params, results \\ 25) do
    Logger.info("Fetching strains by letter: " <> String.upcase(params))
    get(@search_url <> String.upcase(params) <> "&results=#{results}")
  end

  @doc """
  Fetch strain profile.

    ## Examples

  ```elixir
  iex> Allbud.Http.fetch_strain_profile({"strain mane", "/"})
  ```
  """
  def fetch_strain_profile({name, url} = _params) do
    Logger.info("Fetching strain profile: " <> name)
    get("#{url}")
  end
end
