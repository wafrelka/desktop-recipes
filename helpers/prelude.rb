module EscapeHelper
    def escape(path)
        Shellwords.escape(path)
    end
end

MItamae::RecipeContext.include(EscapeHelper)
MItamae::ResourceContext.include(EscapeHelper)
