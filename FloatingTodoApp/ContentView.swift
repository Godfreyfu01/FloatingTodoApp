import SwiftUI

struct TodoItem: Identifiable {
    var id = UUID()
    var text: String
    var completed: Bool = false
}

struct ContentView: View {
    @State private var newTodo = ""
    @State private var todos = [TodoItem]()
    @State private var completedTodos = [TodoItem]()
    @State private var isAwake = true // 初始状态设置为 true 以显示黄线

    var body: some View {
        ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    createTextField()
                    createAddButton()
                }
                .padding()

                createTodoList()
                if !completedTodos.isEmpty {
                    createCompletedTodosSection()
                }
            }
            .padding()
            .customBorderStyle(isAwake: isAwake) // 使用自定义样式控制黄线显示
        }
        .onAppear {
            if let window = NSApplication.shared.windows.first {
                window.contentView?.layer?.borderColor = NSColor.clear.cgColor
            }
        }
        .onTapGesture {
            withAnimation {
                isAwake.toggle() // 切换黄线显示状态
            }
        }
    }

    private func addTodo() {
        if !newTodo.isEmpty {
            todos.append(TodoItem(text: newTodo))
            newTodo = "" // 清空文本框内容
        }
    }

    private func createTextField() -> some View {
        TextField("你要做什么事？", text: $newTodo)
            .textFieldStyle(PlainTextFieldStyle())
            .padding()
            .cornerRadius(5)
            .font(.system(size: 14, weight: .bold))
            .customTextStyle()
            .onSubmit {
                addTodo()
            }
    }

    private func createAddButton() -> some View {
        Button(action: {
            addTodo()
        }) {
            Image(systemName: "plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .customIconStyle() // 使用自定义图标样式
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func createTodoList() -> some View {
        List {
            ForEach(todos.indices, id: \.self) { index in
                let todo = todos[index]
                if !todo.completed {
                    createTodoRow(todo: todo, index: index)
                }
            }
        }
        .listStyle(PlainListStyle())
        .scrollContentBackground(.hidden)
    }

    private func createTodoRow(todo: TodoItem, index: Int) -> some View {
        HStack {
            Text(todo.text)
                .customTextStyle()

            Spacer()

            Button(action: {
                todos[index].completed = true
                completedTodos.append(todos[index])
                todos.remove(at: index)
            }) {
                Image(systemName: "checkmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .customIconStyle() // 使用自定义图标样式
                    .padding(.trailing, 8)
            }
            .buttonStyle(PlainButtonStyle())

            Button(action: {
                todos.remove(at: index)
            }) {
                Image(systemName: "trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .customIconStyle() // 使用自定义图标样式
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private func createCompletedTodosSection() -> some View {
        VStack(alignment: .leading) {
            Text("Completed Todos")
                .font(.headline)
                .customTextStyle()

            List(completedTodos.indices, id: \.self) { index in
                let todo = completedTodos[index]
                HStack {
                    Text(todo.text)
                        .customTextStyle()

                    Spacer()

                    Button(action: {
                        completedTodos.remove(at: index)
                    }) {
                        Image(systemName: "trash")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .customIconStyle() // 使用自定义图标样式
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .background(Color.clear)
            .listStyle(PlainListStyle())
            .scrollContentBackground(.hidden)
        }
    }
}
