defmodule PyroComponents.Components.Dropdown do
  @moduledoc """
  Tooling and components for dropdowns.
  """
  use Pyro.Component

  import PyroComponents.Components.Core

  @doc """
  A dropdown component.

  <.dropdown>
    <.dropdown_item label="Settings" navigate={~p"/settings"} />
    <.dropdown_item label="Sign in" navigate={~p"/login"} />
  </.dropdown>
  """
  attr :overrides, :list, default: nil, doc: @overrides_attr_doc

  attr :options_container_id, :string
  attr :label, :string, default: nil, doc: "label for the dropdown option"

  attr :class, :css_classes,
    overridable: true,
    doc: "merge/override default classes of the `dropdown` component"

  attr :icon_class, :css_classes,
    overridable: true,
    doc: "merge/override default classes of the main trigger `icon` component"

  attr :items_wrapper_class, :css_classes,
    overridable: true,
    doc: "merge/override default classes of the `dropdown_item_wrapper` component"

  attr :trigger_btn_class, :css_classes,
    overridable: true,
    doc: "merge/override default classes of the `dropdown_trigger_button` component"

  attr :no_label_icon_name, :string, overridable: true, doc: "icon for the dropdown when a label is not provided"
  attr :placement, :string, default: "left", values: ["left", "right"], doc: "placement of the dropdown"
  attr :toggle_js, :any, overridable: true, required: true
  attr :hide_js, :any, overridable: true, required: true

  attr :rest, :any, default: nil, doc: "additional HTML attributes added to the dropdown"
  slot :trigger
  slot :inner_block, required: false, doc: "the slot for the dropdown items"

  def dropdown(assigns) do
    assigns =
      assigns
      |> assign_overridables()
      |> assign_new(:options_container_id, fn -> "dropdown_#{Ecto.UUID.generate()}" end)

    ~H"""
    <div class={@class} phx-click-away={apply(@hide_js, [%JS{}, @options_container_id])}>
      <div>
        <button
          type="button"
          id={"button_" <> @options_container_id}
          class={@trigger_btn_class}
          phx-click={apply(@toggle_js, [%JS{}, @options_container_id])}
          aria-haspopup="true"
          aria-expanded="false"
          aria-controls={@options_container_id}
        >
          <span class="sr-only">Toggle Dropdown</span>

          <%= if @label do %>
            <%= @label %>
            <.icon name="hero-chevron-down-solid" class={@icon_class} />
          <% end %>

          <%= if @trigger do %>
            <%= render_slot(@trigger) %>
          <% end %>

          <%= if !@label && @trigger == [] do %>
            <.icon name="hero-ellipsis-vertical-solid" class="pyro_dropdown__ellipsis" />
          <% end %>
        </button>
      </div>
      <div
        class={"pyro_dropdown__menu_items_wrapper_placement__#{@placement} pyro_dropdown__items_wrapper hidden"}
        role="menu"
        tabindex="-1"
        id={@options_container_id}
        aria-orientation="vertical"
        aria-labelledby={"button_" <> @options_container_id}
      >
        <div class="py-1" role="none">
          <%= render_slot(@inner_block) %>
        </div>
      </div>
    </div>
    """
  end

  attr :overrides, :list, default: nil, doc: @overrides_attr_doc

  attr :href, :any, default: nil, doc: "href for the dropdown item"
  attr :navigate, :string, default: nil, doc: "navigate for the dropdown item"
  attr :patch, :string, default: nil, doc: "patch for the dropdown item"

  attr :label, :string, required: true, doc: "label for the dropdown item"
  attr :class, :css_classes, overridable: true, doc: "merge/override default classes of the `dropdown_item` component"
  attr :icon_name, :string, default: nil, doc: "icon for the dropdown item"
  attr :icon_class, :css_classes, overridable: true, doc: "merge/override default classes of the `icon` component"

  slot :inner_block, required: false

  def dropdown_item(assigns) do
    assigns
    |> assign_overridables()
    |> render_dropdown_item()
  end

  def render_dropdown_item(%{href: nil, patch: nil, navigate: nil} = assigns) do
    ~H"""
    <div class={@class}>
      <.icon :if={@icon_name} overrides={@overrides} name={@icon_name} class={@icon_class} />
      <span :if={!@icon_name} class="pyro_icon"/>
      <%= render_slot(@inner_block) || @label %>
    </div>
    """
  end

  def render_dropdown_item(%{href: _href} = assigns) do
    ~H"""
    <.link href={@href} class={@class}>
      <.icon :if={@icon_name} overrides={@overrides} name={@icon_name} class={@icon_class} />
      <span :if={!@icon_name} class="pyro_icon"/>
      <%= render_slot(@inner_block) || @label %>
    </.link>
    """
  end

  def render_dropdown_item(%{patch: _patch} = assigns) do
    ~H"""
    <.link patch={@patch} class={@class}>
      <.icon :if={@icon_name} overrides={@overrides} name={@icon_name} class={@icon_class} />
      <span :if={!@icon_name} class="pyro_icon"/>
      <%= render_slot(@inner_block) || @label %>
    </.link>
    """
  end

  def render_dropdown_item(%{navigate: _navigate} = assigns) do
    ~H"""
    <.link navigate={@navigate} class={@class}>
      <.icon :if={@icon_name} overrides={@overrides} name={@icon_name} class={@icon_class} />
      <span :if={!@icon_name} class="pyro_icon"/>
      <%= render_slot(@inner_block) || @label %>
    </.link>
    """
  end

  attr :overrides, :list, default: nil, doc: @overrides_attr_doc
  attr :class, :css_classes, overridable: true, doc: "merge/override default classes of the `dropdown_item` component"

  def dropdown_divider(assigns) do
    assigns = assign_overridables(assigns)

    ~H"""
    <hr class="my-12 w-11/12 h-0.5 border-t-0 bg-neutral-100 dark:bg-white/10" />
    """
  end
end
