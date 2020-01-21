# AssignmentEthereum

## Design principles

<p align="center">
    <img src="https://www.objc.io/images/issue-13/2014-06-07-viper-intro-0a53d9f8.jpg" alt="VIPER" height="200px">
</p>

For this project I choose VIPER architecture to implement it.

In addition to the VIPER components View, Interactor, Presenter, Entity and Routing I added the Builder and the Worker.
<p align="center">
    <img src="https://www.objc.io/images/issue-13/2014-06-07-viper-wireframe-76305b6d.png" alt="VIPER" height="280px">
</p>

The project is divided in scenes, each scene have the View, Presenter, Router, ViewModels and Builder. The builder is in charge of instantiate all the components needed for each scene and add Interactors if bussiness layer is needed.
Each interactor is a Use Case and are called from the Presenter. Each interactor have one or more Workers the ones needed for the Use Case. In bussines layer Domain models are used and on the presentation layer these models are transformed to view models to use on the presentation layer.
