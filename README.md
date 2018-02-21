# Emphatis

**Tiny library to convert text into unicode bold/italic/script.**

Based on [`StringNaming`](https://github.com/am-kantox/string_naming).

## Using within other project

```elixir
def deps do
  [{:emphatis, "~> 0.2"}]
end
```

### Font variants

Available font variants are:

- bold
- italic
- bold_italic
- bold_script
- monospace
- double_struck
- fraktur
- sans_serif
- sans_serif_bold
- sans_serif_italic
- sans_serif_bold_italic

### Transformation

Just call `Emphatis.bold("string")` and get the string in bold:

```elixir
iex|1 ▶ variants = ~w|
...|1 ▶   bold italic bold_italic bold_script
...|1 ▶   monospace double_struck fraktur
...|1 ▶   sans_serif sans_serif_bold
...|1 ▶   sans_serif_italic sans_serif_bold_italic|a
iex|2 ▶ Enum.each(variants,
...|2 ▶   &IO.puts(apply(Emphatis, &1, ["Hello, 2018 year!"]))
...|2 ▶ )

𝐇𝐞𝐥𝐥𝐨, 𝟐𝟎𝟏𝟖 𝐲𝐞𝐚𝐫!
𝐻𝑒𝑙𝑙𝑜, 2018 𝑦𝑒𝑎𝑟!
𝑯𝒆𝒍𝒍𝒐, 2018 𝒚𝒆𝒂𝒓!
𝓗𝓮𝓵𝓵𝓸, 2018 𝔂𝓮𝓪𝓻!
𝙷𝚎𝚕𝚕𝚘, 𝟸𝟶𝟷𝟾 𝚢𝚎𝚊𝚛!
H𝕖𝕝𝕝𝕠, 𝟚𝟘𝟙𝟠 𝕪𝕖𝕒𝕣!
H𝔢𝔩𝔩𝔬, 2018 𝔶𝔢𝔞𝔯!
𝖧𝖾𝗅𝗅𝗈, 𝟤𝟢𝟣𝟪 𝗒𝖾𝖺𝗋!
𝗛𝗲𝗹𝗹𝗼, 𝟮𝟬𝟭𝟴 𝘆𝗲𝗮𝗿!
𝘏𝘦𝘭𝘭𝘰, 2018 𝘺𝘦𝘢𝘳!
𝙃𝙚𝙡𝙡𝙤, 2018 𝙮𝙚𝙖𝙧!
```

### Bonus track

`Emphatis` understands very simple subset of markdown:

```elixir
iex|1 ▶ Emphatis.yo! "*Hello, world, it’s 2018!*"
"𝐇𝐞𝐥𝐥𝐨, 𝐰𝐨𝐫𝐥𝐝, 𝐢𝐭’𝐬 𝟐𝟎𝟏𝟖!"
iex|2 ▶ Emphatis.yo! "*Hello,* _world_, it’s =2018=!"
"𝐇𝐞𝐥𝐥𝐨, 𝑤𝑜𝑟𝑙𝑑, it’s 𝟚𝟘𝟙𝟠!"
iex|3 ▶ Emphatis.yo! "/Hello/, #world#, it’s #2018#!"
"𝑯𝒆𝒍𝒍𝒐, 𝔀𝓸𝓻𝓵𝓭, it’s 2018!"
iex|4 ▶ Emphatis.yo! "`Hello, world`, it’s ~2018~!"
"𝙷𝚎𝚕𝚕𝚘, 𝚠𝚘𝚛𝚕𝚍, it’s 2018!"
iex|5 ▶ Emphatis.yo! "~Hello, world,~ it’s 2018!"
"H𝔢𝔩𝔩𝔬, 𝔴𝔬𝔯𝔩𝔡, it’s 2018!"
iex|6 ▶ Emphatis.yo! "=Hello, world, it’s 2018=!"
"H𝕖𝕝𝕝𝕠, 𝕨𝕠𝕣𝕝𝕕, 𝕚𝕥’𝕤 𝟚𝟘𝟙𝟠!"
```

Yes, the function name is `yo!`. Don’t ask.

## Using standalone

`Emphatis` provides an `escript` to run the transformation locally from the
command line. To make it working:

- `git clone git@github.com:amotion-city/emphatis.git`
- `cd emphatis`
- `mix do deps.get, escript.build`
- [optionally] `mix escript.install`
- `bin/emphatis` (`bin/emphatis -b -i "I am bold and italic"`)

## [Documentation](https://hexdocs.pm/emphatis).
