# Bionexo coding challenge

On bionexo.com, people usually open quotations through web panel. Wouldn't it be
great if there was a more nerdy way to enter your data? How about a
CLI?

## The task

Build a standalone app that allows users to list their quotations via a
CLI. For the sake of simplicity, the data is kept locally. Similar to
the web app it should be possible to enter partial data and continue
later. However, make sure that in the end all required data is
present. Only when all data is present the newly created quotation
should appear in the list of all properties.

* Allow users to create new quotation from the command line
* Prompt for attributes, validate the input
* When the data entry is interrupted, provide a way to resume entering data
* Store the quotation in some local storage; make sure no invalid data
  is stored
* Every quotation has the following attributes
  * title
  * address
  * email
  * phone number
  * product, with
    * name
    * quantity
  * quotation type, which is one of
    * emergencial
    * standard
    * private

An example session could look like this:

    $ bionexo list
    No quotation found.

    $ bionexo new
    Starting with new quotation ABC1DEF2.

    Title: Amazing quotation of Albert Einstein
    Address: ^C

    $ bionexo list
    No quotations found.

    $ bionexo continue ABC1DEF2
    Continuing with ABC1DEF2

    Address: 1 Infinite Loop, Cupertino, CA 95014, United States
    Email: foo@bionexo.com
    Phone Number: +55 (11) 99999-9999
    Product Name: Novalgina
    Product quantity: foo
    
    Error: must be a number

    ^C
    $ bionexo continue ABC1DEF2
    Continuing with ABC1DEF2

    Product quantity: 10

    Great job! Listing ABC1DEF2 is complete!

    $ bionexo list
    Found 1 offer.

    ABC1DEF2: Amazing quotation of Albert Einstein

## Hints

It's totally fine to use 3rd party libraries like ruby's gems. You're
free to choose your storage mechanism/database. Just use the right
tool for the job.

Happy hacking!
