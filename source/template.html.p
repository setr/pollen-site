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
        <div id="grid">
            <div id="left">
                <div id="sidebar">
                    <ul>
                        <li> <a> Index </a> </li>
                        <li> <a> Keys </a> </li>
                        <li> <a> Mine </a> </li>
                    </ul>
                </div>
            </div>

            <div id="right">
                <div id="header">
                    ◊(->html `(h1 ,(select-from-metas 'title here)))
                    ◊when/splice[(select-from-metas 'tags here)]{
                        ◊(->html `(div ((class "tags"))
                            ,@(format-cats (select-from-metas 'tags here))))
                    }
                </div>

                <div id="content">
                    ◊(->html doc #:splice #t)
                </div>
            </div>
        </div>
    </body>
</html>
