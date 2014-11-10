# server.R

# Load mtcars dataset for server.
data(mtcars)
mcars=mtcars[,-c(5,7,8)]

# Model the dataset for linear regression.
fit=lm(mpg~.,mcars)

# Define the function to calculate mpg - fuel efficiency.
mimpg=function(cyl,disp,hp,wt,am,gear,carb) {
    cyl=as.numeric(cyl);gear=as.numeric(gear);carb=as.numeric(carb)
    am=as.numeric(am)
    fit$coef[[1]]+fit$coef[[2]]*cyl+fit$coef[[3]]*disp+fit$coef[[4]]*hp+
        fit$coef[[5]]*wt+fit$coef[[6]]*am+fit$coef[[7]]*gear+fit$coef[[8]]*carb
}


# Set up the Shiny Server
shinyServer(function(input, output) {
    
    # Set up reactive codes for the output.
    mpg=reactive({round(mimpg(input$cyl,input$disp,input$hp,
                    input$wt,input$am,input$gear,input$carb),2)})
    kmpl=reactive({round(mpg()*1.609/3.785,2)})
    
    # Define the outputs.
    output$mileagempg=renderText({paste(mpg(),'mpg \50Miles Per Gallon\51')})
    output$mileagekmpl=renderText({paste(kmpl(),'kmpl \50Kilometers Per Litre\51')})
})