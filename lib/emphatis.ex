defmodule Emphatis do
  @moduledoc """
  The module providing basic markdown-like syntax parsing to unicode
    representations involving different fonts to show the input
    emphasized in plain text environments (like twitter.)
  """

  @typefaces ~w|bold italic bold_italic bold_script
                double_struck monospace fraktur
                sans_serif sans_serif_bold
                sans_serif_italic sans_serif_bold_italic|a

  @doc """

  ## Possible variants:

      𝟓: :bolddigits_mathematical_bold_digit_five
      𝐀: :boldsymbols_mathematical_bold_capital_a

      𝐴: :italicsymbols_mathematical_italic_capital_a
      𝑨: :bolditalicsymbols_mathematical_bold_italic_capital_a

      𝟝: :doublestruckdigits_mathematical_double_struck_digit_five
      𝔸: :doublestrucksymbols_mathematical_double_struck_capital_a

      𝟻: :monospacedigits_mathematical_monospace_digit_five
      𝙰: :monospacesymbols_mathematical_monospace_capital_a

  ## Examples

      iex> Emphatis.bold "Hello, world, it’s 2018!"
      "𝐇𝐞𝐥𝐥𝐨, 𝐰𝐨𝐫𝐥𝐝, 𝐢𝐭’𝐬 𝟐𝟎𝟏𝟖!"

  """
  Enum.each(@typefaces, fn typeface ->
    def unquote(typeface)(input) when is_binary(input) do
      input
      |> to_charlist()
      |> Enum.map(&safe_convert(&1, unquote(typeface)))
      |> Enum.join()
    end
  end)

  ##############################################################################

  @markdown %{
    "/" => :bold_italic,
    "_" => :italic,
    "#" => :bold_script,
    "*" => :bold,
    "`" => :monospace,
    "~" => :fraktur,
    "=" => :double_struck
  }

  @doc """
  Please note that not all the font conversions work for digits.

  ## Examples

      iex> Emphatis.yo! "*Hello, world, it’s 2018!*"
      "𝐇𝐞𝐥𝐥𝐨, 𝐰𝐨𝐫𝐥𝐝, 𝐢𝐭’𝐬 𝟐𝟎𝟏𝟖!"
      iex> Emphatis.yo! "*Hello,* _world_, it’s =2018=!"
      "𝐇𝐞𝐥𝐥𝐨, 𝑤𝑜𝑟𝑙𝑑, it’s 𝟚𝟘𝟙𝟠!"
      iex> Emphatis.yo! "/Hello/, #world#, it’s #2018#!"
      "𝑯𝒆𝒍𝒍𝒐, 𝔀𝓸𝓻𝓵𝓭, it’s 2018!"
      iex> Emphatis.yo! "`Hello, world`, it’s ~2018~!"
      "𝙷𝚎𝚕𝚕𝚘, 𝚠𝚘𝚛𝚕𝚍, it’s 2018!"
      iex> Emphatis.yo! "~Hello, world,~ it’s 2018!"
      "H𝔢𝔩𝔩𝔬, 𝔴𝔬𝔯𝔩𝔡, it’s 2018!"
      iex> Emphatis.yo! "=Hello, world, it’s 2018=!"
      "H𝕖𝕝𝕝𝕠, 𝕨𝕠𝕣𝕝𝕕, 𝕚𝕥’𝕤 𝟚𝟘𝟙𝟠!"

  """
  def yo!(input) do
    Enum.reduce(@markdown, input, fn {k, fun}, acc ->
      re = Regex.escape(k)
      re = Regex.compile!("(?:#{re})([^#{re}]+?)(?:#{re})")

      Regex.replace(re, acc, fn _, value ->
        apply(Emphatis, fun, [value])
      end)
    end)
  end

  defp module_atom(glyph, typeface) when typeface in @typefaces do
    typeface = to_string(typeface)

    namespace =
      typeface
      |> Macro.camelize()
      |> Kernel.<>(namespace_form(glyph))

    trailing_modules =
      typeface
      |> String.split("_")
      |> Enum.map(&String.capitalize/1)

    Module.concat(
      ["StringNaming", namespace, "Mathematical" | trailing_modules] ++ [trailing_form(glyph)]
    )
  end

  defp namespace_form(glyph) when glyph in ?0..?9, do: "Digits"

  defp namespace_form(glyph)
       when glyph in ?a..?z
       when glyph in ?A..?Z,
       do: "Symbols"

  defp namespace_form(_), do: "Unknowns"

  defp trailing_form(glyph) when glyph in ?0..?9, do: "Digit"
  defp trailing_form(glyph) when glyph in ?a..?z, do: "Small"
  defp trailing_form(glyph) when glyph in ?A..?Z, do: "Capital"
  defp trailing_form(_), do: "Unknown"

  defp to_name(48), do: :zero
  defp to_name(49), do: :one
  defp to_name(50), do: :two
  defp to_name(51), do: :three
  defp to_name(52), do: :four
  defp to_name(53), do: :five
  defp to_name(54), do: :six
  defp to_name(55), do: :seven
  defp to_name(56), do: :eight
  defp to_name(57), do: :nine
  defp to_name(glyph) when glyph in ?A..?Z, do: to_name(glyph + 32)

  defp to_name(glyph) when glyph in ?a..?z,
    do: [glyph] |> to_string() |> String.downcase() |> String.to_atom()

  defp safe_convert(glyph, typeface) when is_integer(glyph) and typeface in @typefaces do
    with mod <- module_atom(glyph, typeface),
         {:module, mod} <- Code.ensure_loaded(mod),
         fun <- to_name(glyph),
         0 <- mod.__info__(:functions)[fun] do
      apply(mod, fun, [])
    else
      _ -> to_string([glyph])
    end
  end

  ##############################################################################

  @usage "Usage: emphatis -f | -m | -d | -t | [ -b -i -s ] text"

  def main(args) do
    args
    |> parse_args()
    |> process()
    |> IO.puts()
  end

  def process([]) do
    IO.puts(@usage)
  end

  def process({options, text}) do
    if (options[:yo]) do
      Emphatis.yo!(text)
    else
      font_process(options, text)
    end
  end

  defp font_process(options, text) do
    font =
      cond do
        options[:fraktur] ->
          "fraktur"

        options[:monospace] ->
          "monospace"

        options[:struck] ->
          "struck"

        options[:script] ->
          "bold_script"

        true ->
          ~w|sans_serif bold italic|a
          |> Enum.filter(&options[&1])
          |> Enum.join("_")
      end

    if font == "" or text == "" do
      @usage
    else
      apply(Emphatis, String.to_atom(font), [text])
    end
  end

  # bold
  # bold_italic
  # bold_script
  # double_struck
  # fraktur
  # italic
  # monospace
  # sans_serif
  # sans_serif_bold
  # sans_serif_bold_italic
  # sans_serif_italic
  defp parse_args(args) do
    {options, text, _} =
      OptionParser.parse(
        args,
        strict: [
          yo: :boolean,
          sans_serif: :boolean,
          bold: :boolean,
          italic: :boolean,
          script: :boolean,
          monospace: :boolean,
          struck: :boolean,
          fraktur: :boolean
        ],
        aliases: [
          y: :yo,
          s: :sans_serif,
          b: :bold,
          i: :italic,
          t: :script,
          m: :monospace,
          d: :struck,
          f: :fraktur
        ]
      )

    text =
      text
      |> Enum.map(fn
        <<"\"", text::binary>> -> String.trim_trailing(text, "\"")
        <<"'", text::binary>> -> String.trim_trailing(text, "'")
        text -> text
      end)
      |> Enum.join(" ")

    {options, text}
  end
end
