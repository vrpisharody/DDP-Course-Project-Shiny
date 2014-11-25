### This application predicts an automobile's fuel efficiency based
### on user inputs. It uses the mtcars dataset to run a regression model
### to predict an automobile's efficiency.

library(shiny)
library(markdown)

#Load and subset required mtcars dataset
data(mtcars)
mcars=mtcars[,-c(5,7,8)]

shinyUI(navbarPage("",
                   
  tabPanel("Know Your Car",
       fluidPage(
           # Configure the title or header panel
           wellPanel(h1("Know Your Car\'s Fuel Efficiency",align='center')),
           
           # Configure the input panel on the left side.
           sidebarLayout(
               
               # Configure the header in the input panel.
               sidebarPanel(
                   helpText(h4("Provide Your Car Information"),
                            strong("And"),
                            br(),
                            span(strong("We Will Give You Your Car\'s Efficiency"),style='color:blue'),
                            align='center'
                            
                   ),
                   tags$style(type="text/css", ".jslider .jslider-label{font-size: 12px;}"),
                   tags$style(type="text/css", ".jslider .jslider-value{font-size: 12px;}"),
                   # Insert the input boxes.
                   selectInput("cyl", strong("Number Of Cylinders"), 
                               choices=c(sort(unique(mcars$cyl))),selected=1),
                   sliderInput("disp", strong("Displacement - cu.in."), 
                               min=min(mcars$disp),max=max(mcars$disp),value=mean(mcars$disp)),
                   selectInput("am", strong("Transmission"), 
                               choices=list('Manual'=1,'Auto'=0),selected=0),
                   sliderInput("hp", strong("Horsepower"), 
                               min=min(mcars$hp),max=max(mcars$hp),value=mean(mcars$hp)),
                   selectInput("gear", strong("Number Of Gears"), 
                               choices=c(sort(unique(mcars$gear))),selected=4),
                   sliderInput("wt", strong("Weight Of The Car-1000 lbs"), 
                               min=min(mcars$wt),max=max(mcars$wt),value=mean(mcars$wt)),
                   selectInput("carb", strong("Number Of Carburettors"), 
                               choices=c(sort(unique(mcars$carb))),selected=1),
                   br(),
                   #Add submit button with proper spacing before and after it.
                   submitButton('Predict'),
                   br(),
                   br(),
                   br(),
                   br(),
                   offset=0
               ),
               
               mainPanel(
                   # Split Main panel in to separate columns - for prediction and for information.
                   column(6,
                          p(em(strong('Read information in right side panel to run application')),style='color:red'),
                          br(),
                          br(),
                          br(),
                          # Add car image to have an attractive page.
                          img(src='Maserati.jpg'),
                          br(),
                          br(),
                          h3("Your Car\'s Predicted Efficiency Is",align='center'),
                          br(),
                          # Add output text for server
                          h4(textOutput('mileagempg'),style='color:red',align='center'),
                          h4("OR",align='center'),
                          h4(textOutput('mileagekmpl'),style='color:green',align='center'),
                          br(),
                          br(),
                          # Add horizontal rule line and help ful notes for the screen.
                          HTML("<hr style=\"border-color:#000000\" />"),
                          p(strong("Best Viewed in", span('Google Chrome',style='color:blue'),
                                   'with maximized Screen.', span('IE',style='color:blue'),
                                   "sometimes doesnot run scripts required to calculate")),
                          p("Set your display as required, if page doesnot show properly"),
                          offset=1
                   ),
                   
                   # The information column
                   column(4,
                          h3("Efficiency Predictor",style='color:blue'),
                          
                          p('This application uses the',span(strong("mtcars"),style='color:red'),
                            'dataset to predict an automobile\'s efficiency.',style='text-align:justify'),
                          p('The panel on the left accepts inputs from the user and uses a 
                             regression model to predict an automobile\'s fuel efficiency in
                             miles per gallon (mpg) and kilometers per litre (kmpl).',style='text-align:justify'),
                          p('Specification on',span(strong('number of cylinders, displacement, horsepower'),
                                                    style='color:red'),"etc are to be entered by the user in the left 
                            input panel.",code("sliderInput"),"and",code("selectInput"),"widgets 
                            are used. Once the user has entered all required information, the user
                            presses the", span(strong("\"Predict\""),style='color:blue'),'button at the
                            bottom of the panel. The application then calculates and predicts 
                            the automobile\'s fuel efficiency in the center panel.',style='text-align:justify'),
                          p(strong(em('Use the')),span(strong(em("About")),style='color:blue'),strong(em("tab to know
                             more on the application"))),
                          br(),
                          img(src='carcollage.jpg'),
                          offset=1   
                   )
               )
           )
        )
    ),
  tabPanel("About",
             column(1,""),
             column(7,
             includeMarkdown("about.md"))),
  tabPanel("UI", pre(includeText("ui.R"))),
  tabPanel("Server", pre(includeText("server.R")))
  
))