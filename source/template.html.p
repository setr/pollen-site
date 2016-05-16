<html>
    <head>
        <meta charset="UTF-8"/>
        <!-- highlighting is now handled server-side using pygments
        <script src="../../js/highlight.pack.js"></script>
        <script>hljs.initHighlightingOnLoad();</script>
        -->

        <link href='https://fonts.googleapis.com/css?family=Montserrat:400,700' rel='stylesheet' type='text/css' data-mincss="ignore" />
        <link href='https://fonts.googleapis.com/css?family=Source+Code+Pro:400,700' rel='stylesheet' type='text/css' data-mincss="ignore" />
        <link rel="stylesheet" href="/css/mangled.css"/>

    </head>
    <body>
        <div id="sidebar">
            <div id="logo">
                <!-- img link -->
            </div>
            <div id="sidebar-links">
                <p>
                    <!-- list of links -->
                    <a> Index </a>

                    <a> Keys </a>

                    <a> Mine </a>
                </p>
            </div>
        </div>
        ◊(->html `(h1 ((id "title")) ,(select-from-metas 'title here)))
        ◊when/splice[(select-from-metas 'tags here)]{
            ◊(->html `(div ((class "tags"))
                        ,@(format-cats (select-from-metas 'tags here))))
        }

            ◊(->html doc #:splice #t)

    </body>
</html>
