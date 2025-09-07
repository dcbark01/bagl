function Completion(prompt: string) -> string {
  client "openai/gpt-4o"
  prompt #"
    {{ prompt }}
  "#
}

test TestCompletion {
  functions [Completion]
  args {
    prompt "What model are you?"
  }
}
