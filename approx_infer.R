#Approximate Inference

#Get values for predictive variables from get_streamflow and get_precip scripts
source('get_streamflow.R')
source('get_precip.R')


#Construct queries
if(!is.null(utahlakeSpringQ) & !is.null(utahlakeJunePrecip)){
  julypredvals <- c(utahlakeSpringQ,utahlakeJunePrecip)
  julystr = paste("(", c("SpringQ","JunePrecip"), " == '",
                  sapply(julypredvals, as.character), "')",
                  sep = "", collapse = " & ")
}
if(!is.null(utahlakeSpringQ) & is.null(utahlakeJunePrecip)){
  julypredvals <- c(utahlakeSpringQ)
  julystr = paste("(SpringQ", " == '",
                  sapply(julypredvals, as.character), "')",
                  sep = "", collapse = " & ")
}
if(is.null(utahlakeSpringQ) & !is.null(utahlakeJunePrecip)){
  julypredvals <- c(utahlakeJunePrecip)
  julystr = paste("(JunePrecip", " == '",
                  sapply(julypredvals, as.character), "')",
                  sep = "", collapse = " & ")
}

if(!is.null(utahlakeSpringQ) & !is.null(utahlakeJulyPrecip)){
  augpredvals <- c(utahlakeSpringQ,utahlakeJulyPrecip)
  augstr = paste("(", c("SpringQ","JulyPrecip"), " == '",
                  sapply(augpredvals, as.character), "')",
                  sep = "", collapse = " & ")
}
if(!is.null(utahlakeSpringQ) & is.null(utahlakeJulyPrecip)){
  augpredvals <- c(utahlakeSpringQ)
  augstr = paste("(SpringQ", " == '",
                  sapply(augpredvals, as.character), "')",
                  sep = "", collapse = " & ")
}
if(is.null(utahlakeSpringQ) & !is.null(utahlakeJulyPrecip)){
  augpredvals <- c(utahlakeJulyPrecip)
  augstr = paste("(JulyPrecip", " == '",
                  sapply(augpredvals, as.character), "')",
                  sep = "", collapse = " & ")
}




julygt_cmd = paste("cpquery(bnchl,JulyAvg=='> Median',",julystr,")", sep = "")
julygtprob <- ceiling(eval(parse(text = julygt_cmd))*100)

auggt_cmd = paste("cpquery(bnchl,AugAvg=='> Median',",augstr,")", sep = "")
auggtprob <- ceiling(eval(parse(text = auggt_cmd))*100)

if(julygtprob>50 & !is.null(utahlakeAugPrecip)){
  septpredvals <- c("> Median",utahlakeAugPrecip)
  septstr = paste("(", c("JulyAvg","AugPrecip"), " == '",
                 sapply(septpredvals, as.character), "')",
                 sep = "", collapse = " & ")
}
if(julygtprob>50 & is.null(utahlakeAugPrecip)){
  septpredvals <- c("> Median")
  septstr = paste("(", c("JulyAvg"), " == '",
                  sapply(septpredvals, as.character), "')",
                  sep = "", collapse = " & ")
}
if(julygtprob<50 & !is.null(utahlakeAugPrecip)){
  septpredvals <- c("< Median",utahlakeAugPrecip)
  septstr = paste("(", c("JulyAvg","AugPrecip"), " == '",
                  sapply(septpredvals, as.character), "')",
                  sep = "", collapse = " & ")
}
if(julygtprob<50 & is.null(utahlakeAugPrecip)){
  septpredvals <- c("< Median")
  septstr = paste("(", c("JulyAvg"), " == '",
                  sapply(septpredvals, as.character), "')",
                  sep = "", collapse = " & ")
}

septgt_cmd = paste("cpquery(bnchl,SeptAvg=='> Median',",septstr,")", sep = "")
septgtprob <- ceiling(eval(parse(text = septgt_cmd))*100)
