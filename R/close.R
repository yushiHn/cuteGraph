#' @title close
#' @description
#' Close only specific graphic windows (devices).
#' @param kind Vector, among c("windows", "quartz", "x11", "X11", "pdf", "bmp", "png", "tiff"), indicating the kind of graphic windows (devices) to close. BEWARE: either "windows", "quartz", "x11" or "X11" means that all the X11 GUI graphics devices will be closed, whatever the OS used.
#' @param return.text Single logical value. Print text regarding the kind parameter and the devices that were finally closed?
#' @returns Text regarding the kind parameter and the devices that were finally closed.
#' @details 
#' REQUIRED PACKAGES
#' 
#' cuteDev
#' 
#' 
#' REQUIRED FUNCTIONS FROM THE cute PACKAGE
#' 
#' arg_check()
#' @examples
#' \dontrun{
#' # Screen devices should not be used in examples
#' windows() ; 
#' windows() ; 
#' }
#' pdf() ; 
#' grDevices::dev.list() ; 
#' close(kind = c("pdf", "x11"), return.text = TRUE) ; 
#' grDevices::dev.list()
#' @importFrom cuteDev arg_check
#' @importFrom grDevices x11
#' @importFrom grDevices dev.list
#' @importFrom grDevices dev.off
#' @export
close <- function(
        kind = "pdf", 
        return.text = FALSE
){
    # DEBUGGING
    # kind = c("windows", "pdf") ; return.text = FALSE # for function debugging
    # package name
    package.name <- "cuteGraph"
    # end package name
    # function name
    ini <- match.call(expand.dots = FALSE) # initial parameters (specific of arg_test())
    function.name <- paste0(as.list(match.call(expand.dots = FALSE))[[1]], "()") # function name with "()" paste, which split into a vector of three: c("::()", "package()", "function()") if "package::function()" is used.
    if(function.name[1] == "::()"){
        function.name <- function.name[3]
    }
    arg.names <- names(formals(fun = sys.function(sys.parent(n = 2)))) # names of all the arguments
    arg.user.setting <- as.list(match.call(expand.dots = FALSE))[-1] # list of the argument settings (excluding default values not provided by the user)
    # end function name
    
    # package checking
    # check of lib.path
    # end check of lib.path
    # check of the required function from the required packages
    .pack_and_function_check(
        fun = c(
            "cuteDev::arg_check"
        ),
        lib.path = NULL,
        external.function.name = function.name
    )
    
    # end check of the required function from the required packages
    # end package checking
    
    
    # argument primary checking
    # arg with no default values
    # end arg with no default values
    # argument checking with arg_check()
    argum.check <- NULL #
    text.check <- NULL #
    checked.arg.names <- NULL # for function debbuging: used by r_debugging_tools
    ee <- expression(argum.check = c(argum.check, tempo$problem) , text.check = c(text.check, tempo$text) , checked.arg.names = c(checked.arg.names, tempo$object.name))
    tempo <- cuteDev::arg_check(data = kind, options = c("windows", "quartz", "x11", "X11", "pdf", "bmp", "png", "tiff"), fun.name = function.name) ; eval(ee)
    tempo <- cuteDev::arg_check(data = return.text, class = "logical", length = 1, fun.name = function.name) ; eval(ee)
    if( ! is.null(argum.check)){
        if(any(argum.check, na.rm = TRUE) == TRUE){
            stop(paste0("\n\n================\n\n", paste(text.check[argum.check], collapse = "\n"), "\n\n================\n\n"), call. = FALSE) #
        }
    }
    # end argument checking with arg_check()
    # check with r_debugging_tools
    # source("C:/Users/yhan/Documents/Git_projects/debugging_tools_for_r_dev/r_debugging_tools.R") ; eval(parse(text = str_basic_arg_check_dev)) ; eval(parse(text = str_arg_check_with_fun_check_dev)) # activate this line and use the function (with no arguments left as NULL) to check arguments status and if they have been checked using cuteDev::arg_check()
    # end check with r_debugging_tools
    # end argument primary checking
    
    # second round of checking and data preparation
    # management of NA arguments
    if( ! (all(class(arg.user.setting) == "list", na.rm = TRUE) & length(arg.user.setting) == 0)){
        tempo.arg <- names(arg.user.setting) # values provided by the user
        tempo.log <- suppressWarnings(sapply(lapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = is.na), FUN = any)) & lapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = length) == 1L # no argument provided by the user can be just NA
        if(any(tempo.log) == TRUE){ # normally no NA because is.na() used here
            tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE: \n", ifelse(sum(tempo.log, na.rm = TRUE) > 1, "THESE ARGUMENTS", "THIS ARGUMENT"), " CANNOT JUST BE NA:", paste0(tempo.arg[tempo.log], collapse = "\n"))
            stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
        }
    }
    # end management of NA arguments
    
    # management of NULL arguments
    tempo.arg <-c(
        "kind", 
        "return.text"
    )
    tempo.log <- sapply(lapply(tempo.arg, FUN = get, env = sys.nframe(), inherit = FALSE), FUN = is.null)
    if(any(tempo.log) == TRUE){# normally no NA with is.null()
        tempo.cat <- paste0("ERROR IN ", function.name, " OF THE ", package.name, " PACKAGE:\n", ifelse(sum(tempo.log, na.rm = TRUE) > 1, "THESE ARGUMENTS\n", "THIS ARGUMENT\n"), paste0(tempo.arg[tempo.log], collapse = "\n"),"\nCANNOT BE NULL")
        stop(paste0("\n\n================\n\n", tempo.cat, "\n\n================\n\n"), call. = FALSE) # == in stop() to be able to add several messages between ==
    }
    # end management of NULL arguments
    
    # code that protects set.seed() in the global environment
    # end code that protects set.seed() in the global environment
    
    # warning initiation
    # end warning initiation
    
    # other checkings
    # end other checkings
    
    # reserved words (to avoid bugs)
    # end reserved words (to avoid bugs)
    # end second round of checking and data preparation
    
    # main code
    text <- paste0("THE REQUIRED KIND OF GRAPHIC DEVICES TO CLOSE ARE ", paste(kind, collapse = " "))
    if(Sys.info()["sysname"] == "Windows"){ # Note that .Platform$OS.type() only says "unix" for macOS and Linux and "Windows" for Windows
        if(any(kind %in% c("windows", "quartz", "x11", "X11"))){
            tempo <- kind %in% c("windows", "quartz", "x11", "X11")
            kind[tempo] <- "windows" # term are replaced by what is displayed when using a <- grDevices::dev.list() ; names(a)
        }
    }else if(Sys.info()["sysname"] == "Linux"){
        if(any(kind %in% c("windows", "quartz", "x11", "X11"))){
            tempo.device <- suppressWarnings(try(grDevices::X11(), silent = TRUE))[] # open a X11 window to try to recover the X11 system used
            if( ! is.null(tempo.device)){
                text <- paste0(text, "\nCANNOT CLOSE GUI GRAPHIC DEVICES AS REQUIRED BECAUSE THIS LINUX SYSTEM DOES NOT HAVE IT")
            }else{
                tempo <- kind %in% c("windows", "quartz", "x11", "X11")
                kind[tempo] <- names(grDevices::dev.list()[length(grDevices::dev.list())]) # term are replaced by what is displayed when using a <- grDevices::dev.list() ; names(a)
                invisible(grDevices::dev.off()) # close the X11 opened by tempo
            }
        }
    }else{ # for macOS
        if(any(kind %in% c("windows", "quartz", "x11", "X11"))){
            tempo <- kind %in% c("windows", "quartz", "x11", "X11")
            kind[tempo] <- "quartz" # term are replaced by what is displayed when using a <- grDevices::dev.list() ; names(a)
        }
    }
    kind <- unique(kind)
    if(length(grDevices::dev.list()) != 0){
        for(i in length(names(grDevices::dev.list())):1){
            if(names(grDevices::dev.list())[i] %in% kind){
                text <- paste0(text, "\n", names(grDevices::dev.list())[i], " DEVICE NUMBER ", grDevices::dev.list()[i], " HAS BEEN CLOSED")
                invisible(grDevices::dev.off(grDevices::dev.list()[i]))
            }
        }
    }
    # output
    # warning output
    # end warning output
    if(return.text == TRUE){
        return(text)
    }
    # end output
    # end main code
}

