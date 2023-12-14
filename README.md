Readme
================

## Scope

This is a very small sample shiny app to illustrate how to work with
files in the server operating system in a reactive mode.

Even when run on one’s own local computer, a Shiny app contains both a
client part and a server part that communicate through the TCP/IP
network. Thus, the included `fileInput` function supplied with shiny
works by “uploading” files through the network from the browser
environment, and `downloadHandler` saves files by transferring them
through the network to the users Downloads directory (typically), even
though the both parts of Shiny ar running on the same computer.

It can be simpler and more efficient to simply load files into the Shiny
R server using normal file read and write functions, but having a user
dialog to give control over which files are read or written to is still
needed. Enter the `shinyFiles` package.

## Reactive flow

![](README_files/figure-gfm/digraph-1.png)<!-- -->

- `input$file1`: character, path to selected input file
- `parseFilePaths`: function, works in conjunction with
  `shinyFileChoose` to provide a data frame of one or more rows
  describing the file name and directory.
- `finfo`: data frame, containing name of file and full path to file
  (`datapath`).
- `fnamer`: reactive path to input filename. As this is updated, any
  reactives that depend upon it and get directly or indirectly triggered
  by a need to display output will get updated.
- `read.csv`: function, any R input function can be used as needed… this
  is just to show how it is used.
- `dtar`: reactive data frame containing contents of input file.
- `muck`: function to serve as an example of doing “something” to a data
  frame.
- `fname_muckr`: sample way to create an output filename based on the
  input filename.
- `write_muck`: function to write out the modified data frame to a new
  output file. Returns something to display on the screen to indicate
  whether it succeeded… in this case, the number of rows that were
  processed. The item to display on the screen is not important of
  itself, but the fact that it needs to be displayed is what causes
  Shiny to start working through the dependency graph of the reactive
  objects, causing the the whole chain of dependencies to be executed.
