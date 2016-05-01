#lang pollen
div {
    display: block; }
div#sidebar-links a {
    color:black;
}

@media screen and (min-width: 930px){
    div#sidebar {
        padding: 0.5em;
        margin-left: -27%;
        margin-top: -3%;
        margin-bottom:-50%;
        width: 96px;
        float: left;
        word-break: break-all; }

    div#logo {
        margin-left: -80px; }

    div#sidebar-links a {
        display: block;
        font-size: 105%;
        text-decoration: none;
        margin-bottom: 5px;
        text-transform: uppercase;
        }
}

@media screen and (max-width: 929px){
    div#sidebar-links p {
        word-spacing: 11rem;
    }
}
