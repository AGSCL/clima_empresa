library(shiny)
if(!require(shinyforms)){devtools::install_github("daattali/shinyforms",force=T)}

# Define the first form: basic information
basicInfoForm <- list(
  id = "basicinfo",
  questions = list(
    list(id = "correo", type = "text", title = "Correo electrónico", mandatory = TRUE,
         hint = "Favor incluir el correo Verisure"),
    list(id = "favourite_pkg", type = "text", title = "Favourite R package",mandatory = TRUE),
    list(id = "terms", type = "checkbox", title = "I agree to the terms",mandatory = TRUE)
  ),
  storage = list(
    type = STORAGE_TYPES$FLATFILE,
    path = "responses"
  ),
  name = "Encuesta",
  password = "encuesta2021",
  reset = TRUE,
  validations = list(
    list(condition = "grepl('@',input$correo)",
         message = "Correo: Debe ser un correo válido"),
    list(condition = "nchar(input$correo) >= 7",
         message = "Correo: Debe ser un correo válido"),
    list(condition = "input$terms == TRUE",
         message = "Debe aceptar los términos de acuerdo")
  )
)

ui <- fluidPage(
  h1("Ejemplo de encuestas hechas por Shiny"),
  tabsetPanel(
    tabPanel(
      "Información Básica",
      formUI(basicInfoForm)
    )
  )
)

server <- function(input, output, session) {
  formServer(basicInfoForm)
}

shinyApp(ui = ui, server = server)