use Mix.Config

# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :string_naming, categories:
  ~w|
      AdditionalBoldGreekSymbols
      AdditionalBoldItalicGreekSymbols
      AdditionalCircledNumber
      AdditionalDependentVowelSigns
      AdditionalDiacriticalMarkForSymbols
      AdditionalDiacriticalMarksForSymbols
      AdditionalEnclosingDiacritics
      AdditionalHistoricVowel
      AdditionalItalicGreekSymbols
      AdditionalConsonant
      AdditionalConsonants
      AdditionalLetter
      AdditionalLetterlikeSymbols
      AdditionalLetters
      AdditionalPunctuation
      AdditionalSansSerifBoldGreekSymbols
      AdditionalSansSerifBoldItalicGreekSymbols
      AdditionalWhiteOnBlackCircledNumber

      BoldDigits
      BoldFrakturSymbols
      BoldGreekSymbols
      BoldItalicGreekSymbols
      BoldItalicSymbols
      BoldScriptSymbols
      BoldSymbols

      CircleSymbols
      CircleVowels
      CircledArrows
      CircledLatinLetterSequences
      CircledLatinLetters
      CircledNumbers

      DoubleArrows
      DoubleCircledNumbers
      DoubleDiacritic
      DoubleDiacritics
      DoubleHyphen

      DoubleStruckDigits
      DoubleStruckItalicMathSymbols
      DoubleStruckLargeOperator
      DoubleStruckSymbols

      FrakturSymbols

      FullwidthAsciiVariants
      FullwidthBrackets
      FullwidthSymbolVariants

      ItalicGreekSymbols
      ItalicSymbols

      Letter
      LetterA
      LetterExtender
      LetterForAfricanLanguages
      LetterForGermanDialectology
      LetterForWestAfricanLanguages
      LetterlikeSymbol
      LetterlikeSymbols
      Letters
      LettersForAfricanLanguages
      LettersForAmericanistOrthographies
      LettersForGermanDialectology
      LettersForMiddleVietnamese
      LettersForOldAbkhasianOrthography
      LettersForOldCyrillic

      MonospaceDigits
      MonospaceSymbols

      ParenthesizedLatinLetters
      ParenthesizedNumbers

      RegionalIndicatorSymbols

      SansSerifArrows
      SansSerifBoldDigits
      SansSerifBoldGreekSymbols
      SansSerifBoldItalicGreekSymbols
      SansSerifBoldItalicSymbols
      SansSerifBoldSymbols
      SansSerifDigits
      SansSerifItalicSymbols
      SansSerifSymbols

      ScriptSymbols

      SmallLetters
      SmallFormVariants

      Special
      SpecialCharacter
      SpecialCharacterExtension
      SpecialCharacterExtensions
      Specials

      SquaredLatinAbbreviation
      SquaredLatinAbbreviations
      SquaredLatinLetterSequences
      SquaredLatinLetterSequencesFromAribStdB62
      SquaredLatinLetters

      Subscripts
      Superscripts

      TagComponents
      TagIdentifiers

      UppercaseConsonants
      UppercaseLatinAlphabet
      UppercaseLetters
      UppercaseSyllables
      UppercaseVowels

      VariantLetterform
      VariantLetterforms
      VariantLetterformsAndSymbols

      Vowel
      VowelLengthSign
      VowelLetters
      VowelRimes
      VowelSigns
      Vowels
      VowelsAndFinals

      WhiteOnBlackCircledLatinLetters
      WhiteOnBlackCircledNumbers
      WhiteOnBlackSquaredLatinLetters
    |

if File.exists?("#{Mix.env}.exs"), do: import_config "#{Mix.env}.exs"
