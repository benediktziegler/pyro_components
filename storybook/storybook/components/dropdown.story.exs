defmodule Storybook.Components.Dropdown do
  @moduledoc false
  use PhoenixStorybook.Story, :component

  def function, do: &PyroComponents.Components.Dropdown.dropdown/1

  def imports do
    [
      {PyroComponents.Components.Dropdown, [dropdown_item: 1, dropdown_divider: 1]},
      {PyroComponents.Components.Core, icon: 1}
    ]
  end

  def variations do
    [
      %Variation{
        id: :default,
        attributes: %{
          label: "Menu"
        },
        slots: [
          ~s|<.dropdown_item href="#" label="Settings"/>|,
          ~s|<.dropdown_item href="/components/data_table" label="Data Table"/>|
        ]
      },
      %Variation{
        id: :no_label,
        attributes: %{},
        slots: [
          ~s|<.dropdown_item href="#" label="Settings" icon_name="hero-cog-6-tooth-solid"/>|,
          """
          <.dropdown_item icon_name="hero-user-solid">
            User Profile
          </.dropdown_item>
          """,
          ~s|<.dropdown_item>Sign out</.dropdown_item>|
        ]
      },
      %Variation{
        id: :trigger,
        attributes: %{},
        slots: [
          """
          <:trigger>
            <div>
              <.icon name="hero-user-circle-solid"/>
              <.icon name="hero-chevron-down-solid" class="w-4 h-4 ml-1 -mr-1" />
            </div>
          </:trigger>
          """,
          ~s|<.dropdown_item href="#" label="Settings" icon_name="hero-cog-6-tooth-solid"/>|,
          ~s|<.dropdown_item href="/components/data_table" label="Data Table" icon_name="hero-table-cells-solid"/>|
        ]
      },
      %Variation{
        id: :trigger_and_label,
        attributes: %{},
        slots: [
          """
          <:trigger>
            <div>
              John Doe
              <.icon name="hero-user-circle-solid"/>
              <.icon name="hero-chevron-down-solid" class="w-4 h-4 ml-1 -mr-1" />
            </div>
          </:trigger>
          """,
          ~s|<.dropdown_item href="#" label="Settings" icon_name="hero-cog-6-tooth-solid"/>|,
          ~s|<.dropdown_divider/>|,
          ~s|<.dropdown_item label="Item A"/>|,
          ~s|<.dropdown_item label="Item B"/>|,
          ~s|<.dropdown_item label="Item C"/>|,
          ~s|<.dropdown_item label="Item D"/>|,
          ~s|<.dropdown_divider/>|,
          ~s|<.dropdown_item href="/components/data_table" label="Data Table" icon_name="hero-table-cells-solid"/>|
        ]
      }
    ]
  end
end
