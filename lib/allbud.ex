defmodule Allbud do
  @moduledoc """
  Documentation for `Allbud`.
  """

  alias Allbud.Http

  @doc """
  Fetch all strains and strain profiles.

    ## Examples

  ```elixir
  iex> Allbud.all()
  ```
  """
  def all() do
    letters = Enum.map(?a..?z, fn x -> <<x::utf8>> end)

    strains =
      Enum.map(letters, fn x ->
        {:ok, strain} = fetch_strains_by_letter(x)
        strain
      end)
      |> List.flatten()

    Enum.map(strains, fn x ->
      fetch_strain_profile(x)
    end)
  end

  @doc """
  Fetch all strain names and url.

    ## Examples

  ```elixir
  iex> Allbud.fetch_strains()
  ```
  """
  def fetch_strains() do
    letters = Enum.map(?a..?z, fn x -> <<x::utf8>> end)

    Enum.map(letters, fn x ->
      {:ok, strain} = fetch_strains_by_letter(x)
      strain
    end)
  end

  @doc """
  Fetch by letter strain names and url.

    ## Examples

  ```elixir
  iex> Allbud.fetch_strains_by_letter("a")
  ```
  """
  def fetch_strains_by_letter(params) do
    {status, response} = Http.fetch_strains_by_letter(params)

    case(status) do
      :error ->
        {:error, response.message}

      :ok ->
        html = response.body

        {:ok, html} = Floki.parse_document(html)

        result =
          Floki.find(html, "#search-results")
          |> Floki.find("div.title-box")

        strains =
          Enum.map(result, fn x ->
            [{_, [{_, href}], [name]}] = Floki.find(x, "a")

            {name, href}
          end)

        {:ok, strains}
    end
  end

  @doc """
  Fetch strain profile.

    ## Examples

  ```elixir
  iex> Allbud.fetch_strain_profile({"strain name", "/"})
  ```
  """
  def fetch_strain_profile(params) do
    {name, _url} = params
    {status, response} = Http.fetch_strain_profile(params)

    case(status) do
      :error ->
        {:error, response.message}

      :ok ->
        html = response.body

        {:ok, html} = Floki.parse_document(html)

        result = Floki.find(html, "#strain_detail_accordion")

        strain_percentages =
          case Floki.find(result, "span.strain-percentages") do
            [{_, _, [strain_percentages]}] -> strain_percentages
            _ -> ""
          end

        [{_, _, [variety]}] =
          Floki.find(result, "h4.variety")
          |> Floki.find("a")

        data = Floki.find(result, "div.description")

        description = Floki.find(data, "span")

        {_, _, description} = List.last(description)

        description =
          Enum.map(description, fn x ->
            case x do
              {_, _, [name]} -> String.replace(name, "“", "") |> String.replace("”", "")
              str -> String.replace(str, "“", "") |> String.replace("”", "")
            end
          end)
          |> Enum.join("")

        data = Floki.find(result, "div#collapse_positive")
        data = Floki.find(data, "div.tags-list")
        data = Floki.find(data, "a")

        moods =
          Enum.map(data, fn x ->
            [{_, _, [name]}] = Floki.find(x, "a")

            name
          end)

        data = Floki.find(result, "div#collapse_relieved")
        data = Floki.find(data, "div.tags-list")
        data = Floki.find(data, "a")

        symptoms =
          Enum.map(data, fn x ->
            [{_, _, [name]}] = Floki.find(x, "a")

            name
          end)

        data = Floki.find(result, "div#collapse_flavors")
        data = Floki.find(data, "div.tags-list")
        data = Floki.find(data, "a")

        flavors =
          Enum.map(data, fn x ->
            [{_, _, [name]}] = Floki.find(x, "a")

            name
          end)

        data = Floki.find(result, "div#collapse_aromas")
        data = Floki.find(data, "div.tags-list")
        data = Floki.find(data, "a")

        aromas =
          Enum.map(data, fn x ->
            [{_, _, [name]}] = Floki.find(x, "a")

            name
          end)

        reply = %{
          description: description,
          name: String.trim(name),
          variety: String.trim(variety),
          strain_percentages: String.trim(strain_percentages),
          moods: moods,
          symptoms: symptoms,
          flavors: flavors,
          aromas: aromas
        }

        {:ok, reply}
    end
  end
end
