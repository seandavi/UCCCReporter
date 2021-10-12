library(shiny)
library(bslib)
library(ggplot2)
library(gt)
library(data.table)

.datatable.aware = TRUE
records = get_patient_report() |> relationalize_patient_reports()
rural_zip_data = rural_zips()


unique_clinics = sort(unique(records$patient_clinics$Clinic_Identifier))

# Define UI for application that draws a histogram
ui <- navbarPage(
    # Application title
    "UCCC Clinical Ops Dashboard",

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            # sliderInput("bins",
            #             "Years:",
            #             sep = "",
            #             min = min(years),
            #             max = max(years),
            #             value = c(min(years),max(years))),
            # dateRangeInput("dates",
            #                "Dates:",
            #                start=min(records$FirstCancerCenterVisit_Date),
            #                end=max(records$FirstCancerCenterVisit_Date),
            #                min=min(records$FirstCancerCenterVisit_Date),
            #                max=max(records$FirstCancerCenterVisit_Date),
            #                format = "mm/dd/yy")
            selectizeInput('clinic','clinic',choices=unique_clinics),
            width=3
        ),

        # Show a plot of the generated distribution
        mainPanel(
            #plotOutput("distPlot"),
            #plotOutput("clinicPlot"),
            gt::gt_output('abc')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    dat = reactive({
        recs = records$patient_details |>
            merge(records$patient_clinics) |>
            setkey("arb_person_id","RN") |>
            merge(records$patient_first_visits) |>
            merge(records$patient_trials)
        recs = recs[Clinic_Identifier==input$clinic,]
        recs[,rural:=PostalCode %in% rural_zip_data$zip_code]
        recs
    })

    output$abc = render_gt({
        recs = dat()
        res = rbind(recs[,.(.N,field="Race"),by=Race][,Category:=Race][,Race:=NULL],
                    recs[,.(.N,field="Ethnicity"),by=Ethnicity][,Category:=Ethnicity][,Ethnicity:=NULL],
                    recs[,.(.N,field="Gender"),by=SexAssignedAtBirth][,Category:=SexAssignedAtBirth][,SexAssignedAtBirth:=NULL],
                    recs[,.(.N,field="Rural"),by=rural][,Category:=rural][,rural:=NULL])
        res |> gt::gt(res,groupname_col = 'field') |>
            gt::tab_header(
                title = "Clinic Statistics",
                subtitle = "for the selected clinic"
            ) |>
            gt::cols_move(
                columns = N,
                after = Category
            ) |>
            opt_table_font(
                font = list(
                    google_font("Lato"),
                    default_fonts()
                )
            ) |>
            gt::tab_options(
                row.striping.background_color = "#fafafa",
                table_body.hlines.color = "#f6f7f7",
                table.width = "100%",
                heading.title.font.size = 24,
                table.border.top.width = px(3),
                data_row.padding = px(0)
            )
    })

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        recs = dat()
        x    <- Filter(function(x) !is.na(x),as.integer(recs[['Age_At_FirstVisit']]))
        #bins <- seq(min(x), max(x), length.out = input$bins[2]-input$bins[1] + 1)

        # draw the histogram with the specified number of bins
        ggplot(data.frame(age=x),aes(x=age)) + geom_histogram()
    })

    output$clinicPlot <- renderPlot({
        recs = dat()
        recs[,.(clinic=unlist(strsplit(Clinic_Identifier,' \\| '),recursive=FALSE)),
             .(arb_person_id)][,.(visits=.N),by=.(clinic)][order(-visits)] |>
            head(10) |>
            ggplot(aes(x=reorder(clinic,visits),y=visits)) +
            geom_bar(stat='identity') +
            coord_flip()
    })
}

# Run the application
shinyApp(ui = ui, server = server)
