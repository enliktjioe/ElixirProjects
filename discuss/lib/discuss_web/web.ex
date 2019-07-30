def model do
  quote do
    use Ecto.Schema

    import Ecto
    import Ecto.Changeset
    import Ecto.Query
  end
end

def controller do
  quote do
    use Phoenix.Controller

    alias Discuss.Repo
    import Ecto
    import Ecto.Query

    import Discuss.Router.Helpers
    import Discuss.Gettext

    import MyHelperModule
  end
end

def view do
  quote do
    use Phoenix.View, root: "discuss_web/templates"

    # Import convenience functions from controllers
    import Phoenix.Controller, only: [get_csrf_token: 0, get_flash: 2]

    # Use all HTML functionality (forms, tags, etc)
    use Phoenix.HTML

    import Discuss.Router.Helpers
    import Discuss.ErrorHelpers
    import Discuss.Gettext
  end
end

def router do
  quote do
    use Phoenix.Router
  end
end
