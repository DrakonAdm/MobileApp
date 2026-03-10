import SwiftUI

struct Nike_Member: View {

    @Environment(\.dismiss) private var dismiss
    let goToProfile: () -> Void

    @State private var code = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var password = ""
    @State private var birthDate: Date? = nil

    @State private var showDatePicker = false
    @State private var showError = false

    @FocusState private var focusedField: Field?

    enum Field {
        case code, firstName, lastName, password
    }

    var isFormValid: Bool {
        !code.isEmpty &&
        !firstName.isEmpty &&
        !lastName.isEmpty &&
        !password.isEmpty &&
        birthDate != nil
    }

    var body: some View {
        VStack(spacing: 0) {

            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .foregroundColor(.blue)

                Spacer()

                Text("accounts.nike.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Spacer()

                Image(systemName: "arrow.clockwise")
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(UIColor.systemGray6))

            ScrollView {
                VStack(alignment: .leading, spacing: 26) {

                    Image("nike_black")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 160)
                        .padding(.leading, -30)

                    Text("Now let's make you a\nNike Member.")
                        .font(.system(size: 32, weight: .bold))

                    field("Code") {
                        TextField("", text: $code)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .code)
                    }

                    HStack(spacing: 16) {
                        field("First name") {
                            TextField("", text: $firstName)
                                .focused($focusedField, equals: .firstName)
                        }

                        field("Surname") {
                            TextField("", text: $lastName)
                                .focused($focusedField, equals: .lastName)
                        }
                    }

                    field("Password") {
                        SecureField("", text: $password)
                            .focused($focusedField, equals: .password)
                    }

                    Button {
                        showDatePicker = true
                    } label: {
                        field("Date of Birth") {
                            Text(birthDate == nil
                                 ? "Select your birthday"
                                 : birthDate!.formatted(date: .numeric, time: .omitted))
                                .foregroundColor(birthDate == nil ? .gray : .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }

            Button("Перейти в профиль") {
                if isFormValid {
                    goToProfile()
                } else {
                    showError = true
                }
            }
            .font(.system(size: 18, weight: .semibold))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Capsule().fill(isFormValid ? Color.black : Color.gray))
            .foregroundColor(.white)
            .padding(.horizontal, 24)
            .padding(.bottom, 24)
            .disabled(!isFormValid)
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    focusedField = nil
                }
            }
        }
        .alert("Fill all fields", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Please complete all fields before continuing.")
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker(
                    "Select your birthday",
                    selection: Binding(
                        get: { birthDate ?? Date() },
                        set: { birthDate = $0 }
                    ),
                    displayedComponents: .date
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .padding()

                Button("Done") {
                    showDatePicker = false
                }
                .padding()
            }
        }
    }

    private func field(_ title: String, content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.footnote)
                .foregroundColor(.gray)

            content()
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color(.systemGray6))
                .cornerRadius(10)
        }
    }
}
