import ProjectDescription

let workspace = Workspace.workspace(name: "Surveys")

extension Workspace {

    static func workspace(name: String) -> Workspace {
        return Workspace(
            name: name,
            projects: ["./**"],
            generationOptions: .options(
                autogeneratedWorkspaceSchemes:
                        .disabled
            )
        )
    }
}
