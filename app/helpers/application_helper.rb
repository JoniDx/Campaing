module ApplicationHelper
    def nav_dashboard(rol)
        campaing           = "<li class='nav-item'><a class='nav-link' href='/campaigns'>Campaña</a></li>"
        lider           = "<li class='nav-item'><a class='nav-link' href='/lider/create'>Lider</a></li>"
        votante           = "<li class='nav-item'><a class='nav-link' href='/voters'>Votante</a></li>"

        enlaces =  {
            'administrador': [campaing, lider, votante],
            'administrador-campaña':  [campaing, lider, votante],
            'lider':  [votante],
        }

        nav = "<nav class='navbar navbar-expand-lg navbar-light bg-light'>
                <a class='navbar-brand' href='/'>Campañas</a>
                <button class='navbar-toggler' type='button' data-toggle='collapse' data-target='#navbarNav' aria-controls='navbarNav' aria-expanded='false' aria-label='Toggle navigation'>
                    <span class='navbar-toggler-icon'></span>
                </button>
                <div class='collapse navbar-collapse' id='navbarNav'>
                    <ul class='navbar-nav mr-auto my-2 my-lg-0 navbar-nav-scroll'>"
                    enlaces[:"#{rol}"].each { |enlace| nav +=  enlace }   
        nav += "#{ button_to 'Exit', destroy_user_session_path, method: :delete  }</ul></div></nav>"
        nav.html_safe
    end

end
