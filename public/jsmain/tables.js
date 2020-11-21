fetch("/lala")
            .then(response => response.json())
            .then(json => {
                // console.log("json",json.maindata)

                let data = json.maindata
                // let li = `<tr><th>Name</th><th>Click To Help</th></tr>`;
                let li = `<tr><th>Name</th><th>Click To Help</th><th>Map</th></tr>`;

                for(i=0;i<1;i++){
                    for(j=0;j<3;j++){
                        source = "https://www.google.com/maps?saddr=My+Location&daddr="+data[i+1][j]+","+data[i+2][j]
                        source2 = "https://maps.google.com/maps?q="+data[i+1][j]+"%2C"+data[i+2][j]+"&t=&z=7&ie=UTF8&iwloc=&output=embed"
                        // li +=   `<tr> 
                        //             <td>${data[i][j]} </td> 
                        //             <td><a href=${source}>Help Her</a></td>
                        //         </tr>`; 
                        li +=   `<tr> 
                                <td>${data[i][j]} </td> 
                                <td><a href=${source}>Help Her</a></td>
                                <td><div class="mapouter"><div class="gmap_canvas"><iframe width="200" height="200" id="gmap_canvas" src=${source2} frameborder="0" scrolling="no" marginheight="0" marginwidth="0"></iframe><a href="https://yggtorrent-fr.com">hides</a></div><style>.mapouter{position:relative;text-align:right;height:200px;width:200px;}.gmap_canvas {overflow:hidden;background:none!important;height:200px;width:200px;}</style></div></td>
                            </tr>`; 
                                
                    }
                }

                document.getElementById("people").innerHTML = li; 
            });