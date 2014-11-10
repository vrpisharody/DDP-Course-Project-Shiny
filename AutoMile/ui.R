library(shiny)
data(mtcars)
mcars=mtcars[,-c(5,7,8)]

shinyUI(fluidPage(
  wellPanel(h1("Know Your Car\'s Fuel Efficiency",align='center')),
  
  sidebarLayout(
      sidebarPanel(
               helpText(h4("Provide Your Car Information"),
               strong("And"),
               br(),
               span(strong("We Will Give You Your Car\'s Efficiency"),style='color:blue'),
               align='center'
               
        ),
    
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
      submitButton('Predict'),
      br(),
      br(),
      br(),
      br(),
      offset=0
      ),
      
    mainPanel(
        column(6,
               br(),
               br(),
               br(),
               br(),
               img(src='Maserati.jpg'),
               br(),
               br(),
               h3("Your Car\'s Predicted Efficiency Is",align='center'),
               br(),
               h4(textOutput('mileagempg'),style='color:red',align='center'),
               h4("OR",align='center'),
               h4(textOutput('mileagekmpl'),style='color:green',align='center'),
               br(),
               br(),
               HTML("<hr style=\"border-color:#000000\" />"),
               p(strong("Best Viewed in", span('Google Chrome',style='color:blue'),
                 'with maximized Screen.', span('IE',style='color:blue'),
                  "sometimes doesnot run scripts required to calculate")),
               p("Set your display as required, if page doesnot show properly"),
               offset=1
        ),
  
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
            br(),
            img(src='carcollage.jpg'),
            offset=1   
       )
    )
  )
))