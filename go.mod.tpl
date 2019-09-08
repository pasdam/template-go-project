module {{ .modulePath }}

replace {{ .modulePath }}/pkg => ./pkg

go 1.15
