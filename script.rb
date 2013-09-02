87 Sketchup.status_text = "Simulación en curso. Espere!!!"
88 time = Site.get_datetime()
89 e_y = @mod.sim_module_at_year(time)
90 Sketchup.status_text = "Simulación completa!!!"
91 month = 1
92 n_day_month = N_DAY_MONTH[(time.month - 1)]
93 n_day_month += 1 if((time.month == 2)&&(Site.leap_year?() == true))
94 title = "Factor de sombreado y media de irradiación diaria anual;;;;;;;\n"
95 datetime = "Ano:;#{time.strftime("%Y")};;;;;Tempo:;#{((Time.now - start)/60.0).round_to(6)} min\n"
96 header = "Mês;Fs;Ht (kWh/m²);Hts (kWh/m²);Hdt (kWh/m²);Hdts (kWh/m²);E (W);Es (W)\n"
97 b = ""
98 for e in e_y do
99 if(month < e_y.size)then
100 e.convert_to(ModuleEnergy::KWH,n_day_month)
101 b << "-#{sprintf("%.0f",month)};#{sprintf("%.3f",e.fs)};#{sprintf("%.3f",e.i_t)};#{sprintf("%.3f",e.i_ts)};#{sprintf("%.3f",e.i_d)};#{sprintf("%.3f",e.i_ds)};#{sprintf("%.3f",e.e_t)};#{sprintf("%.3f",e.e_ts)}_\n"
102 elsif(month == e_y.size)
103 if(Site.leap_year?() == true)
104 n_year = 366
105 else
106 n_year = 365
107 end
108 e.convert_to(ModuleEnergy::KWH,n_year)
109 b << "-Ano;#{sprintf("%.3f",e.fs)};#{sprintf("%.3f",e.i_t)};#{sprintf("%.3f",e.i_ts)};#{sprintf("%.3f",e.i_d)};#{sprintf("%.3f",e.i_ds)};#{sprintf("%.3f",e.e_t)};#{sprintf("%.3f",e.e_ts)}_\n"
110 end
111 month += 1
112 end
113 body = b
114 end
115 data = ""
116 data << title
117 data << datetime
118 data << header
119 data << body
120 data << ";;;;;;"
121 data.gsub!('.',',')
122 data.gsub!('-','')
123 data.gsub!('_','')
124 @mod.file_append(data)
125 title.gsub!(';','')
126 header.gsub!(';','</th><th scope="col">')
127 header.gsub!('²','&sup2;')
128 header.gsub!('ê','&ecirc;')
129 body.gsub!('.', ',')
130 body.gsub!('-','<tr align="center" style="font-family:Arial, Helvetica, sans-serif; color:#0033FF"><td>')
131 body.gsub!('_','</td></tr>')
132 body.gsub!(';','</td><td>')
133 body.gsub!('ê','&ecirc;')
134 datetime.gsub!(';',' ')
135 datetime.gsub!('ê','&ecirc;')
136 html = "<table width='700' border='2' align='center' cellpadding='0' cellspacing='0' bordercolor='#000033' bgcolor='#FFFFFF'>"
137 html << "<tr align='center' style='font-family:Arial, Helvetica, sans-serif; color:#000033'><th scope='col'>#{header}</th></tr>"
138 html << "#{body}"
139 html << "</table>"
140 html << "<p align='center' style='font-family:Arial, Helvetica, sans-serif; color:#000033'>#{datetime}</p>"
141 dlg = UI::WebDialog.new(title, true,"Solar3DBR",700, 450, 150, 150, true);
142 dlg.set_html(html)
143 dlg.show
144 end
145
146 end


