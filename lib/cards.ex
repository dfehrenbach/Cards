defmodule Cards do
  @moduledoc """
    Provides methods for creating and heandling a deck of cards
  """

  @doc """
    Returns a list of strigns representign a deck of playing cards
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", 
              "Five", "Six", "Seven", "Eight", 
              "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Shuffles a deck and returns it in a new order.
    The order has a chance of being the same as the original
  """
  def shuffle(deck) do
    Enum.shuffle(deck) 
  end

  @doc """
    Determines whether a deck contains a given card

  ## Examples

      iex> deck = Cards.create_deck 
      iex> Cards.contains?(deck, "Ace of Spades") 
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hant and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _rest_of_deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves deck information to a file
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Retrieves a deck from a saved file
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Creates a hand from a newly shuffled deck

  ## Examples

      iex> {_hand, rest_of_deck} = Cards.create_hand(52)
      iex> length(rest_of_deck)
      0

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
